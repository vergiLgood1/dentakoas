import 'package:denta_koas/src/cores/data/repositories/authentication/authentication_repository.dart';
import 'package:denta_koas/src/cores/data/repositories/user/user_repository.dart';
import 'package:denta_koas/src/features/personalization/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:logger/logger.dart';

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
      greetingMsg.value = 'Good Night';
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
     
    } catch (e) {
      Logger().e(['Error saving user with Google: $e']);
      throw e.toString();
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
        Logger().w(e);
      }
    }
  }

  bool hasEmptyFields(Map<String, dynamic> data) {
    // List of keys to check
    List<String> keysToCheck = [
      'FasilitatorProfile',
      'KoasProfile',
      'PasienProfile',
    ];

    for (String key in keysToCheck) {
      if (data.containsKey(key) && data[key] != null) {
        Map<String, dynamic> profileData = data[key];

        // Log to check the profile data
        Logger().i(['Checking fields in $key: $profileData']);

        // Iterate through the fields in the profile
        for (var entry in profileData.entries) {
          final fieldKey = entry.key;
          final fieldValue = entry.value;

          // Check if the field is null or an empty string
          if (fieldValue == null ||
              (fieldValue is String && fieldValue.trim().isEmpty) ||
              (fieldValue is List && fieldValue.isEmpty) ||
              (fieldValue is Map && fieldValue.isEmpty)) {
            Logger().i(['Empty field found in $key: $fieldKey']);
            return true; // Return true if any field is empty
          }
        }
      }
    }

    return false; // Return false if no empty fields found
  }

  bool hasEmptyFields2(Map<String, dynamic> data) {
    for (var entry in data.entries) {
      final key = entry.key;
      final value = entry.value;

      // Cek kondisi untuk berbagai tipe data
      if (value == null ||
          (value is String && value.trim().isEmpty) ||
          (value is List && value.isEmpty) ||
          (value is Map && value.isEmpty)) {
        print('Field kosong ditemukan pada key: $key, value: $value');
        return true; // Ada field kosong
      }

      // Jika nilai adalah Map, cek secara rekursif
      if (value is Map<String, dynamic>) {
        final hasEmptyInNested = hasEmptyFields2(value);
        if (hasEmptyInNested) return true;
      }
    }

    return false; // Tidak ada field kosong
}

bool hasEmptyFields3(Map<String, dynamic> data) {
  // Daftar key yang akan diperiksa
  const List<String> keysToCheck = ['koasProfile', 'pasienProfile', 'fasilitatorProfile'];

  for (var entry in data.entries) {
    final key = entry.key;
    final value = entry.value;

    // Lewati key yang tidak perlu diperiksa
    if (!keysToCheck.contains(key)) continue;

    // Cek kondisi untuk berbagai tipe data
    if (value == null ||
        (value is String && value.trim().isEmpty) ||
        (value is List && value.isEmpty) ||
        (value is Map && value.isEmpty)) {
      print('Field kosong ditemukan pada key: $key, value: $value');
      return true; // Ada field kosong
    }

    // Jika nilai adalah Map, cek secara rekursif
    if (value is Map<String, dynamic>) {
      final hasEmptyInNested = hasEmptyFields2(value);
      if (hasEmptyInNested) return true;
    }
  }

  return false; // Tidak ada field kosong
}



}
