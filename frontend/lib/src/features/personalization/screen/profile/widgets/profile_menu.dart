import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu({
    super.key,
    this.icon = Iconsax.arrow_right_34,
    required this.title,
    required this.value,
    required this.onTap,
    this.showIcon = true,
    this.color,
  });

  final IconData icon;
  final String title, value;
  final VoidCallback onTap;
  final bool? showIcon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: TSizes.spaceBtwItems / 1.5),
        child: Row(
          mainAxisAlignment: showIcon!
              ? MainAxisAlignment.start
              : MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 3,
              child: Text(
                title,
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              flex: 5,
              child: Text(
                value,
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (showIcon!)
              Expanded(
                child: Icon(
                  icon,
                  size: 18,
                  color: color,
                ),
              )
          ],
        ),
      ),
    );
  }
}
