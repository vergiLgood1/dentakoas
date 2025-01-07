import 'package:denta_koas/src/commons/widgets/appbar/appbar.dart';
import 'package:denta_koas/src/features/personalization/controller/user_controller.dart';
import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:denta_koas/src/utils/constants/text_strings.dart';
import 'package:denta_koas/src/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ReauthLoginForm extends StatelessWidget {
  const ReauthLoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      appBar: const DAppBar(
        showBackArrow: true,
        title: Text('Re-authenticate'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            Text(
              'Use real name for easy verification. This name will appear on several pages.',
              style: Theme.of(context).textTheme.bodySmall!.apply(
                    color: TColors.textSecondary,
                  ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            // TextFields and button
            Form(
              key: controller.reAuthFormKey,
              child: Column(
                children: [
                  // First name
                  TextFormField(
                    controller: controller.email,
                    validator: (value) =>
                        TValidator.validateEmptyText(TTexts.email, value),
                    expands: false,
                    decoration: const InputDecoration(
                      labelText: TTexts.email,
                      prefixIcon: Icon(Iconsax.user),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwInputFields),

                  // Last Name
                  TextFormField(
                    controller: controller.password,
                    validator: (value) =>
                        TValidator.validateEmptyText(TTexts.password, value),
                    expands: false,
                    decoration: const InputDecoration(
                      labelText: TTexts.password,
                      prefixIcon: Icon(Iconsax.user),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  // Save button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () => controller.reAuthenticate(),
                        child: const Text(TTexts.submit)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
