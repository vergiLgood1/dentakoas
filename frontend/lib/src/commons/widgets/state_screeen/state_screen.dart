import 'package:denta_koas/src/commons/styles/spacing_styles.dart';
import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:denta_koas/src/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class StateScreen extends StatelessWidget {
  const StateScreen({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
    this.onPressed,
    this.child,
    this.showButton = false,
    this.secondaryButton = false,
    this.secondaryTitle = 'Contiue',
    this.primaryButtonTitle = 'Continue',
    this.onSecondaryPressed,
  });

  final String image, title, subtitle;
  final String primaryButtonTitle;
  final String secondaryTitle;
  final VoidCallback? onPressed;
  final VoidCallback? onSecondaryPressed;
  final bool showButton;
  final bool secondaryButton;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: DSpacingStyle.paddingWithAppBarHeight * 2,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Image
                Image(
                  image: AssetImage(image),
                  width: THelperFunctions.screenWidth(),
                ),
                const SizedBox(height: TSizes.spaceBtwSections),

                // Title & subtitle
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.labelMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: TSizes.spaceBtwSections),

                // Button
                if (showButton)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: onPressed,
                      child: Text(primaryButtonTitle),
                    ),
                  ),
                const SizedBox(height: TSizes.spaceBtwItems),

                if (secondaryButton)
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: onSecondaryPressed,
                      style: ElevatedButton.styleFrom(
                        side: const BorderSide(color: Colors.transparent),
                      ),
                      child: Text(
                        secondaryTitle,
                        style: const TextStyle(
                          color: TColors.primary,
                        ),
                      ),
                    ),
                  ),

                // Additional child widget
                if (child != null) child!,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
