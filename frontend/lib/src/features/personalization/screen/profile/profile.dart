import 'package:denta_koas/src/commons/widgets/appbar/appbar.dart';
import 'package:denta_koas/src/commons/widgets/images/circular_image.dart';
import 'package:denta_koas/src/commons/widgets/text/section_heading.dart';
import 'package:denta_koas/src/features/personalization/screen/profile/widgets/profile_menu.dart';
import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DAppBar(
        showBackArrow: true,
        title: Text('Profile'),
      ),

      // Body
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(
            TSizes.defaultSpace,
          ),
          child: Column(
            children: [
              // Profile picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    const CircularImage(
                      image: TImages.user,
                      widht: 80,
                      height: 80,
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Change Profile Picture'),
                    )
                  ],
                ),
              ),

              // Profile details
              const SizedBox(
                height: TSizes.spaceBtwItems / 2,
              ),
              const Divider(),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              const SectionHeading(
                title: 'Profile Information',
                showActionButton: false,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              ProfileMenu(
                title: 'Name',
                value: 'user',
                onTap: () {},
              ),
              ProfileMenu(
                title: 'Username',
                value: 'user_name',
                onTap: () {},
              ),

              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              const Divider(),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              // Heading Personal Information
              const SectionHeading(
                title: 'Personal Information',
                showActionButton: false,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              ProfileMenu(
                title: 'User ID',
                value: '12345',
                icon: Iconsax.copy,
                onTap: () {},
              ),
              ProfileMenu(
                title: 'Email',
                value: 'user@app.com',
                onTap: () {},
              ),
              ProfileMenu(
                title: 'Phone',
                value: 'user_phone',
                onTap: () {},
              ),
              ProfileMenu(
                title: 'Gender',
                value: 'Man',
                onTap: () {},
              ),
              const Divider(),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: TColors.error),
                  ),
                  child: const Text(
                    'Close Account',
                    style: TextStyle(color: TColors.error),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
