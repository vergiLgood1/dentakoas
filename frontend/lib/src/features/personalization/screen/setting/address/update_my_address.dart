import 'package:denta_koas/src/commons/widgets/appbar/appbar.dart';
import 'package:denta_koas/src/features/personalization/controller/update_address_controller.dart';
import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:denta_koas/src/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UpdateMyAddressScreen extends StatelessWidget {
  const UpdateMyAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateAddressController());
    return Scaffold(
      appBar: const DAppBar(
        showBackArrow: true,
        title: Text('Update My Address'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Please provide your address below',
              style: Theme.of(context).textTheme.bodySmall!.apply(
                    color: TColors.textSecondary,
                  ),
            ),
            const SizedBox(height: TSizes.spaceBtwInputFields),
            Form(
              key: controller.updateAddressFormKey,
              child: TextFormField(
                controller: controller.address,
                validator: (value) => TValidator.validateEmptyText(
                  "Address",
                  value,
                ),
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwSections),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => controller.updateUserAddress(),
                child: const Text('Update Address'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
