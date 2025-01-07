import 'dart:async';

import 'package:denta_koas/src/commons/widgets/state_screeen/state_screen.dart';
import 'package:denta_koas/src/cores/data/repositories/authentication.repository/authentication_repository.dart';
import 'package:denta_koas/src/features/authentication/screen/signup/profile-setup.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/constants/text_strings.dart';
import 'package:denta_koas/src/utils/popups/loaders.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  final localStorage = GetStorage();
  String currentUserEmail = '';

  @override
  void onInit() {
    sendVerificationEmail();
    setTimerForAutoRedirect();
    super.onInit();
  }

  // Send Verification Email
  sendVerificationEmail() async {
    try {
      final email = FirebaseAuth.instance.currentUser?.email;
      await AuthenticationRepository.instance.sendEmailVerification();
      TLoaders.successSnackBar(
        title: 'Verification Email Sent',
        message:
            'A verification email has been sent to $email. Please check your email and verify your account.',
      );
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh snap', message: e.toString());
    }
  }

  // Timer to automatically redirect on email verification
  setTimerForAutoRedirect() {
    Timer.periodic(
      const Duration(seconds: 1),
      (timer) async {
        // await FirebaseAuth.instance.currentUser!.reload();
        // final email = FirebaseAuth.instance.currentUser!.email;

  
        await FirebaseAuth.instance.currentUser!.reload();
        final currentUser = FirebaseAuth.instance.currentUser;

        // final currentUser =
        //     await UserRepository.instance.getUserByEmail(email!);
        if (currentUser?.emailVerified ?? false) {
          final email = currentUser?.email;
          await AuthenticationRepository.instance.verifyEmail(email);
          timer.cancel(); 
          Get.off(
            () => StateScreen(
              image: TImages.emailVerificationSuccess,
              title: TTexts.verificatonEmailSuccessTitle,
              subtitle: TTexts.verificatonEmailSuccessSubTitle,
              showButton: true,
              isLottie: true,
              secondaryTitle: "Complete Profile",
              onPressed: () =>
                  AuthenticationRepository.instance.screenRedirect(),
              onSecondaryPressed: () =>
                  Get.to(() => const ProfileSetupScreen()),
            ),
          );
        }
      },
    );
  }

  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      final email = currentUser.email;
      await AuthenticationRepository.instance.verifyEmail(email);
      Get.off(
        () => StateScreen(
          image: TImages.emailVerificationSuccess,
          title: TTexts.verificatonEmailSuccessTitle,
          subtitle: TTexts.verificatonEmailSuccessSubTitle,
          showButton: true,
          isLottie: true,
          primaryButtonTitle: TTexts.tContinue,
          secondaryButton: true,
          secondaryTitle: "Complete Profile",
          onPressed: () => AuthenticationRepository.instance.screenRedirect(),
          onSecondaryPressed: () => Get.to(() => const ProfileSetupScreen()),
        ),
      );
    }
  }
}
