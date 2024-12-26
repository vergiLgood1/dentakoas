import 'package:denta_koas/src/utils/constants/enums.dart';
import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  const TitleText({
    super.key,
    this.color,
    required this.title,
    this.maxLines = 1,
    this.textAlign = TextAlign.center,
    this.textSizes = TextSizes.small,
  });

  final Color? color;
  final String title;
  final int maxLines;
  final TextAlign? textAlign;
  final TextSizes textSizes;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: TextOverflow.ellipsis,
      // Check which textSizes is required and set that style.
      style: textSizes == TextSizes.xs
          ? Theme.of(context).textTheme.bodySmall!.apply(color: color)
          : textSizes == TextSizes.small
              ? Theme.of(context).textTheme.labelMedium!.apply(color: color)
              : textSizes == TextSizes.base
                  ? Theme.of(context).textTheme.bodyMedium!.apply(color: color)
                  : textSizes == TextSizes.medium
                      ? Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .apply(color: color)
                      : Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .apply(color: color),
    );
  }
}
