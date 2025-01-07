import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:denta_koas/src/cores/data/repositories/schedules.repository/shcedule_repository.dart';
import 'package:denta_koas/src/features/appointment/data/model/schedules_model.dart';
import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/helpers/network_manager.dart';
import 'package:denta_koas/src/utils/popups/full_screen_loader.dart';
import 'package:denta_koas/src/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SchedulePostController extends GetxController {
  static SchedulePostController get instance => Get.find();

  var selectedIndex = 0.obs;
  var selectedDate = DateTime.now().obs;

  var selectedDateRange = <DateTime?>[].obs;

  final GlobalKey<FormState> schedulePostFormKey = GlobalKey<FormState>();

  final calendarRangeConfig = CalendarDatePicker2Config(
    calendarType: CalendarDatePicker2Type.range,
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
    selectedDayHighlightColor: TColors.primary,
    weekdayLabelTextStyle: const TextStyle(color: TColors.grey),
    controlsTextStyle: const TextStyle(color: TColors.primary),
  );

  void createGeneralInformation() async {
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

      // Validate the form
      if (!schedulePostFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Initialize the model for the schedule post
      final schedulePost = SchedulesModel(
        dateStart: dateStartValue,
        dateEnd: dateEndValue,
      );

      // Create the post schedule
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

      // Init timeslots for the schedule
      // final newTimeSlots = TimeslotModel(
      //   scheduleId: currentScheduleId,
      //   startTime: ,
      //   endTime: ,
      // )

      // final timeslotRepository = Get.put(TimeslotRepository());
      // await timeslotRepository.createTimeslot(newPostSchedule);

      // Close loading
      TFullScreenLoader.stopLoading();

      // Success message
      TLoaders.successSnackBar(
        title: 'Success',
        message: 'Post has been created',
      );

      // Navigate to next screen
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
        title: 'Error',
        message: e.toString(),
      );
    }
  }

  void updateSelectedDay(int index) {
    selectedIndex.value = index;
  }

  void updateSelectedDate(DateTime date) {
    selectedDate.value = date;
  }

  String formatSelectedDateRange() {
    return selectedDateRange.map((date) {
      if (date != null) {
        return "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
      }
      return '';
    }).join(', ');
  }

  DateTime? get dateStartValue =>
      selectedDateRange.isNotEmpty ? selectedDateRange.first : null;
  DateTime? get dateEndValue =>
      selectedDateRange.length > 1 ? selectedDateRange.last : null;

}
