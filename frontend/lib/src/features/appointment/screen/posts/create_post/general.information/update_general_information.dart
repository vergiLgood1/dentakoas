import 'package:denta_koas/src/commons/widgets/appbar/appbar.dart';
import 'package:denta_koas/src/commons/widgets/text/section_heading.dart';
import 'package:denta_koas/src/features/appointment/controller/post.controller/general.information/update_general_information_controller.dart';
import 'package:denta_koas/src/features/appointment/screen/posts/create_post/widget/dropdown.dart';
import 'package:denta_koas/src/features/appointment/screen/posts/create_post/widget/dynamic_input.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:denta_koas/src/utils/popups/loaders.dart';
import 'package:denta_koas/src/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class UpdateGeneralInformation extends StatelessWidget {
  const UpdateGeneralInformation({super.key, this.postId});

  final String? postId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UpdateGeneralInformationController());

    if (postId == null) {
      TLoaders.errorSnackBar(title: 'Error', message: 'Post id is null');
    }

    final id = Get.arguments as String?;

    controller.initializedGeneralInformation(id!);
    return Scaffold(
      appBar: DAppBar(
        title: const Text('Create Post'),
        onBack: () => Get.back(),
        showBackArrow: true,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 0),
            child: IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(
            TSizes.defaultSpace,
          ),
          child: Form(
              key: controller.updateGeneralInformationFormKey,
              child: Column(
                children: [
                  //
                  const SectionHeading(
                    title: 'General Information',
                    showActionButton: false,
                  ),
                  const SizedBox(height: TSizes.spaceBtwInputFields),

                  // Title
                  TextFormField(
                    controller: controller.title,
                    validator: (value) =>
                        TValidator.validateEmptyText('Title', value),
                    expands: false,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.title),
                      labelText: 'Title',
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwInputFields),

                  // Description
                  TextFormField(
                    controller: controller.description,
                    validator: (value) =>
                        TValidator.validateEmptyText('Description', value),
                    expands: false,
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      alignLabelWithHint: true,
                      labelText: 'Description',
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwInputFields),

                  // max participant
                  TextFormField(
                    controller: controller.requiredParticipant,
                    validator: (value) =>
                        TValidator.validateEmptyText('Max Participant', value),
                    expands: false,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.group),
                      labelText: 'Required Participant',
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwInputFields),

                  // Category
                  Obx(() {
                    return DDropdownMenu(
                      hintText: 'Select Treatment',
                      prefixIcon: Iconsax.category,
                      validator: (value) =>
                          TValidator.validateEmptyText("Treatment", value),
                      items: controller.treatmentsMap.values.toList(),
                      onChanged: (value) {
                        if (value != null) {
                          controller.setSelectedTreatment(value);
                        }
                      },
                    );
                  }),

                  const SizedBox(height: TSizes.spaceBtwInputFields),

                  const DynamicInputForm(),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  // Submit Button

                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () => controller.updateGeneralInformation(),
                        child: const Text('Next'),
                      ),
                    ),
                  )
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: ElevatedButton(
                  //     style: ElevatedButton.styleFrom(
                  //       shape: RoundedRectangleBorder(
                  //         borderRadius: BorderRadius.circular(12),
                  //       ),
                  //     ),
                  //     onPressed: () {},
                  //     child: const Text('Submit'),
                  //   ),
                  // ),
                ],
              )),
        ),
      ),
    );
  }
}
