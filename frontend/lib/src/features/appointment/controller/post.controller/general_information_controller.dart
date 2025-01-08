import 'package:denta_koas/src/cores/data/repositories/post.repository/post_repository.dart';
import 'package:denta_koas/src/cores/data/repositories/treatments.repository/treatment_repository.dart';
import 'package:denta_koas/src/features/appointment/controller/post.controller/posts_controller.dart';
import 'package:denta_koas/src/features/appointment/data/model/post_model.dart';
import 'package:denta_koas/src/features/appointment/screen/posts/create_post/schedule/create_schedule.dart';
import 'package:denta_koas/src/features/personalization/controller/user_controller.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/helpers/network_manager.dart';
import 'package:denta_koas/src/utils/popups/full_screen_loader.dart';
import 'package:denta_koas/src/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class GeneralInformationController extends GetxController {
  static GeneralInformationController get instance => Get.find();

  final title = TextEditingController();
  final description = TextEditingController();
  final requiredParticipant = TextEditingController();
  RxList<TextEditingController> patientRequirements =
      <TextEditingController>[].obs;
  final selectedTreatment = ''.obs;

  RxMap<String, String> treatmentsMap = <String, String>{}.obs; // {id: alias}
  List<DropdownMenuItem<String>> items =
      []; // Update this to store DropdownMenuItem<String>
  String selectedTreatmentId = ''; // Untuk menyimpan ID yang dipilih

  late List<String> patientRequirementsValues;

  final GlobalKey<FormState> generalInformationFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    initializeInputs(1); // Initialize the inputs with a default count
    getTreatments();
  }

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
      if (!generalInformationFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // final inputController = Get.put(InputController());
      // final values = inputController.getAllValues();

      // // Initialize the model for the post
      // final newPost = PostModel(
      //   userId: UserController.instance.user.value.id,
      //   koasId: UserController.instance.user.value.koasProfile!.id!,
      //   title: title.text.trim(),
      //   desc: description.text.trim(),
      //   requiredParticipant: convertToInt(requiredParticipant.text.trim()),
      //   patientRequirement: values,
      //   treatmentId: selectedTreatmentId,
      // );

      // Logger().i(newPost);

      // // Send the data to the server
      // final post = await PostRepository.instance.createPost(newPost);

      // // Get current postId from the server
      // final postId = post.id;
      // final postRequiredParticipant = post.requiredParticipant;

      // if (postId == null) {
      //   TLoaders.errorSnackBar(
      //     title: 'Error',
      //     message: 'Failed to fetch post id from the server',
      //   );
      //   return;
      // }

      // Close loading
      TFullScreenLoader.stopLoading();

      // Success message
      // TLoaders.successSnackBar(
      //   title: 'Success',
      //   message: 'Post has been created',
      // );

      // Navigate to next screen
      Get.to(() => const CreateSchedulePost());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(
        title: 'Error',
        message: e.toString(),
      );
    }
  }

  Future<void> getTreatments() async {
    try {
      final treatments =
          await TreatmentRepository.instance.getAllTreatmentTypes();
      if (treatments.isNotEmpty) {
        treatmentsMap.assignAll({
          for (var treatment in treatments) treatment.id!: treatment.alias!
        });
        Logger().i('Treatments Map: $treatmentsMap');
      } else {
        Logger().w('No treatments available.');
      }
    } catch (e) {
      TLoaders.errorSnackBar(
        title: 'Error',
        message: 'An error occurred while fetching treatments',
      );
    }
  }

  void setSelectedTreatment(String alias) {
    final selectedEntry = treatmentsMap.entries.firstWhere(
        (entry) => entry.value == alias,
        orElse: () => const MapEntry('', ''));
    selectedTreatmentId = selectedEntry.key; // Simpan ID untuk POST
    selectedTreatment.value = alias; // Simpan alias untuk tampilan
    Logger().i('Selected Treatment ID: ${selectedEntry.key}');
    Logger().i('Selected Treatment: $alias');
  }

  List<DropdownMenuItem<String>> buildDropdownItems(Map<String, String> items) {
    return items.entries.map((entry) {
      return DropdownMenuItem<String>(
        value: entry.key,
        child: Text(entry.value),
      );
    }).toList();
  }

  int? convertToInt(String value) {
    try {
      return int.parse(value.trim());
    } catch (e) {
      // Jika gagal konversi, return null atau nilai default
      Logger().e(e.toString());
      return null; // Atau gunakan nilai default seperti 0
    }
  }

  /// Initialize the inputs with a default count
  void initializeInputs(int count) {
    patientRequirements.clear();
    for (int i = 0; i < count; i++) {
      patientRequirements.add(TextEditingController());
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
