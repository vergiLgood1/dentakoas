import 'package:denta_koas/src/commons/widgets/state_screeen/state_screen.dart';
import 'package:denta_koas/src/cores/data/repositories/authentication.repository/authentication_repository.dart';
import 'package:denta_koas/src/cores/data/repositories/user.repository/user_repository.dart';
import 'package:denta_koas/src/features/personalization/model/user_model.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/constants/text_strings.dart';
import 'package:denta_koas/src/utils/helpers/network_manager.dart';
import 'package:denta_koas/src/utils/popups/full_screen_loader.dart';
import 'package:denta_koas/src/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

class ResetPasswordController extends GetxController {
  static ResetPasswordController get to => Get.find();

  final localStorage = GetStorage();

  final hidePassword = true.obs;
  final hideConfirmPassword = true.obs;

  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController();

  final GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();

  var logger = Logger();

  // Reset password
  resetPassword() async {
    try {
      // Start loading
      TFullScreenLoader.openLoadingDialog(
        'Resetting password....',
        TImages.loadingHealth,
      );

      // Check connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form validation
      if (!resetPasswordFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Get current user
      final email = localStorage.read('FORGOT_PASSWORD_EMAIL');

      Logger().i(['Email: $email']);

      // Get user id
      final userRepository = Get.put(UserRepository());
      final user = await userRepository.getUserByEmail(email);

      Logger().i(['User: $user']);
      Logger().i(['User ID: ${user!.id}']);

      final userId = user.id;

      final updatePassword = UserModel(
        password: newPassword.text.trim(),
      );

      // Update password on Firebase Auth
      await AuthenticationRepository.instance.changePassword(
          newPassword.text.trim(), confirmPassword.text.trim(), user.email!);

      // Update password on database 
      await userRepository.resetAndUpdatePassword(userId!, updatePassword);
      // await userRepository.updateUserRecord(userId!, updatePassword);
       
      // Stop loading
      TFullScreenLoader.stopLoading();

      // Show success message
      TLoaders.successSnackBar(
        title: 'Password reset',
        message: 'You have successfully reset your password',
      );

      localStorage.remove('FORGOT_PASSWORD_EMAIL');

      // Redirect
      Get.to(
        () => StateScreen(
          image: TImages.successfullyResetPassword,
          title: TTexts.successfullyResetPasswordTitle,
          subtitle: TTexts.successfullyResetPasswordSubTitle,
          showButton: true,
          isLottie: true,
          primaryButtonTitle: 'Continue',
          onPressed: () => AuthenticationRepository.instance.screenRedirect(),
        ),
      );
    } catch (e) {
      // Stop loading
      TFullScreenLoader.stopLoading();

      TLoaders.errorSnackBar(
        title: 'Oh snap',
        message: e.toString(),
      );

      logger.e(e);
    }
  }
}
