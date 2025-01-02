import 'package:denta_koas/src/commons/widgets/appbar/appbar.dart';
import 'package:denta_koas/src/features/appointment/screen/posts/create_post/widget/dropdown.dart';
import 'package:denta_koas/src/features/authentication/controller/signup/profile_setup_controller.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:denta_koas/src/utils/constants/text_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class ProfileSetupScreen extends StatelessWidget {
  const ProfileSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileSetupController());
    final role = controller.localStorage.read('SELECTED_ROLE');
    return Scaffold(
      appBar: DAppBar(
        actions: [
          IconButton(
            icon: const Icon(Iconsax.arrow_left),
            onPressed: () => Get.back(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Header
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text('Setup Your Profile',
                      style: Theme.of(context).textTheme.headlineMedium),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  // Form
                  Form(
                    key: controller.profileSetupFormKey,
                    child: Column(
                      children: [
                        if (role == 'Koas') ...[
                          // Koas Number
                          TextFormField(
                            controller: controller.koasNumber,
                            decoration: const InputDecoration(
                              labelText: 'Koas Number',
                              prefixIcon: Icon(Iconsax.personalcard),
                            ),
                          ),
                          const SizedBox(height: TSizes.spaceBtwItems),

                          // Departement
                          TextFormField(
                            controller: controller.departement,
                            decoration: const InputDecoration(
                              labelText: 'Departement',
                              prefixIcon: Icon(Iconsax.book),
                            ),
                          ),
                          const SizedBox(height: TSizes.spaceBtwItems),

                          // University
                          DDropdownMenu(
                            hintText: 'Select University',
                            prefixIcon: Iconsax.building_4,
                            selectedItem: controller.selectedUniversity,
                            items: controller.universities,
                            onChanged: (value) =>
                                controller.selectedUniversity = value!,
                          ),
                          const SizedBox(height: TSizes.spaceBtwItems),
                        ],

                        // Age
                        TextFormField(
                          controller: controller.age,
                          decoration: const InputDecoration(
                            labelText: 'Age',
                            prefixIcon: Icon(Iconsax.cake),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems),

                        // Gender

                        DDropdownMenu(
                          hintText: 'Select Gender',
                          prefixIcon: Iconsax.user,
                          selectedItem: controller.selectedGender,
                          items: controller.genders,
                          onChanged: (value) =>
                              controller.selectedGender = value!,
                        ),

                        // TextFormField(
                        //   controller: controller.gender,
                        //   decoration: const InputDecoration(
                        //     labelText: 'Gender',
                        //     prefixIcon: Icon(Iconsax.user),
                        //   ),
                        // ),
                        const SizedBox(height: TSizes.spaceBtwItems),

                        // Bio
                        TextFormField(
                          controller: controller.bio,
                          decoration: const InputDecoration(
                            labelText: 'Please tell us about yourself',
                            alignLabelWithHint: true,
                          ),
                          maxLines: 5,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: TSizes.spaceBtwSections),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => controller.setupProfile(),
                      child: const Text(TTexts.signUp),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
