import 'package:flutter/material.dart';

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    super.key,
    this.textColor,
    this.showActionButton = true,
    this.isSuffixIcon = false,
    this.suffixIcon,
    required this.title,
    this.buttonTitle = 'View all',
    this.onPressed,
  });

  final Color? textColor;
  final bool showActionButton;
  final bool isSuffixIcon;
  final IconData? suffixIcon;
  final String title, buttonTitle;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall!
                  .apply(color: textColor),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ], 
        ),
        if (showActionButton)
          isSuffixIcon
              ? IconButton(
                  onPressed: onPressed,
                  icon: Icon(suffixIcon),
                )
              : TextButton(
                  onPressed: onPressed,
                  child: Text(buttonTitle),
                ),
      ],
    );
  }
}
