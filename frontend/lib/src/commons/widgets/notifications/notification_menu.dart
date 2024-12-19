import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class NotificationCounterIcon extends StatelessWidget {
  final VoidCallback onPressed;
  final Color? iconColor;

  const NotificationCounterIcon({
    super.key,
    required this.onPressed,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          onPressed: onPressed,
          icon: const Icon(Iconsax.notification),
          color: iconColor,
        ),
        Positioned(
          right: 0,
          child: Container(
            width: TSizes.iconBase,
            height: TSizes.iconBase,
            decoration: BoxDecoration(
              color: TColors.primary,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Center(
              child: Text(
                '2',
                style: Theme.of(context).textTheme.labelLarge!.apply(
                      color: TColors.white,
                      fontSizeFactor: 0.8,
                    ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
