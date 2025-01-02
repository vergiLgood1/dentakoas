import 'dart:async';

import 'package:denta_koas/src/commons/widgets/state_screeen/state_screen.dart';
import 'package:denta_koas/src/cores/data/repositories/authentication/authentication_repository.dart';
import 'package:denta_koas/src/cores/data/repositories/user/user_repository.dart';
import 'package:denta_koas/src/features/authentication/data/user_model.dart';
import 'package:denta_koas/src/features/authentication/screen/password_configurations/reset_password.dart';
import 'package:denta_koas/src/features/authentication/screen/password_configurations/verification_code.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/helpers/network_manager.dart';
import 'package:denta_koas/src/utils/popups/full_screen_loader.dart';
import 'package:denta_koas/src/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ForgotPasswordController extends GetxController {
  static ForgotPasswordController get instance => Get.find();

  // Variable
  final localStorage = GetStorage();

  final String otp = '';
  final hidePassword = true.obs;

  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  final GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();
  final GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();

  // Send email to reset password
  sendOtpResetPassword() async {
    try {
      // Start loading
      TFullScreenLoader.openLoadingDialog(
        'Sending password reset email....',
        TImages.amongUsLoading,
      );

      // Check connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form validation
      if (!forgotPasswordFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Send password reset email
      await AuthenticationRepository.instance
          .sendOtpResetPassword(email.text.trim());

      localStorage.write('FORGOT_PASSWORD_EMAIL', email.text.trim());

      // Stop loading
      TFullScreenLoader.stopLoading();

      // Show success message
      TLoaders.successSnackBar(
        title: 'Email sent',
        message: 'A verification OTP has been sent to ${email.text}',
      );

      // Redirect
      Get.to(() => const VerificationCodeScreen());
    } catch (e) {
      TLoaders.errorSnackBar(
        title: 'Oh snap',
        message: e.toString(),
      );
    }
  }

  // Resend password reset email
  resendOtpResetPassword() async {
    try {
      // Start loading
      TFullScreenLoader.openLoadingDialog(
        'Sending password reset email....',
        TImages.amongUsLoading,
      );

      // Check connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Send password reset email
      await AuthenticationRepository.instance
          .sendOtpResetPassword(email.text.trim());

      // Stop loading
      TFullScreenLoader.stopLoading();

      // Show success message
      TLoaders.successSnackBar(
        title: 'Email sent',
        message: 'A verification OTP has been sent to ${email.text}',
      );
    } catch (e) {
      TLoaders.errorSnackBar(
        title: 'Oh snap',
        message: e.toString(),
      );
    }
  }

  // Compare verification OTP
  compareOtpResetPassword(otp) async {
    try {
      // Start loading
      TFullScreenLoader.openLoadingDialog(
        'Verifying OTP....',
        TImages.amongUsLoading,
      );

      // Check connection
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Compare OTP
      await AuthenticationRepository.instance.compareOtpResetPassword(otp);

      // Stop loading
      TFullScreenLoader.stopLoading();

      // Show success message
      TLoaders.successSnackBar(
        title: 'OTP verified',
        message: 'You have successfully verified the OTP',
      );

      // Redirect
      Get.off(() => const ResetPasswordScreen());
    } catch (e) {
      TLoaders.errorSnackBar(
        title: 'Oh snap',
        message: e.toString(),
      );
    }
  }

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
      if (forgotPasswordFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Get current user
      final email = localStorage.read('FORGOT_PASSWORD_EMAIL');

      // Reset password
      final userRepository = Get.put(UserRepository());
      await userRepository.resetPassword(email, password.text.trim());

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
                title: ' Passwordreset',
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
      TLoaders.errorSnackBar(
        title: 'Oh snap',
        message: 'Something went wrong. Please try again later.',
      );
    }
  }

  // Set timer for auto redirect
}
