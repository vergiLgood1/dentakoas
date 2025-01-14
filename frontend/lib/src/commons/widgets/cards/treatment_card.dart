import 'package:denta_koas/src/commons/widgets/containers/rounded_container.dart';
import 'package:denta_koas/src/commons/widgets/text/title_with_verified.dart';
import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/enums.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TreatmentCard extends StatelessWidget {
  const TreatmentCard({
    super.key,
    this.showBorder = true,
    this.onTap,
    required this.title,
    this.subtitle,
    this.image,
    this.isNetworkImage = false,
    this.textSizes = TextSizes.medium,
    this.backgroundColor = TColors.transparent,
    this.maxLines = 1,
    this.textAlign = TextAlign.center,
    this.showVerifiyIcon = true,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.bordeColor = TColors.borderPrimary,
  });

  final bool showBorder;
  final bool showVerifiyIcon;
  final void Function()? onTap;
  final String title;
  final String? subtitle;
  final String? image;
  final bool isNetworkImage;
  final TextSizes textSizes;
  final Color backgroundColor;
  final int maxLines;
  final TextAlign textAlign;
  final CrossAxisAlignment crossAxisAlignment;
  final Color bordeColor;

  @override
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: RoundedContainer(
        padding: const EdgeInsets.all(TSizes.sm),
        showBorder: showBorder,
        borderColor: bordeColor,
        backgroundColor: TColors.transparent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (image != null) 
              CircleAvatar(
              radius: 24,
              backgroundColor: backgroundColor,
                backgroundImage: isNetworkImage
                    ? NetworkImage(image!)
                    : AssetImage(image!) as ImageProvider,
              ),
            const SizedBox(width: TSizes.spaceBtwItems / 2),

            // Expanded for flexible text
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: crossAxisAlignment,
                children: [
                  if (showVerifiyIcon)
                    TitleWithVerified(
                    title: title,
                      textSizes: textSizes,
                    maxLines: maxLines,
                    textAlign: textAlign,
                    )
                  else
                    TitleWithVerified(
                      title: title,
                      textSizes: textSizes,
                      maxLines: maxLines,
                      textAlign: textAlign,
                      showIcon: false,
                  ),
                  
                  if (subtitle != null)
                  Text(
                      subtitle!,
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
