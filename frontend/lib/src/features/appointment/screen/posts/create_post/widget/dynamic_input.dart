import 'package:denta_koas/src/commons/widgets/text/section_heading.dart';
import 'package:denta_koas/src/features/appointment/controller/post_controller';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DynamicInputForm extends StatelessWidget {
  const DynamicInputForm({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PostController());

    // Initialize inputs with 4 default fields
    controller.inputController.initializeInputs(3);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeading(
          title: 'Requirement',
          isSuffixIcon: true,
          suffixIcon: Icons.add,
          onPressed: controller.inputController.addInputRequirment,
        ),
        const SizedBox(height: TSizes.spaceBtwInputFields),
        Obx(
          () => Column(
            children: controller.inputController.inputs
                .map(
                  (input) => Column(
                    children: [
                      TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.checklist),
                          suffixIcon:
                              controller.inputController.inputs.length != 1
                                  ? IconButton(
                                      icon: const Icon(Icons.remove),
                                      onPressed: () => controller
                                          .inputController
                                          .removeInputRequirement(
                                        controller.inputController.inputs
                                            .indexOf(input),
                                      ),
                                    )
                                  : null,
                          labelText:
                              'Requirement ${controller.inputController.inputs.indexOf(input) + 1}',
                        ),
                      ),
                      const SizedBox(height: TSizes.spaceBtwInputFields),
                    ],
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
