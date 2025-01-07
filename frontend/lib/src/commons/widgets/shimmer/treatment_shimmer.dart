import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:denta_koas/src/utils/loaders/shimmer.dart';
import 'package:flutter/material.dart';

class TreatmentShimmer extends StatelessWidget {
  const TreatmentShimmer({super.key, required this.itemCount});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 80,
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: itemCount,
          scrollDirection: Axis.horizontal,
          separatorBuilder: (_, __) => const SizedBox(
            width: TSizes.spaceBtwItems,
          ),
          itemBuilder: (_, __) {
            return const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image treatment
                TShimmerEffect(widht: 55, height: 55, radius: 55),
                SizedBox(height: TSizes.spaceBtwItems / 2),

                // Text treatment
                TShimmerEffect(widht: 55, height: 5),
              ],
            );
          },
        ));
  }
}
