import 'package:denta_koas/src/cores/data/repositories/authentication/authentication_repository.dart';
import 'package:denta_koas/src/features/authentication/data/user_model.dart';
import 'package:denta_koas/src/utils/constants/api_urls.dart';
import 'package:denta_koas/src/utils/dio.client/dio_client.dart';
import 'package:denta_koas/src/utils/exceptions/exceptions.dart';
import 'package:denta_koas/src/utils/exceptions/format_exceptions.dart';
import 'package:denta_koas/src/utils/exceptions/platform_exceptions.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  Future<UserModel?> getUserDetails() async {
    try {
      final userSession = await AuthenticationRepository.instance.getSession();
      final id = UserModel.fromJson(userSession!).id;

      if (UserModel.fromJson(userSession).id == id) {
        return UserModel.fromJson(userSession);
      } else {
        final response = await DioClient().get('${Endpoints.users}/$id');

        if (response.statusCode == 200) {
          final data = response.data;

          if (data != null && data is Map<String, dynamic>) {
            return UserModel.fromJson(data);
          }
        }
      }
    } on TExceptions catch (e) {
      throw TExceptions(e.message);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later.';
    }
    return null;
  }

  Future<UserModel?> getUserByEmail(String email) async {
    try {
      final response = await DioClient().get(
        Endpoints.users,
        queryParameters: {'email': email},
      );

      if (response.statusCode == 200) {
        final data = response.data;

        if (data != null && data is Map<String, dynamic>) {
          return UserModel.fromJson(data);
        }
      }
    } on TExceptions catch (e) {
      throw TExceptions(e.message);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later.';
    }
    return null;
  }

  Future<void> saveUserRecord(UserModel user) async {
    try {
      // await THttpHelper.post(Endpoints.users, user.toJson());
      await DioClient().post(Endpoints.users, data: user.toJson());
    } on TExceptions catch (e) {
      throw TExceptions(e.message);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later.';
    }
  }

  Future<void> updateUserRecord(UserModel user) async {
    try {
      await DioClient()
          .patch('${Endpoints.users}/${user.id}', data: user.toJson());
    } on TExceptions catch (e) {
      throw TExceptions(e.message);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later.';
    }
  }

  Future<bool> resetPassword(String email, String newPassword) async {
    try {
      // Ambil user berdasarkan email
      final user = await getUserByEmail(email);

      if (user == null) {
        if (kDebugMode) {
          print("User not found for email: $email");
        }
        return false;
      }

      // Ambil ID user
      final userId = user.id;

      // Kirim permintaan untuk reset password
      final response = await DioClient().post(
        "${Endpoints.users}/$userId/reset-password", // Endpoint reset password
        data: {
          'password': newPassword,
        },
      );

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("Password reset successfully for user ID: $userId");
        }
        return true;
      } else {
        if (kDebugMode) {
          print("Failed to reset password: ${response.data}");
        }
      }
    } on TExceptions catch (e) {
      throw TExceptions(e.message);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw 'Something went wrong. Please try again later.';
    }
    return false;
  }
}
