import 'package:denta_koas/src/commons/widgets/state_screeen/state_screen.dart';
import 'package:denta_koas/src/features/authentication/screen/signin/signin.dart';
import 'package:denta_koas/src/features/authentication/screen/signup/role_option.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          StateScreen(
            image: TImages.welcomeImage1,
            title: 'Welcome to Denta Koas',
            subtitle:
                'Discover a new way to manage your dental practice with ease and efficiency!',
            showButton: true,
            primaryButtonTitle: 'Get Started',
            secondaryButton: true,
            secondaryTitle: 'Sign In',
            onPressed: () => Get.to(() => const ChooseRolePage()),
            onSecondaryPressed: () => Get.to(() => SigninScreen),
          ),
        ],
      ),
    );
  }
}
