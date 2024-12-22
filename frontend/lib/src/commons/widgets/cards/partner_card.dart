import 'package:denta_koas/src/commons/widgets/containers/rounded_container.dart';
import 'package:denta_koas/src/commons/widgets/text/doctor_title_with_verified.dart';
import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/enums.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class PartnertCard extends StatelessWidget {
  const PartnertCard({
    super.key,
    this.showBorder = true,
    this.onTap,
    required this.title,
    required this.subtitle,
    required this.image,
    this.isNetworkImage = false,
    this.doctorTextSize = TextSizes.medium,
    this.backgroundColor = TColors.transparent,
    this.maxLines = 1,
    this.textAlign = TextAlign.center,
  });

  final bool showBorder;
  final void Function()? onTap;
  final String title;
  final String subtitle;
  final String image;
  final bool isNetworkImage;
  final TextSizes doctorTextSize;
  final Color backgroundColor;
  final int maxLines;
  final TextAlign textAlign;

  @override
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: RoundedContainer(
        padding: const EdgeInsets.all(TSizes.sm),
        showBorder: showBorder,
        backgroundColor: TColors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: backgroundColor,
              backgroundImage:
                  isNetworkImage ? NetworkImage(image) : AssetImage(image),
            ),
            const SizedBox(width: TSizes.spaceBtwItems / 2),

            // Expanded for flexible text
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DoctorTitleWithVerified(
                    title: title,
                    doctorTextSize: doctorTextSize,
                    maxLines: maxLines,
                    textAlign: textAlign,
                  ),
                  Text(
                    subtitle,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium!,
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
