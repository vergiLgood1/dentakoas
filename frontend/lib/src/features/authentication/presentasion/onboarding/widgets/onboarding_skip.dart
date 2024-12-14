import 'package:denta_koas/src/features/authentication/controller/onboarding_controller.dart';
import 'package:denta_koas/src/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:denta_koas/src/utils/constants/text_strings.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';

class OnBoardingSkip extends StatelessWidget {
  const OnBoardingSkip({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: TDeviceUtils.getAppBarHeight(),
      right: TSizes.defaultSpace,
      child: TextButton(
        onPressed: OnBoardingController.instance.skipPage,
        child: Text(TTexts.skip, style: Theme.of(context).textTheme.bodyMedium),
      ),
    );
  }
}
