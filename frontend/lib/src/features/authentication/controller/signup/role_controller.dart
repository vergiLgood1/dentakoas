import 'package:denta_koas/src/cores/data/repositories/authentication/authentication_repository.dart';
import 'package:denta_koas/src/features/authentication/screen/signup/profile-setup.dart';
import 'package:denta_koas/src/features/authentication/screen/signup/signup.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/helpers/network_manager.dart';
import 'package:denta_koas/src/utils/popups/full_screen_loader.dart';
import 'package:denta_koas/src/utils/popups/loaders.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RoleController extends GetxController {
  static RoleController get instance => Get.find();
  // Get role from the role screen

  final storage = GetStorage();
  final selectedIndexRole = 0.obs;
  final roleNames = ["Fasilitator", "Koas", "Pasien"];

  void selectRole(int index) {
    selectedIndexRole.value = index;
  }

  String get role => roleNames[selectedIndexRole.value];

  void setSelectedRole() async {
    try {
      // Start loading
      TFullScreenLoader.openLoadingDialog(
          'Processing your information....', TImages.amongUsLoading);

      // Check connection
      final isConected = await NetworkManager.instance.isConnected();
      if (!isConected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Check if user has logged in with OAuth
      final userCredential = AuthenticationRepository.instance.authUser;

      // Stop Loading
      TFullScreenLoader.stopLoading();

      // Save the selected role
      storage.write('SELECTED_ROLE', role);

      // Navigasi ke halaman berikutnya
      if (userCredential != null) {
        Get.to(const ProfileSetupScreen());
      } else {
        Get.to(const SignupScreen());
      }
    } catch (e) {
      // Stop Loading
      TFullScreenLoader.stopLoading();

      // Show error message
      TLoaders.errorSnackBar(
        title: 'Error',
        message: 'An error occurred while processing your information',
      );
    }
  }
}
