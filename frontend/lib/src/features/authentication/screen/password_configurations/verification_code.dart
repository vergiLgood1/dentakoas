import 'package:denta_koas/src/commons/widgets/signin_signup/footer.dart';
import 'package:denta_koas/src/features/authentication/screen/password_configurations/reset_password.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:denta_koas/src/utils/constants/text_strings.dart';
import 'package:denta_koas/src/utils/helpers/helper_functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:get/get.dart';

class VerificationCodeScreen extends StatelessWidget {
  const VerificationCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(CupertinoIcons.clear),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Image
              Image(
                image: const AssetImage(TImages.deliveredEmailIllustration),
                width: THelperFunctions.screenWidth() * 0.6,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Title & subtitle
              Text(
                TTexts.verificationCodeTitle,
                style: Theme.of(context).textTheme.headlineMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              Text(
                TTexts.verficationCodeSubtitle,
                style: Theme.of(context).textTheme.labelMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // OTP Input
              OtpTextField(
                numberOfFields: 5, // Menggunakan konstanta 6 digit
                borderColor: Theme.of(context).colorScheme.primary,
                focusedBorderColor: Theme.of(context).colorScheme.secondary,
                cursorColor: Theme.of(context).colorScheme.primary,
                fieldWidth: 50,
                showFieldAsBox: true,
                onCodeChanged: (String code) {
                  // Aksi opsional jika input berubah
                },
                onSubmit: (String verificationCode) {
                  Get.to(() => const ResetPasswordScreen());
                },
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // Footer
              const DFooter(
                mainText: TTexts.notReceivingCode,
                linkText: TTexts.resendCode,
              )
            ],
          ),
        ),
      ),
    );
  }
}
