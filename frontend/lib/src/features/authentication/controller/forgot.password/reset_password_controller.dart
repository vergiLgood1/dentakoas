import 'dart:async';

import 'package:denta_koas/src/commons/widgets/state_screeen/state_screen.dart';
import 'package:denta_koas/src/cores/data/repositories/authentication/authentication_repository.dart';
import 'package:denta_koas/src/cores/data/repositories/user/user_repository.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/helpers/network_manager.dart';
import 'package:denta_koas/src/utils/popups/full_screen_loader.dart';
import 'package:denta_koas/src/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ResetPasswordController extends GetxController {
  static ResetPasswordController get to => Get.find();

  final localStorage = GetStorage();

  final hidePassword = true.obs;
  final hideConfirmPassword = true.obs;

  final newPassword = TextEditingController();
  final confirmPassword = TextEditingController();

  final GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();

  // Reset password
  resetPassword() async {
    try {
      // Start loading
      TFullScreenLoader.openLoadingDialog(
        'Resetting password....',
        TImages.amongUsLoading,
      );

      // Check connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form validation
      if (resetPasswordFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Get current user
      final email = localStorage.read('FORGOT_PASSWORD_EMAIL');

      // Reset password
      final userRepository = Get.put(UserRepository());
      await userRepository.resetPassword(email, newPassword.text.trim());

      // Stop loading
      TFullScreenLoader.stopLoading();

      // Show success message
      TLoaders.successSnackBar(
        title: 'Password reset',
        message: 'You have successfully reset your password',
      );

      localStorage.remove('FORGOT_PASSWORD_EMAIL');

      // Redirect
      Get.off(
        () => Timer(
          const Duration(seconds: 3),
          () => Get.off(() => StateScreen(
                image: TImages.successfullyResetPassword,
                title: 'Password reset',
                subtitle: 'You have successfully reset your password',
                showButton: true,
                isLottie: true,
                primaryButtonTitle: 'Continue',
                onPressed: () =>
                    AuthenticationRepository.instance.screenRedirect(),
              )),
        ),
      );
    } catch (e) {
      // Stop loading
      TFullScreenLoader.stopLoading();

      TLoaders.errorSnackBar(
        title: 'Oh snap',
        message: 'Something went wrong. Please try again later.',
      );
    }
  }
}
