import 'package:denta_koas/src/commons/widgets/appbar/appbar.dart';
import 'package:denta_koas/src/features/personalization/controller/update_profile_information_controller.dart';
import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:denta_koas/src/utils/constants/text_strings.dart';
import 'package:denta_koas/src/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ChangeProfileInformation extends StatelessWidget {
  const ChangeProfileInformation({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateProfileInformationController());
    return Scaffold(
      appBar: const DAppBar(
        showBackArrow: true,
        title: Text('Change Name'),
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
              key: controller.updateProfileInformationFormKey,
              child: Column(
                children: [
                  // First name
                  TextFormField(
                    controller: controller.givenName,
                    validator: (value) =>
                        TValidator.validateEmptyText(TTexts.firstName, value),
                    expands: false,
                    decoration: const InputDecoration(
                      labelText: TTexts.firstName,
                      prefixIcon: Icon(Iconsax.user),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwInputFields),

                  // Last Name
                  TextFormField(
                    controller: controller.familyName,
                    validator: (value) =>
                        TValidator.validateEmptyText(TTexts.lastName, value),
                    expands: false,
                    decoration: const InputDecoration(
                      labelText: TTexts.lastName,
                      prefixIcon: Icon(Iconsax.user),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwInputFields),

                  TextFormField(
                    controller: controller.username,
                    validator: (value) =>
                        TValidator.validateEmptyText(TTexts.username, value),
                    expands: false,
                    decoration: const InputDecoration(
                      labelText: TTexts.username,
                      prefixIcon: Icon(Iconsax.user),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwInputFields),

                  TextFormField(
                    controller: controller.phone,
                    validator: (value) =>
                        TValidator.validateEmptyText(TTexts.phoneNo, value),
                    expands: false,
                    decoration: const InputDecoration(
                      labelText: TTexts.phoneNo,
                      prefixIcon: Icon(Icons.phone),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwInputFields),

                  const SizedBox(height: TSizes.spaceBtwSections),

                  // Save button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () => controller.updateProfileInformation(),
                        child: const Text('Save')),
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
