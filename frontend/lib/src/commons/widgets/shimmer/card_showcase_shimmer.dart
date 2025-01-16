import 'package:denta_koas/src/commons/widgets/containers/rounded_container.dart';
import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:denta_koas/src/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CardShowcaseShimmer extends StatelessWidget {
  const CardShowcaseShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return RoundedContainer(
      showBorder: true,
      borderColor: TColors.darkGrey,
      backgroundColor: TColors.transparent,
      padding: const EdgeInsets.all(TSizes.md),
      margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
      child: Column(
        children: [
          // Shimmer for TreatmentCard
          Shimmer.fromColors(
            baseColor: dark ? Colors.grey[850]! : Colors.grey[300]!,
            highlightColor: dark ? Colors.grey[700]! : Colors.grey[100]!,
            child: const RoundedContainer(
              height: 80,
              backgroundColor: TColors.lightGrey,
              margin: EdgeInsets.only(bottom: TSizes.sm),
            ),
          ),
          // Shimmer for images
          Row(
            children: List.generate(3, (index) {
              return Expanded(
                child: Shimmer.fromColors(
                  baseColor: dark ? Colors.grey[850]! : Colors.grey[300]!,
                  highlightColor: dark ? Colors.grey[700]! : Colors.grey[100]!,
                  child: const RoundedContainer(
                    height: 100,
                    backgroundColor: TColors.lightGrey,
                    margin: EdgeInsets.only(right: TSizes.sm),
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
