import 'package:denta_koas/src/commons/widgets/text/doctor_title_text.dart';
import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/enums.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class DoctorTitleWithVerified extends StatelessWidget {
  const DoctorTitleWithVerified({
    super.key,
    required this.title,
    this.maxLines = 1,
    this.textAlign = TextAlign.center,
    this.doctorTextSize = TextSizes.small,
    this.textColor,
    this.iconColor = TColors.primary,
  });

  final String title;
  final int maxLines;
  final TextAlign? textAlign;
  final TextSizes doctorTextSize;
  final Color? textColor, iconColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          child: DoctorTitleText(
            title: title,
            color: textColor,
            textAlign: textAlign,
            maxLines: maxLines,
            doctorTextSize: doctorTextSize,
          ),
        ),
        const SizedBox(width: TSizes.xs),
        Icon(
          Iconsax.verify5,
          color: iconColor,
          size: TSizes.iconXs,
        )
      ],
    );
  }
}
