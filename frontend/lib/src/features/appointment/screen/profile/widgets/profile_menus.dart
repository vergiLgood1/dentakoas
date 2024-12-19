import 'package:denta_koas/src/features/appointment/controller/profile_controler.dart';
import 'package:denta_koas/src/features/appointment/screen/profile/widgets/profile_menu.dart';
import 'package:denta_koas/src/features/appointment/screen/profile/your_profile/your_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileMenus extends StatelessWidget {
  const ProfileMenus({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileControler());
    return Expanded(
      child: ListView(
        children: [
          ProfileMenuItem(
              icon: Icons.person_outline,
              text: 'Your profile',
              onTap: () => Get.to(() => const YourProfileScreen())),
          ProfileMenuItem(
              icon: Icons.favorite_border,
              text: 'Favourite',
              onTap: () => (() => ())),
          ProfileMenuItem(
              icon: Icons.settings_outlined,
              text: 'Settings',
              onTap: () => (() => ())),
          ProfileMenuItem(
              icon: Icons.help_outline,
              text: 'Help Center',
              onTap: () => (() => ())),
          ProfileMenuItem(
              icon: Icons.privacy_tip_outlined,
              text: 'Privacy Policy',
              onTap: () => (() => ())),
          ProfileMenuItem(
            icon: Icons.logout,
            text: 'Log out',
            onTap: () => controller.showLogoutDialog(context),
          ),
        ],
      ),
    );
  }
}
