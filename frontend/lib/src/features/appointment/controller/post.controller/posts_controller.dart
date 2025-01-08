import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:denta_koas/navigation_menu.dart';
import 'package:denta_koas/src/commons/widgets/state_screeen/state_screen.dart';
import 'package:denta_koas/src/cores/data/repositories/post.repository/post_repository.dart';
import 'package:denta_koas/src/cores/data/repositories/schedules.repository/shcedule_repository.dart';
import 'package:denta_koas/src/cores/data/repositories/timeslot.repository/timeslot_repository.dart';
import 'package:denta_koas/src/features/appointment/controller/post.controller/general_information_controller.dart';
import 'package:denta_koas/src/features/appointment/controller/post.controller/schedule_controller.dart';
import 'package:denta_koas/src/features/appointment/controller/post.controller/timeslot_controller.dart';
import 'package:denta_koas/src/features/appointment/data/model/post_model.dart';
import 'package:denta_koas/src/features/appointment/data/model/schedules_model.dart';
import 'package:denta_koas/src/features/personalization/controller/user_controller.dart';
import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/helpers/network_manager.dart';
import 'package:denta_koas/src/utils/popups/full_screen_loader.dart';
import 'package:denta_koas/src/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class PostController extends GetxController {
  static PostController get instance => Get.find<PostController>();

  final calendarController = CalendarController();
  final timeController = TimeController();
  final inputController = InputController();

  RxList<PostModel> posts = <PostModel>[].obs;
  RxList<PostModel> postUser = <PostModel>[].obs;

  final isLoading = false.obs;

  final postRepository = Get.put(PostRepository());

  var generalInfo = {}.obs;
  var scheduleInfo = [].obs;

  var koasName = ''.obs;
  var selectedDate = ''.obs;
  var selectedTime = ''.obs;

  final selectedStatus = 'Open'.obs;

  // General information
  final title = TextEditingController();
  final description = TextEditingController();
  final requiredParticipant = TextEditingController();
  final treatmentType = TextEditingController();
  final patientRequirment = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    fetchPostUser();
  }

  fetchPostUser() async {
    try {
      isLoading.value = true;
      final postsData = await postRepository.getPostCurrentUser();
      posts.assignAll(postsData);

      // filter
      postUser.assignAll(
        posts.where((post) => post.status != StatusPost.Closed).toList(),
      );

      Logger().i('Post : $postUser');
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void createPost() async {
    try {
      // Start loading
      TFullScreenLoader.openLoadingDialog(
          'Proceccing your action....', TImages.loadingHealth);

      // Check connection
      final isConected = await NetworkManager.instance.isConnected();
      if (!isConected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      final inputController = Get.put(InputController());
      final values = inputController.getAllValues();

      final title = GeneralInformationController.instance.title.text.trim();
      final description =
          GeneralInformationController.instance.description.text.trim();
      final selectedTreatmentId =
          GeneralInformationController.instance.selectedTreatmentId;
      final requiredParticipant = GeneralInformationController.instance
          .convertToInt(GeneralInformationController
              .instance.requiredParticipant.text
              .trim());

      // Initialize the model for general information post
      final newPost = PostModel(
        userId: UserController.instance.user.value.id,
        koasId: UserController.instance.user.value.koasProfile!.id!,
        title: title,
        desc: description,
        requiredParticipant: requiredParticipant,
        patientRequirement: values,
        treatmentId: selectedTreatmentId,
      );

      final post = await PostRepository.instance.createPost(newPost);

      // Get current postId from the server
      final postId = post.id;
      final postRequiredParticipant = post.requiredParticipant;

      if (postId == null) {
        TLoaders.errorSnackBar(
          title: 'Error',
          message: 'Failed to fetch post id from the server',
        );
        return;
      }

      final dateStartValue = SchedulePostController.instance.dateStartValue;
      final dateEndValue = SchedulePostController.instance.dateEndValue;

      // Create the post schedule
      final schedulePost = SchedulesModel(
        postId: postId,
        dateStart: dateStartValue,
        dateEnd: dateEndValue,
      );

      // Send the data to the server
      final scheduleRepository = Get.put(SchedulesRepository());
      final newPostSchedule =
          await scheduleRepository.createSchedule(schedulePost);

      final currentScheduleId = newPostSchedule.id;

      if (currentScheduleId == null) {
        TFullScreenLoader.stopLoading();
        TLoaders.errorSnackBar(
          title: 'Error',
          message: 'Failed to create post schedule',
        );
        return;
      }

      // Init timeslots controller to get all timeslots
      final timeslotController = Get.put(PostTimeslotController());
      final newTimeslots =
          timeslotController.getAllTimeSlotsForApi(newPostSchedule.id!);

      // Create batch timeslots
      final timeslotRepository = Get.put(TimeslotRepository());
      await timeslotRepository.createBatchTimeslots(
          newPostSchedule.id!, newTimeslots);

      final postStatus = PostModel(
        id: postId,
        status: StatusPost.values.firstWhere(
            (e) => e.toString() == 'StatusPost.${selectedStatus.value}'),
      );

      // Update post status
      await postRepository.updatePost(postId, postStatus);

      // Close loading
      TFullScreenLoader.stopLoading();

      // Success message
      TLoaders.successSnackBar(
        title: 'Congratulations!',
        message: 'Post has been created',
      );

      // Navigate to next screen
      Get.off(() => StateScreen(
            image: TImages.successCreatePost,
            title: 'Your post has been created successfully!',
            subtitle:
                'Congratulations! Your post is now live and ready for participants.',
            showButton: true,
            primaryButtonTitle: 'Go to Dashboard',
            onPressed: () => Get.to(() => const NavigationMenu()),
          ));

      // Auto redirect after a delay
      Future.delayed(const Duration(seconds: 3), () {
        Get.to(() => const NavigationMenu());
      });
    } catch (e) {
      TFullScreenLoader.stopLoading();
      Logger().e('Error creating post: $e');
      TLoaders.errorSnackBar(
        title: 'Error',
        message: e.toString(),
      );
    }
  }

  // Fungsi untuk menyimpan data General Information
  void setGeneralInfo(Map<String, dynamic> generalInformation) {
    generalInfo.value = generalInformation;
  }

  // Fungsi untuk menyimpan data Schedule
  void setSchedule(List<Map<String, dynamic>> schedules) {
    scheduleInfo.value = schedules;
  }

  void updatePreviewAppointment(String name, String date, String time) {
    koasName.value = name;
    selectedDate.value = date;
    selectedTime.value = time;
  }

  setStatusColor(StatusPost status) async {
    Color statusColor;
    switch (status) {
      case StatusPost.Pending:
        statusColor = TColors.warning;
        break;
      case StatusPost.Open:
        statusColor = TColors.success;
        break;
      case StatusPost.Closed:
        statusColor = TColors.error;
        break;
    }
  }
}

class CalendarController extends GetxController {
  static CalendarController get instance => Get.find<CalendarController>();

  var selectedIndex = 0.obs;
  var selectedDate = DateTime.now().obs;

  var selectedDateRange = <DateTime?>[].obs;

  final calendarRangeConfig = CalendarDatePicker2Config(
    calendarType: CalendarDatePicker2Type.range,
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
    selectedDayHighlightColor: TColors.primary,
    weekdayLabelTextStyle: const TextStyle(color: TColors.grey),
    controlsTextStyle: const TextStyle(color: TColors.primary),
  );

  void updateSelectedDay(int index) {
    selectedIndex.value = index;
  }

  void updateSelectedDate(DateTime date) {
    selectedDate.value = date;
  }
}

class TimeController extends GetxController {
  static TimeController get instance => Get.find<TimeController>();

  var tooltipShown = false;

  var requiredParticipants = 0.obs;

  // Observables
  var sessionDuration = const Duration(hours: 1).obs;
  var timeSlots = <String, List<String>>{
    'Pagi': [],
    'Siang': [],
    'Malam': [],
  }.obs;

  var maxParticipants = <String, Map<String, int>>{
    'Pagi': {},
    'Siang': {},
    'Malam': {},
  }.obs;

  void setRequiredParticipants(int requiredParticipant) {
    requiredParticipants.value = requiredParticipant;
  }

// Tambahkan timeslot baru
  void addTimeSlot(String section, TimeOfDay startTime) {
    final DateTime now = DateTime.now();
    final DateTime startDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      startTime.hour,
      startTime.minute,
    );
    final DateTime endDateTime = startDateTime.add(sessionDuration.value);

    final String timeSlot =
        "${startDateTime.hour.toString().padLeft(2, '0')}:${startDateTime.minute.toString().padLeft(2, '0')} - "
        "${endDateTime.hour.toString().padLeft(2, '0')}:${endDateTime.minute.toString().padLeft(2, '0')}";

    // Menambahkan timeslot baru
    timeSlots[section]?.add(timeSlot);
    maxParticipants[section] ??= {};

    // Cek apakah semua section kosong atau tidak
    bool allSectionsEmpty =
        maxParticipants.values.every((slots) => slots.isEmpty);
    maxParticipants[section]![timeSlot] = 1;

    // Mengurangi peserta dari slot sebelumnya dengan maxParticipants tertinggi di semua section
    for (var sec in timeSlots.keys) {
      if (timeSlots[sec]?.isNotEmpty ?? false) {
        // Menemukan timeslot dengan maxParticipants tertinggi
        final sortedSlots = maxParticipants[sec]!.entries.toList()
          ..sort((a, b) => b.value
              .compareTo(a.value)); // Mengurutkan berdasarkan maxParticipants
        final previousSlot =
            sortedSlots.isNotEmpty ? sortedSlots.first.key : null;

        if (previousSlot != null && previousSlot != timeSlot) {
          decrementMaxParticipantsForSlot(sec,
              previousSlot); // Mengurangi peserta dari timeslot dengan maxParticipants tertinggi
        }
      }
    }

    timeSlots.refresh(); // Update UI
    update(); // Update UI
  }

// Ubah durasi sesi
  void updateSessionDuration(int hours) {
    sessionDuration.value = Duration(hours: hours);
    _updateAllTimeSlots(); // Perbarui semua slot waktu
  }

// Perbarui semua slot waktu berdasarkan durasi terbaru
  void _updateAllTimeSlots() {
    final updatedSlots = <String, List<String>>{};

    timeSlots.forEach((section, slots) {
      final updatedSectionSlots = <String>[];

      for (var slot in slots) {
        final startTime = _parseTime(slot.split(' - ')[0]);
        final startDateTime = DateTime(
          DateTime.now().year,
          DateTime.now().month,
          DateTime.now().day,
          startTime.hour,
          startTime.minute,
        );
        final endDateTime = startDateTime.add(sessionDuration.value);

        final updatedSlot =
            "${startDateTime.hour.toString().padLeft(2, '0')}:${startDateTime.minute.toString().padLeft(2, '0')} - "
            "${endDateTime.hour.toString().padLeft(2, '0')}:${endDateTime.minute.toString().padLeft(2, '0')}";
        updatedSectionSlots.add(updatedSlot);
      }

      updatedSlots[section] = updatedSectionSlots;
    });

    timeSlots.value = updatedSlots;
    timeSlots.refresh(); // Update UI
    update(); // Update UI
  }

  // Update jumlah peserta maksimal untuk sesi tertentu
  // void setMaxParticipants(String section, int max) {
  //   if(timeSlots[section] != null) {
  //   maxParticipants[section] = max;
  //   maxParticipants.refresh(); // Update UI
  //   update(); // Update UI
  //   }
  // }

// Helper untuk parsing waktu dari string
  TimeOfDay _parseTime(String time) {
    final parts = time.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);
    return TimeOfDay(hour: hour, minute: minute);
  }

// Hapus timeslot
  void removeTimeSlot(String section, String slot) {
    timeSlots[section]?.remove(slot);
    maxParticipants[section]?.remove(slot);
    timeSlots.refresh(); // Update UI
    maxParticipants.refresh(); // Update UI
    update(); // Update UI
  }

// Get total jumlah peserta maksimal dari semua section
  int get totalMaxParticipants {
    int total = 0;
    maxParticipants.forEach((section, slots) {
      slots.forEach((slot, max) {
        total += max;
      });
    });
    return total;
  }

// Get total jumlah timeslot yang tersedia dari semua section
  int get totalAvailableTimeSlots {
    int total = 0;
    maxParticipants.forEach((section, slots) {
      total += slots.length;
    });
    return total;
  }

// Increment jumlah peserta maksimal untuk slot waktu tertentu
  void incrementMaxParticipantsForSlot(String section, String slot) {
    if (timeSlots[section] != null) {
      maxParticipants[section] ??= {};
      maxParticipants[section]![slot] =
          (maxParticipants[section]![slot] ?? 1) + 1;
      maxParticipants.refresh(); // Update UI
      update(); // Update UI
    }
  }

// Decrement jumlah peserta maksimal untuk slot waktu tertentu
  void decrementMaxParticipantsForSlot(String section, String slot) {
    if (timeSlots[section] != null) {
      maxParticipants[section] ??= {};
      final currentMax = maxParticipants[section]![slot] ?? 1;
      if (currentMax > 1) {
        maxParticipants[section]![slot] = currentMax - 1;
        maxParticipants.refresh(); // Update UI
        update(); // Update UI
      }
    }
  }

// Get jumlah peserta maksimal untuk slot waktu tertentu
  int maxParticipantsForSlot(String section, String slot) {
    return maxParticipants[section]?[slot] ?? 1; // Default value is 1
  }

  Map<String, int> calculateSectionLengths() {
    final sectionLengths = <String, int>{};

    // Hitung jumlah slot per section
    timeSlots.forEach((section, slots) {
      sectionLengths[section] = slots.length;
    });

    return sectionLengths;
  }

  int calculateTotalSlots() {
    int totalSlots = 0;

    // Hitung total semua slot
    timeSlots.forEach((_, slots) {
      totalSlots += slots.length;
    });

    return totalSlots;
  }

  final selectedTimeStamp = (-1).obs;

  void updateSelectedTimeStamp(int index) {
    selectedTimeStamp.value = index;
  }
}

class InputController extends GetxController {
  static InputController get instance => Get.find<InputController>();
  // List of TextEditingController to manage dynamic inputs
  RxList<TextEditingController> patientRequirements =
      <TextEditingController>[].obs;

  /// Initialize the inputs with a default count
  void initializeInputs(int count) {
    if (patientRequirements.isEmpty) {
      for (int i = 0; i < count; i++) {
        patientRequirements.add(TextEditingController());
      }
    }
  }

  /// Add a new input for requirement patient
  void addInputRequirment() {
    patientRequirements.add(TextEditingController());
  }

  /// Remove the input requirement at the specified index
  void removeInputRequirement(int index) {
    if (index >= 0 && index < patientRequirements.length) {
      patientRequirements[index].dispose(); // Hapus controller dari memori
      patientRequirements.removeAt(index);
    }
  }

  /// Get all values from the patientRequirements
  List<String> getAllValues() {
    return patientRequirements.map((controller) => controller.text).toList();
  }

  @override
  void onClose() {
    // Dispose all controllers to free memory
    for (var controller in patientRequirements) {
      controller.dispose();
    }
    super.onClose();
  }
}
