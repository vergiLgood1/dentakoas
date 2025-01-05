import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:denta_koas/src/cores/data/repositories/authentication/authentication_repository.dart';
import 'package:denta_koas/src/features/personalization/model/user_model.dart';
import 'package:denta_koas/src/utils/constants/api_urls.dart';
import 'package:denta_koas/src/utils/dio.client/dio_client.dart';
import 'package:denta_koas/src/utils/exceptions/exceptions.dart';
import 'package:denta_koas/src/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:denta_koas/src/utils/exceptions/firebase_exceptions.dart';
import 'package:denta_koas/src/utils/exceptions/format_exceptions.dart';
import 'package:denta_koas/src/utils/exceptions/platform_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _dbAuth = FirebaseFirestore.instance;

  // Future<UserModel?> getUserDetails() async {
  //   try {
  //     final currentEmail = _auth.currentUser?.email;
  //     if (currentEmail != null) return getUserByEmail(currentEmail);
  //   } on TExceptions catch (e) {
  //     throw TExceptions(e.message);
  //   } on FormatException catch (_) {
  //     throw const TFormatException();
  //   } on PlatformException catch (e) {
  //     throw TPlatformException(e.code).message;
  //   } catch (e) {
  //     throw 'Something went wrong. Please try again later.';
  //   }
  //   return null;
  // }

  Future<void> saveAuthUser(UserModel user) async {
    try {
      await _dbAuth.collection('Users').doc(user.id).set(user.toJsonAuth());
    } on FirebaseAuthMultiFactorException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
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

  Future<UserModel> fetchUserDetailById() async {
    try {
      // Kirim permintaan GET dengan parameter userId
      final response = await DioClient().get(
        Endpoints.userDetail(AuthenticationRepository.instance.authUser!.uid),
      );

      if (response.statusCode == 200) {
        final data = response.data;

        if (data is Map<String, dynamic>) {
          return UserModel.fromJson(data);
        }
      }
    } catch (e) {
      throw 'Something went wrong. Please try again later.';
    }
    throw 'Failed to fetch user data.';
  }

  Future<UserModel?> getUserByEmail(String email) async {
    try {
      final response = await DioClient().get(Endpoints.users, queryParameters: {
        'email': email,
      });

      if (response.statusCode == 200) {
        final data = response.data['data']['user'][0];

        // Logger().e(['Data: $data']);

        if (data is Map<String, dynamic>) {
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
      Logger().e(['Error di get user by email: $e']);
      throw e.toString();
    }
    return null;
   
  }
  
  Future<UserModel?> getUserById(String id) async {
    try {
      final response = await DioClient().get(Endpoints.userDetail(id));

      if (response.statusCode == 200) {
        final data = response.data;

        if (data is Map<String, dynamic>) {
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
      throw e.toString();
    }
    return null;
  }

  Future<String?> getRoleById(String id) async {
    try {
      final response = await DioClient().get(Endpoints.userDetail(id));

      if (response.statusCode == 200) {
        final data = response.data;

        if (data is Map<String, dynamic>) {
          final user = UserModel.fromJson(data);
          
          return user.role;
        }
      }
    } on TExceptions catch (e) {
      throw TExceptions(e.message);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw e.toString();
    }
    return null;
  }

  // Get user profile with small data
  Future<UserModel> getUserProfile(String id) async {
    try {
      final response = await DioClient().get(Endpoints.userProfile(id));

      if (response.statusCode == 200) {
        final data = response.data;

        if (data is Map<String, dynamic>) {
          return UserModel.fromJson(data);
        } else {
          throw 'Unexpected data format';
        }
      } else {
        throw 'Failed to fetch user data with status code ${response.statusCode}';
      }
    } catch (e) {
      throw e.toString();
    }
  }

  
  Future<void> saveUserRecord(UserModel user) async {
    try {
      // await THttpHelper.post(Endpoints.users, user.toJson());
      final response =
          await DioClient().post(Endpoints.users, data: user.toJson());

      Logger().e(['User: ${user.toJson()}']);
      if (response.statusCode != 201) {
        AuthenticationRepository.instance.authUser!.delete();
        throw 'Failed to save user data.';
      }
    } on TExceptions catch (e) {
      throw TExceptions(e.message);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      e.toString();
    }
  }

  Future<void> updateUserRecord(String id, UserModel user) async {
    try {
      await DioClient()
          .patch(Endpoints.userDetail(id), data: user.toJson());

      Logger().i(['User: ${user.toJson()}']);
    } on TExceptions catch (e) {
      throw TExceptions(e.message);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<bool> resetAndUpdatePassword(String id, UserModel user) async {
    try {
      final response = await DioClient()
          .patch(Endpoints.resetPassword(id), data: user.toJson());

      if (response.statusCode != 200) {
        throw 'Failed to reset password';
      }

      return true;
    } on TExceptions catch (e) {
      throw TExceptions(e.message);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      e.toString();
    }
    return false;
  }

  // Create a new koas profile for user who signin with Google
  Future<void> saveKoasProfile(String id, UserModel user) async {
    try {

      // await THttpHelper.post(Endpoints.users, user.toJson());
      await DioClient().post(Endpoints.userProfile(id), data: user.toJson());

      Logger().i(['User: ${user.toJson()}']);
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

  // Update koas profile for user
  Future<void> updateKoasProfile(String id, UserModel user) async {
    try {
      // await THttpHelper.post(Endpoints.users, user.toJson());

      await DioClient()
          .patch(Endpoints.userProfile(id), data: user.koasProfile!.toJson());
    } on TExceptions catch (e) {
      throw TExceptions(e.message);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw e.toString();
    }
  }

  // Create a new pasien profile for user who signin with Google
  Future<void> savePasienProfile(String id, UserModel user) async {
    try {
      // await THttpHelper.post(Endpoints.users, user.toJson());
      if (user.id != null) {
        await DioClient().post(Endpoints.userProfile(id), data: user.toJson());
      } else {
        throw 'User ID cannot be null';
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
  }

  // Update pasien profile for user
  Future<void> updatePasienProfile(String id, UserModel user) async {
    try {
      // Debugging data yang akan dikirim
      if (kDebugMode) {
        print(
            "Updating pasien profile for user ID: $id with data: ${user.toJson()}");
        print("PasienProfile: ${user.pasienProfile!.toJson()}");
      }

      await DioClient()
          .patch(Endpoints.userProfile(id), data: user.pasienProfile?.toJson());
    } on TExceptions catch (e) {
      throw TExceptions(e.message);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      // throw 'Something went wrong. Please try again later.';
      throw e.toString();
    }
  }

  Future<void> saveFasilitatorProfile(String id, UserModel user) async {
    try {
      // await THttpHelper.post(Endpoints.users, user.toJson());
      await DioClient().post(Endpoints.userProfile(id),
          data: user.fasilitatorProfile?.toJson());
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

  // Update fasilitator profile for user
  Future<void> updateFasilitatorProfile(String id, UserModel user) async {
    try {
      await DioClient().patch(Endpoints.userProfile(id),
          data: user.fasilitatorProfile?.toJson());
    } on TExceptions catch (e) {
      throw TExceptions(e.message);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      throw e.toString();
    }
  }

  
}
