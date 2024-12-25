import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:denta_koas/src/utils/device/device_utility.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? avatar;
  final Widget? title;
  final IconData? leadingIcon;
  final List<Widget>? actions;
  final VoidCallback? leadingOnPressed;
  final bool showBackArrow;
  final bool centerTitle;

  const DAppBar({
    super.key,
    this.avatar,
    this.title,
    this.leadingIcon,
    this.actions,
    this.leadingOnPressed,
    this.showBackArrow = false,
    this.centerTitle = false,
   
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.md),
      child: AppBar(
        centerTitle: centerTitle,
        automaticallyImplyLeading: false,
        leading: showBackArrow
            ? IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(Icons.chevron_left),
              )
            : leadingIcon != null
                ? IconButton(
                    onPressed: leadingOnPressed,
                    icon: Icon(leadingIcon),
                  )
                : null,
        title: Row(
          mainAxisSize: MainAxisSize.min,  
          children: [
            if (avatar != null) ...[
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.transparent,
                child: avatar,
              ),
              const SizedBox(width: 8), // Spasi antara avatar dan title
            ],
            if (title != null) title!, // Title jika ada
          ],
        ),
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}
