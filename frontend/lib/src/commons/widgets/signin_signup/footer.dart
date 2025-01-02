import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class DFooter extends StatelessWidget {
  const DFooter({
    super.key,
    required this.mainText,
    required this.linkText,
    this.onPressed,
  });

  final String mainText, linkText;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '$mainText ',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        GestureDetector(
          onTap: onPressed,
          child: Text(
            '$linkText ',
            style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: dark ? TColors.white : TColors.primary,
                  decoration: TextDecoration.underline,
                  decorationColor: dark ? TColors.white : TColors.primary,
                ),
          ),
        ),
      ],
    );
  }
}
