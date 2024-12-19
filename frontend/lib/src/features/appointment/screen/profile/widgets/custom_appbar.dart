import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new),
        onPressed: () => Get.back(),
      ),
      title: const Text(
        'Profile',
        style:
            TextStyle(fontWeight: FontWeight.bold, fontSize: TSizes.fontSizeLg),
      ),
      centerTitle: true,
      elevation: 0,
      iconTheme: const IconThemeData(color: TColors.black),
    );
  }
}
