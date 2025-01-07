import 'package:denta_koas/src/cores/data/repositories/authentication.repository/authentication_repository.dart';
import 'package:denta_koas/src/cores/data/repositories/user.repository/user_repository.dart';
import 'package:denta_koas/src/features/authentication/screen/signup/verify_email.dart';
import 'package:denta_koas/src/features/personalization/model/user_model.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/helpers/network_manager.dart';
import 'package:denta_koas/src/utils/popups/full_screen_loader.dart';
import 'package:denta_koas/src/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  // Variable
  final storage = GetStorage();

  final hidePassword = true.obs;
  final hideConfirmPassword = true.obs;
  final provicyPolicy = false.obs;

  final email = TextEditingController();
  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final username = TextEditingController();

  final phoneNumber = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();

  // Sign Up Function
  void signUp() async {
    try {
      // Start loading
      TFullScreenLoader.openLoadingDialog(
          'Processing your information....', TImages.loadingHealth);

      // Check connection
      final isConected = await NetworkManager.instance.isConnected();
      if (!isConected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form validation
      if (!signupFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Check if user agreed to the terms and conditions
      if (!provicyPolicy.value) {
        TFullScreenLoader.stopLoading();

        TLoaders.warningSnackBar(
          title: 'Accept Privacy Policy',
          message:
              'In order to create account, you must have to read and accept the privacy policy & terms of use.',
        );
        return;
      }

      // Register user in the Firebase Authentication
      final userCredentials = await AuthenticationRepository.instance
          .signUpWithCredential(email.text.trim(), password.text.trim());
      
      // Get user role
      final role = storage.read('TEMP_ROLE');

      // Initialize new auth user
      final newAuthUser = UserModel(
        id: userCredentials.user!.uid,
        givenName: firstName.text.trim(),
        familyName: lastName.text.trim(),
        email: email.text.trim(),
        phone: phoneNumber.text.trim(),
        address: '',
        role: role.toString().trim(),
      );

      // Save user data in database
      final newUser = UserModel(
        id: userCredentials.user!.uid,
        givenName: firstName.text.trim(),
        familyName: lastName.text.trim(),
        email: email.text.trim(),
        password: password.text.trim(),
        confirmPassword: confirmPassword.text.trim(),
        phone: phoneNumber.text.trim(),
        address: '',
        role: role.toString().trim(),
      );

      final userRepository = Get.put(UserRepository());

      // Save auth user to firestore
      await userRepository.saveAuthUser(newAuthUser);

      // Save user record to database
      await userRepository.saveUserRecord(newUser);

      // Remove loading
      TFullScreenLoader.stopLoading();

      // Show success message
      TLoaders.successSnackBar(
        title: 'Congratulations',
        message: 'Your account has been created! Verify email to continue.',
      );

      storage.write('CURRENT_USER_EMAIL', email.text.trim());

      // Move to verification screen
      Get.to(() => VerifyEmailScreen(email: email.text.trim()));
      // Get.to(() => const ProfileSetupScreen());
    } catch (e) {
      // Remove loading
      TFullScreenLoader.stopLoading();

      // Show some generic error to the user
      TLoaders.errorSnackBar(title: 'Oh snap', message: e.toString());
    }
  }

}
