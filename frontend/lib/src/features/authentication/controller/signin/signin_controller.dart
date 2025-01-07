import 'package:denta_koas/src/cores/data/repositories/authentication.repository/authentication_repository.dart';
import 'package:denta_koas/src/cores/data/repositories/user.repository/user_repository.dart';
import 'package:denta_koas/src/features/personalization/controller/user_controller.dart';
import 'package:denta_koas/src/features/personalization/model/user_model.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/helpers/network_manager.dart';
import 'package:denta_koas/src/utils/popups/full_screen_loader.dart';
import 'package:denta_koas/src/utils/popups/loaders.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SigninController extends GetxController {
  // -- Variables
  final rememberMe = false.obs;
  final hidePassword = true.obs;

  final localStorage = GetStorage();

  final email = TextEditingController();
  final password = TextEditingController();

  GlobalKey<FormState> signinFormKey = GlobalKey<FormState>();

  final userController = Get.put(UserController());

  final storage = GetStorage();

  @override
  void onInit() {
    // Check if remember me is checked
    if (localStorage.read('REMEMBER_ME_CHECK') == true) {
      email.text = localStorage.read('REMEMBER_ME_EMAIL');
      password.text = localStorage.read('REMEMBER_ME_PASSWORD');
    }

    super.onInit();
  }

  // -- Credential Sign In
  Future<void> credentialsSignIn() async {
    try {
      // Start loading
      TFullScreenLoader.openLoadingDialog(
          'Logging you in....', TImages.loadingHealth);

      // Check connection
      final isConected = await NetworkManager.instance.isConnected();
      if (!isConected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Form validation
      if (!signinFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Store data if remember me is checked
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text);
        localStorage.write('REMEMBER_ME_PASSWORD', password.text);
        localStorage.write('REMEMBER_ME_CHECK', rememberMe.value);
      }

      // Login with credentials
      await AuthenticationRepository.instance.signInWithEmailPasswordFirebase(
          email: email.text.trim(), password: password.text.trim());

      // Stop loading
      TFullScreenLoader.stopLoading();

      // Redirect to home screen
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      // Remove loading
      TFullScreenLoader.stopLoading();

      TLoaders.errorSnackBar(title: 'Oh snap', message: e.toString());
    }
  }

  // -- Google Sign In Authentication
  Future<void> googleSignIn() async {
    try {
      // Start loading
      TFullScreenLoader.openLoadingDialog(
          'Logging you in....', TImages.loadingHealth);

      // Check connection
      final isConected = await NetworkManager.instance.isConnected();
      if (!isConected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      // Login with Google and save user data in Firebase Authtentication
      final userCredentials =
          await AuthenticationRepository.instance.signInWithGoogle();

      // Save user record to the database
      final nameParts =
          UserModel.nameParts(userCredentials.user!.displayName ?? '');

      final role = storage.read('TEMP_ROLE');

      // Map user data
      final user = UserModel(
        id: userCredentials.user!.uid,
        givenName: nameParts[0],
        familyName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
        email: userCredentials.user!.email ?? '',
        phone: userCredentials.user!.phoneNumber,
        image: userCredentials.user!.photoURL,
        role: role,
      );

      // Logger().w(['User Data: $user']);

      // Initialize user repository
      final userRepository = Get.put(UserRepository());

      // Save user to firestore authentication
      await userRepository.saveAuthUser(user);

      // Save user data
      await userRepository.saveUserRecord(user);

      // Stop loading
      TFullScreenLoader.stopLoading();

      // Redirect to home screen
      AuthenticationRepository.instance.screenRedirect();
    } catch (e) {
      // Remove loading
      TFullScreenLoader.stopLoading();

      TLoaders.errorSnackBar(title: 'Oh snap', message: e.toString());
    }
  }
}
