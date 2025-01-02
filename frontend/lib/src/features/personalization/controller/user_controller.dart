import 'package:denta_koas/src/cores/data/repositories/authentication/authentication_repository.dart';
import 'package:denta_koas/src/cores/data/repositories/user/user_repository.dart';
import 'package:denta_koas/src/features/personalization/model/user_model.dart';
import 'package:denta_koas/src/utils/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final profileLoading = false.obs;
  Rx<UserModel?> user = UserModel.empty().obs;
  final userRepository = Get.put(UserRepository());

  final greetingMsg = ''.obs;

  final storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    getUserRecord();
  }

  String updateGreetingMessage() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      greetingMsg.value = 'Good Morning';
    } else if (hour < 18) {
      greetingMsg.value = 'Good Afternoon';
    } else {
      greetingMsg.value = 'Good Evening';
    }
    return greetingMsg.value;
  }

  // Get user data
  Future<void> getUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository
          .getUserById(AuthenticationRepository.instance.authUser!.uid);
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  // Save user who sign in with Google
  Future<void> saveUserWithGoogle(UserCredential userCredentials) async {
    try {
      // convert Name to first name and last name
      final nameParts =
          UserModel.nameParts(userCredentials.user!.displayName ?? '');

      final role = storage.read('SELECTED_ROLE');

      // Map user data
      final user = UserModel(
        id: userCredentials.user!.uid,
        givenName: nameParts[0],
        familyName: nameParts.length > 1 ? nameParts.sublist(1).join(' ') : '',
        email: userCredentials.user!.email ?? '',
        phone: userCredentials.user!.phoneNumber ?? '',
        image: userCredentials.user!.photoURL,
        role: role,
      );

      // Save user data
      await userRepository.saveUserRecord(user);

      // if (kDebugMode) {
      //   print("Data to be sent: ${user.toJson()}");
      // }
    } catch (e) {


      TLoaders.warningSnackBar(
        title: 'Data not saved',
        message: 'Something went wrong while saving your information',
      );
    }
  }

  // update user data
  Future<void> resetPasswordUser(String id, UserModel user) async {
    try {

      // 

      final updatedUser = UserModel(
        password: user.password,
      );

      // Save user data
      await userRepository.updateUserRecord(id, updatedUser);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
