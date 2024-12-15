import 'package:denta_koas/src/features/authentication/presentasion/signin/signin.dart';
import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/text_strings.dart';
import 'package:denta_koas/src/utils/helpers/helper_functions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DFooterSignUp extends StatelessWidget {
  const DFooterSignUp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '${TTexts.haveAnAccount} ',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          TextSpan(
            text: '${TTexts.signIn} ',
            style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: dark ? TColors.white : TColors.primary,
                  decoration: TextDecoration.underline,
                  decorationColor: dark ? TColors.white : TColors.primary,
                ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                // Navigasi ke halaman SignUp
                Get.offAll(const SigninScreen());
              },
          ),
        ],
      ),
    );
  }
}
