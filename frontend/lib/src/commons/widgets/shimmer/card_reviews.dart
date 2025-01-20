import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ShimmerUserReviewsCard extends StatelessWidget {
  final int itemCount;

  const ShimmerUserReviewsCard({super.key, required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemCount: itemCount,
        itemBuilder: (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          backgroundColor: Colors.grey,
                        ),
                        const SizedBox(width: TSizes.spaceBtwItems),
                        Container(
                          width: 100,
                          height: 20,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                    const SizedBox(width: TSizes.spaceBtwItems),
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.more_vert))
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwItems),

                // Review
                Row(
                  children: [
                    Container(
                      width: 100,
                      height: 20,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: TSizes.spaceBtwItems),
                    Container(
                      width: 80,
                      height: 20,
                      color: Colors.grey,
                    ),
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                Container(
                  width: double.infinity,
                  height: 60,
                  color: Colors.grey,
                ),
                const SizedBox(height: TSizes.spaceBtwSections),
              ],
            ),
          );
        },
      ),
    );
  }
}
