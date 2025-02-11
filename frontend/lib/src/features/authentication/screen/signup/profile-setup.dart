import 'package:denta_koas/src/commons/widgets/appbar/appbar.dart';
import 'package:denta_koas/src/features/appointment/controller/university.controller/university_controller.dart';
import 'package:denta_koas/src/features/appointment/screen/posts/create_post/widget/dropdown.dart';
import 'package:denta_koas/src/features/authentication/controller/signup/profile_setup_controller.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:denta_koas/src/utils/constants/text_strings.dart';
import 'package:denta_koas/src/utils/validators/validation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';

class ProfileSetupScreen extends StatelessWidget {
  const ProfileSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileSetupController());
    final universityController = Get.put(UniversityController());
  
    final localStorage = GetStorage();
    final role = localStorage.read('TEMP_ROLE');

    return Scaffold(
      appBar: DAppBar(
        showBackArrow: true,
        leadingOnPressed: () => Get.back(),
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
                          // Koas-specific fields
                          TextFormField(
                            controller: controller.koasNumber,
                            validator: (value) => TValidator.validateEmptyText(
                                "Koas Number", value),
                            decoration: const InputDecoration(
                              labelText: 'Koas Number',
                              prefixIcon: Icon(Iconsax.personalcard),
                            ),
                          ),
                          const SizedBox(height: TSizes.spaceBtwInputFields),
                          TextFormField(
                            controller: controller.departement,
                            validator: (value) => TValidator.validateEmptyText(
                                "Departement", value),
                            decoration: const InputDecoration(
                              labelText: 'Departement',
                              prefixIcon: Icon(Iconsax.book),
                            ),
                          ),
                          const SizedBox(height: TSizes.spaceBtwInputFields),
                          DDropdownMenu(
                            hintText: 'Select University',
                            prefixIcon: Iconsax.building_4,
                            validator: (value) => TValidator.validateEmptyText(
                                "University", value),
                            items: controller.universitiesData,
                            onChanged: (value) =>
                                controller.selectedUniversity = value!,
                          ),
                          const SizedBox(height: TSizes.spaceBtwInputFields),
                        ],
                        if (role == 'Koas' || role == 'Pasien') ...[
                          // Fields shared by Koas and Pasien
                          TextFormField(
                            controller: controller.age,
                            validator: (value) =>
                                TValidator.validateEmptyText("Age", value),
                            decoration: const InputDecoration(
                              labelText: 'Age',
                              prefixIcon: Icon(Iconsax.cake),
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                          ),
                          const SizedBox(height: TSizes.spaceBtwInputFields),
                          DDropdownMenu(
                            hintText: 'Select Gender',
                            prefixIcon: Iconsax.user,
                            validator: (value) =>
                                TValidator.validateEmptyText("Gender", value),
                            items: controller.genders,
                            onChanged: (value) =>
                                controller.selectedGender = value!,
                          ),
                          const SizedBox(height: TSizes.spaceBtwInputFields),
                        ],
                        if (role == 'Koas') ...[
                          // Koas-specific field
                          // TextFormField(
                          //   controller: controller.whatsappLink,
                          //   validator: (value) => TValidator.validateEmptyText(
                          //       "WhatsApp Link", value),
                          //   decoration: const InputDecoration(
                          //     labelText: 'WhatsApp Link',
                          //     prefixIcon: Icon(Icons.phone_android_outlined),
                          //   ),
                          // ),
                          // const SizedBox(height: TSizes.spaceBtwInputFields),
                        ],
                        if (role == 'Koas' || role == 'Pasien') ...[
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
                          const SizedBox(height: TSizes.spaceBtwInputFields),
                        ],
                        if (role == 'Fasilitator') ...[
                          // University field for Koas and Fasilitator
                          DDropdownMenu(
                            hintText: 'Select University',
                            prefixIcon: Iconsax.building_4,
                            validator: (value) => TValidator.validateEmptyText(
                                "University", value),
                            items: controller.universitiesData,
                            onChanged: (value) =>
                                controller.selectedUniversity = value!,
                          ),
                          const SizedBox(height: TSizes.spaceBtwInputFields),
                        ],
                  
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
