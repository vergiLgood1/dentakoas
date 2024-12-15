import 'package:denta_koas/src/commons/widgets/signin_signup/form_divider.dart';
import 'package:denta_koas/src/commons/widgets/signin_signup/social_buttons.dart';
import 'package:denta_koas/src/features/authentication/presentasion/signup/widgets/signup_footer.dart';
import 'package:denta_koas/src/features/authentication/presentasion/signup/widgets/signup_form.dart';
import 'package:denta_koas/src/features/authentication/presentasion/signup/widgets/signup_header.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:denta_koas/src/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              const DSignUpHeader(),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Form
              const DSignUpForm(),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Divider
              DFormDivider(dividerText: TTexts.orSignUpWith.capitalize!),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Footer Social Buttons
              const DSocialButtons(),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Footer
              const DFooterSignUp()
            ],
          ),
        ),
      ),
    );
  }
}
