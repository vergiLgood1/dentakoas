import 'package:denta_koas/src/commons/widgets/text/title_text.dart';
import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/enums.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class TitleWithVerified extends StatelessWidget {
  const TitleWithVerified({
    super.key,
    required this.title,
    this.maxLines = 1,
    this.textAlign = TextAlign.center,
    this.doctorTextSize = TextSizes.small,
    this.textColor,
    this.iconColor = TColors.primary,
    this.showIcon = true,
  });

  final String title;
  final int maxLines;
  final TextAlign? textAlign;
  final TextSizes doctorTextSize;
  final Color? textColor, iconColor;
  final bool showIcon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: TitleText(
            title: title,
            color: textColor,
            textAlign: textAlign,
            maxLines: maxLines,
            doctorTextSize: doctorTextSize,
          ),
        ),
        const SizedBox(width: TSizes.xs),
        if (showIcon)
          Icon(
            Iconsax.verify5,
            color: iconColor,
            size: TSizes.iconXs,
          )
      ],
    );
  }
}
