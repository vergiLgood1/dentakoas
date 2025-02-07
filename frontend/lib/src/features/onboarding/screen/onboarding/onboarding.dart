import 'package:denta_koas/src/features/onboarding/controller/onboarding_controller.dart';
import 'package:denta_koas/src/features/onboarding/screen/onboarding/widgets/onboarding_circular_button.dart';
import 'package:denta_koas/src/features/onboarding/screen/onboarding/widgets/onboarding_dot_navigation.dart';
import 'package:denta_koas/src/features/onboarding/screen/onboarding/widgets/onboarding_page.dart';
import 'package:denta_koas/src/features/onboarding/screen/onboarding/widgets/onboarding_skip.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardingController());

    // Data untuk onboarding pages
    final List<Map<String, String>> onBoardingData = [
      {
        "image": TImages.onBoardingImage1,
        "title": TTexts.onBoardingTitle1,
        "subTitle": TTexts.onBoardingSubTitle1,
      },
      {
        "image": TImages.onBoardingImage2,
        "title": TTexts.onBoardingTitle2,
        "subTitle": TTexts.onBoardingSubTitle2,
      },
      {
        "image": TImages.onBoardingImage3,
        "title": TTexts.onBoardingTitle3,
        "subTitle": TTexts.onBoardingSubTitle3,
      },
    ];

    return Scaffold(
      body: Stack(
        children: [
          // Horizontal Scroll PageView
          PageView.builder(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            itemCount: onBoardingData.length,
            itemBuilder: (context, index) {
              final item = onBoardingData[index];
              return OnBoardingPage(
                image: item["image"]!,
                title: item["title"]!,
                subTitle: item["subTitle"]!,
                isLootie: true,
              );
            },
          ),

          // Skip Button
          const OnBoardingSkip(),

          // Dot Navigations SmoothPageIndicator
          const OnBoardingDotNavigation(),

          // Circle Next Button
          const OnBoardingNextButton(),
        ],
      ),
    );
  }
}
