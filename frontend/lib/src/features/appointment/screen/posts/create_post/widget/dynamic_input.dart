import 'package:denta_koas/src/commons/widgets/text/section_heading.dart';
import 'package:denta_koas/src/features/appointment/controller/post.controller/posts_controller.dart';
import 'package:denta_koas/src/features/appointment/data/model/post_model.dart';
import 'package:denta_koas/src/features/personalization/controller/user_controller.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class DynamicInputForm extends StatelessWidget {
  const DynamicInputForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InputController());

    // Initialize inputs with 3 default fields
    controller.initializeInputs(3);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeading(
          title: 'Requirement',
          isSuffixIcon: true,
          suffixIcon: Icons.add,
          onPressed: controller.addInputRequirment,
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),
        Obx(
          () => Column(
            children: List.generate(
              controller.patientRequirements.length,
              (index) => Column(
                children: [
                  TextFormField(
                    controller: controller.patientRequirements[index],
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.checklist),
                      suffixIcon: controller.patientRequirements.length > 1
                          ? IconButton(
                              icon: const Icon(Icons.remove),
                              onPressed: () =>
                                  controller.removeInputRequirement(index),
                            )
                          : null,
                      labelText: 'Requirement ${index + 1}',
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwInputFields),
                ],
              ),
            ),
          ),
        ),
        // ElevatedButton(
        //   onPressed: () {
        //     final values = controller.getAllValues();
        //     Logger().i(values);

        //   },
        //   child: const Text('Submit'),
        // ),
      ],
    );
  }
}

