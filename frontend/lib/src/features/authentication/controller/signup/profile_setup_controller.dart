import 'dart:async';

import 'package:denta_koas/src/commons/widgets/state_screeen/state_screen.dart';
import 'package:denta_koas/src/cores/data/repositories/authentication/authentication_repository.dart';
import 'package:denta_koas/src/cores/data/repositories/user/user_repository.dart';
import 'package:denta_koas/src/features/personalization/model/user_model.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/constants/text_strings.dart';
import 'package:denta_koas/src/utils/helpers/network_manager.dart';
import 'package:denta_koas/src/utils/popups/full_screen_loader.dart';
import 'package:denta_koas/src/utils/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileSetupController extends GetxController {
  static ProfileSetupController get instance => Get.find();
  // Get role from the role screen

  final koasNumber = TextEditingController();
  final age = TextEditingController();
  final departement = TextEditingController();
  final university = TextEditingController();
  final bio = TextEditingController();

  final List<String> universities = [
    'Politeknik Negeri Jember',
    'Universitas Negeri Jember',
  ];

  final List<String> genders = [
    'Male',
    'Female',
  ];

  String selectedUniversity = '';
  String selectedGender = '';

  final localStorage = GetStorage();

  final GlobalKey<FormState> profileSetupFormKey = GlobalKey<FormState>();

  void setupProfile() async {
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

      // Form validation
      if (!profileSetupFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Get user id from firebase and inisialize the model
      final userId = AuthenticationRepository.instance.authUser?.uid;
      final existingRole = await UserRepository.instance.getRoleById(userId!);

      existingRole == null
          ? saveNewKoasProfile(userId)
          : updateNewKoasProfile(userId);

      // Stop loading
      TFullScreenLoader.stopLoading();

      // Show success message
      TLoaders.successSnackBar(
        title: 'Success',
        message: 'Your profile has been successfully updated',
      );

      // Navigasi ke halaman berikutnya
      // Get.off(() => AuthenticationRepository.instance.screenRedirect());
      Get.off(() => StateScreen(
            image: TImages.successfullySignedUp,
            title: TTexts.yourAccountCreatedTitle,
            subtitle: TTexts.yourAccountCreatedSubTitle,
            showButton: true,
            isLottie: true,
            primaryButtonTitle: TTexts.tContinue,
            onPressed: () => AuthenticationRepository.instance.screenRedirect(),
          ));
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

  checkStatusProfile() async {
    final user = FirebaseAuth.instance.currentUser!.uid;
    final currentUser = await UserRepository.instance.getUserById(user);
    if (currentUser != null && currentUser.koasProfile?.koasNumber != null) {
      Get.off(
        () => StateScreen(
          image: TImages.successfullySignedUp,
          title: TTexts.yourAccountCreatedTitle,
          subtitle: TTexts.yourAccountCreatedSubTitle,
          showButton: true,
          isLottie: true,
          primaryButtonTitle: TTexts.tContinue,
          onPressed: () => AuthenticationRepository.instance.screenRedirect(),
        ),
      );
    }
  }

  // Timer to automatically redirect on email verification
  setTimerForAutoRedirect() {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) async {
        await FirebaseAuth.instance.currentUser?.reload();
        final userId = FirebaseAuth.instance.currentUser!.uid;
        final currentUser = await UserRepository.instance.getUserById(userId);
        if (currentUser!.koasProfile?.koasNumber != null) {
          timer.cancel();
          Get.off(
            () => StateScreen(
              image: TImages.successfullySignedUp,
              title: TTexts.yourAccountCreatedTitle,
              subtitle: TTexts.yourAccountCreatedSubTitle,
              showButton: true,
              isLottie: true,
              primaryButtonTitle: TTexts.tContinue,
              onPressed: () =>
                  AuthenticationRepository.instance.screenRedirect(),
            ),
          );
        }
      },
    );
  }

  // Save user profile
  void saveNewKoasProfile(String userId) async {
    // Get the selected role
    final newRole = localStorage.read('SELECTED_ROLE');

    // Update the user role
    await UserRepository.instance.updateUserRecord(userId, newRole);

    // Initialize the new user profile
    final newKoasProfile = UserModel(
      koasProfile: KoasProfileModel(
        koasNumber: koasNumber.text.trim(),
        age: age.text.trim(),
        gender: selectedGender,
        departement: departement.text.trim(),
        university: selectedUniversity,
        bio: bio.text.trim(),
      ),
    );

    // Save the user profile
    await UserRepository.instance.saveKoasProfile(userId, newKoasProfile);
  }

  // Update user profile
  void updateNewKoasProfile(String userId) async {
    final updateUser = UserModel(
      koasProfile: KoasProfileModel(
        koasNumber: koasNumber.text.trim(),
        age: age.text.trim(),
        gender: selectedGender,
        departement: departement.text.trim(),
        university: selectedUniversity,
        bio: bio.text.trim(),
      ),
    );

    kDebugMode
        ? print('User Profile: ${updateUser.koasProfile!.toJson()}')
        : null;

    // Update the user profile
    await UserRepository.instance.updateKoasProfile(userId, updateUser);
  }
}
