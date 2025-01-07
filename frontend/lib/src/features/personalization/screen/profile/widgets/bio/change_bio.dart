import 'package:denta_koas/src/commons/widgets/appbar/appbar.dart';
import 'package:denta_koas/src/features/personalization/controller/update_bio_controller.dart';
import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:denta_koas/src/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeBioScreen extends StatelessWidget {
  const ChangeBioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateBioController());
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
              key: controller.updateBioFormKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: controller.bio,
                    validator: (value) =>
                        TValidator.validateEmptyText("Bio", value),
                    decoration: const InputDecoration(
                      labelText: 'Please tell us about yourself',
                      alignLabelWithHint: true,
                    ),
                    maxLines: 5,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  // Save button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () => controller.updateBio(),
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
