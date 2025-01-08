import 'package:denta_koas/src/commons/widgets/appbar/appbar.dart';
import 'package:denta_koas/src/commons/widgets/containers/primary_header_container.dart';
import 'package:denta_koas/src/commons/widgets/images/circular_image.dart';
import 'package:denta_koas/src/commons/widgets/list_tiles/setting_menu_tile.dart';
import 'package:denta_koas/src/commons/widgets/text/section_heading.dart';
import 'package:denta_koas/src/cores/data/repositories/authentication.repository/authentication_repository.dart';
import 'package:denta_koas/src/features/personalization/controller/user_controller.dart';
import 'package:denta_koas/src/features/personalization/screen/profile/profile.dart';
import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            PrimaryHeaderContainer(
              child: Column(
                children: [
                  // AppBar
                  DAppBar(
                    title: Text(
                      'Account',
                      style: Theme.of(context).textTheme.headlineMedium!.apply(
                            color: TColors.textWhite,
                          ),
                    ),
                  ),

                  // User Profile Card
                  DProfileMenu(
                    onPressed: () => Get.to(() => const ProfileScreen()),
                  ),
    
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                ],
              ),
            ),

            // Body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  // Account settings
                  const SectionHeading(
                    title: 'Account Settings',
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),

                  const SettingMenuTile(
                    icon: Iconsax.safe_home,
                    title: 'My Address',
                    subtitle: 'Set your default address',
                  ),
                  const SettingMenuTile(
                    icon: Iconsax.calendar_1,
                    title: 'My Appointments',
                    subtitle: 'View your appointments',
                  ),
                  const SettingMenuTile(
                    icon: Iconsax.notification,
                    title: 'Notifications',
                    subtitle: 'Set any kind of notifications',
                  ),
                  const SettingMenuTile(
                    icon: Iconsax.security_card,
                    title: 'Account Privacy',
                    subtitle: 'Control your privacy settings',
                  ),
                  const SettingMenuTile(
                    icon: Iconsax.user_remove,
                    title: 'Change Account',
                    subtitle: 'Change your account ',
                  ),

                  // App settings
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  const SectionHeading(
                    title: 'App Settings',
                    showActionButton: false,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  SettingMenuTile(
                    icon: Iconsax.location,
                    title: 'Geolocation',
                    subtitle: 'Set recomendarions based on your location',
                    trailing: Switch(value: true, onChanged: (value) {}),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

                  // Logout button
                  SettingMenuTile(
                    icon: Iconsax.logout,
                    title: 'Logout',
                    subtitle: 'Logout from your account',
                    onTap: () => AuthenticationRepository.instance.signOut(), 
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DProfileMenu extends StatelessWidget {
  const DProfileMenu({
    super.key,
    required this.onPressed,
  });

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return Obx(() {
      if (controller.profileLoading.value) {
        return const SizedBox();
      } else {
        return ListTile(
          leading: const CircularImage(
            image: TImages.user,
            width: 50,
            height: 50,
            padding: 0,
          ),
          title: Text(
            controller.user.value.fullName,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .apply(color: TColors.textWhite),
          ),
          subtitle: Text(
            controller.user.value.email!,
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .apply(color: TColors.textWhite),
          ),
          trailing: IconButton(
            onPressed: onPressed,
            icon: const Icon(Iconsax.edit),
            color: TColors.white,
          ),
        );
      }
    });
  }
}
