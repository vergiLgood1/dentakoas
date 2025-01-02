import 'package:denta_koas/navigation_menu.dart';
import 'package:denta_koas/src/features/authentication/screen/signin/signin.dart';
import 'package:denta_koas/src/features/authentication/screen/signup/verify_email.dart';
import 'package:denta_koas/src/features/onboarding/screen/onboarding/onboarding.dart';
import 'package:denta_koas/src/utils/constants/api_urls.dart';
import 'package:denta_koas/src/utils/dio.client/dio_client.dart';
import 'package:denta_koas/src/utils/exceptions/exceptions.dart';
import 'package:denta_koas/src/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:denta_koas/src/utils/exceptions/firebase_exceptions.dart';
import 'package:denta_koas/src/utils/exceptions/format_exceptions.dart';
import 'package:denta_koas/src/utils/exceptions/platform_exceptions.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();

  // Variable
  final storage = GetStorage();
  final _auth = FirebaseAuth.instance;

  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  screenRedirect() async {
    final user = _auth.currentUser;
    final currentUser = _auth.currentUser?.email;
    if (user != null) {
      if (user.emailVerified) {
        Get.offAll(() => const NavigationMenu());
      } else if (user.emailVerified) {
        Get.offAll(() => const VerifyEmailScreen());
      }
    } else {
      // local storage
      storage.writeIfNull('isFirstTime', true);
      // check if user is already logged in
      storage.read('isFirstTime') != true
          ? Get.offAll(() => const SigninScreen())
          : Get.offAll(() => const OnBoardingScreen());
    }
  }

  // ----------------- Get CSRF -----------------
  Future<String> tokenCsrf() async {
    try {
      final response = await DioClient().get(Endpoints.csrf);
      return response.data['csrfToken'];
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      throw 'Failed to fetch CSRF token';
    }
  }

  // ----------------- Email and Password Sign In -----------------

  // [Email Authentication] - SIGN IN
  Future<void> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final csrfToken = await AuthenticationRepository.instance.tokenCsrf();
      print("=================== csrfToken: $csrfToken =========");
      print(
          '===================== User Logged in : $email $password =====================');
      await DioClient().post(
        Endpoints.signinWithCredentials,
        data: {
          'email': email,
          'password': password,
        },
        options: Options(headers: {
          'authjs.csrf-token': csrfToken,
        }),
      );

      print(
          '===================== User Logged in : $email $password =====================');
    } on FirebaseAuthException catch (e) {
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

  // [SESSION] - CHECK SESSION
  Future<Map<String, dynamic>?> getSession() async {
    try {
      final user = await DioClient().get(Endpoints.session);
      return user.data;
    } on FirebaseAuthException catch (e) {
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

  // [Email Authentication] - SIGN IN
  Future<UserCredential> signInWithEmailPasswordFirebase({
    required String email,
    required String password,
  }) async {
    try {
      // Trigger the authentication flow firebase
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // await DioClient().post(
      //   Endpoints.signinWithCredentials,
      //   data: {
      //     'email': email,
      //     'password': password,
      //   },
      // );
    } on FirebaseAuthException catch (e) {
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

  // [Email Verification] - EMAIL VERIFICATION
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser!.sendEmailVerification();
      // final email = _auth.currentUser!.email!;
      // await DioClient().post(
      //   Endpoints.sendVerificationEmail,
      //   data: {
      //     'email': email,
      //   },
      // );
    } on FirebaseAuthException catch (e) {
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

  // [Email Reset Password ] - RESET PASSWORD
  Future<void> sendOtpResetPassword(email) async {
    try {
      // await _auth.sendPasswordResetEmail(email: email);
      await DioClient().post(
        Endpoints.resetPassword,
        data: {
          'email': email,
        },
      );
    } on FirebaseAuthException catch (e) {
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

  // Compare OTP Reset Password
  Future<void> compareOtpResetPassword(otp) async {
    try {
      await DioClient().post(
        Endpoints.compareOtpResetPassword,
        data: {
          'otp': otp,
        },
      );
    } on FirebaseAuthException catch (e) {
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

  // [Email Verification] - CREATE NEW VERIFICATION USER EMAIL
  Future<void> verifyEmail(email) async {
    try {
      await DioClient().patch(
        Endpoints.verifyEmail,
        data: {
          'email': email,
        },
      );
    } on FirebaseAuthException catch (e) {
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

  // [Email AUTH] - SIGN UP
  Future<UserCredential> signUpWithCredential(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
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

  // ----------------- Social Sign In -----------------
  // [GoogleAuthentication] - GOOGLE

  Future<UserCredential> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;

      final credentials = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await _auth.signInWithCredential(credentials);
    } on FirebaseAuthException catch (e) {
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

  // ----------------- Logout -----------------
  // [Sign Out] - SIGN OUT
  Future<void> signOut() async {
    try {
      // await DioClient().post(Endpoints.signout);
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const SigninScreen());
    } on FirebaseAuthException catch (e) {
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
}
