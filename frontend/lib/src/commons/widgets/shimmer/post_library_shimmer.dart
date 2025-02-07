import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:denta_koas/src/utils/loaders/shimmer.dart';
import 'package:flutter/material.dart';

class ShimmerPostCard extends StatelessWidget {
  const ShimmerPostCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: const IntrinsicHeight(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Row(
              children: [
                TShimmerEffect(width: 40.0, height: 40.0),
                SizedBox(width: TSizes.spaceBtwItems),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TShimmerEffect(width: 100.0, height: 10.0),
                    SizedBox(height: TSizes.spaceBtwItems / 2),
                    TShimmerEffect(width: 150.0, height: 10.0),
                  ],
                ),
                Spacer(),
                TShimmerEffect(width: 40.0, height: 10.0),
                SizedBox(width: TSizes.spaceBtwItems),
                TShimmerEffect(width: 20.0, height: 20.0),
              ],
            ),
            SizedBox(height: TSizes.spaceBtwItems),
            // Title Section
            TShimmerEffect(width: double.infinity, height: 20.0),
            SizedBox(height: TSizes.spaceBtwItems / 2),
            TShimmerEffect(width: double.infinity, height: 14.0),
            SizedBox(height: TSizes.spaceBtwSections),
            // Stats Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TShimmerEffect(width: 80.0, height: 10.0),
                TShimmerEffect(width: 80.0, height: 10.0),
                TShimmerEffect(width: 80.0, height: 10.0),
              ],
            ),
            SizedBox(height: TSizes.spaceBtwItems),
            Divider(),
            SizedBox(height: TSizes.spaceBtwItems),
            // Footer Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TShimmerEffect(width: 100.0, height: 10.0),
                TShimmerEffect(width: 100.0, height: 10.0),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ShimmerPostList extends StatelessWidget {
  const ShimmerPostList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 10, // You can adjust the item count as needed
      itemBuilder: (context, index) {
        return const ShimmerPostCard();
      },
    );
  }
}

class ShimmerPostLibrary extends StatelessWidget {
  const ShimmerPostLibrary({super.key, required this.itemCount});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: itemCount,
      separatorBuilder: (_, __) => const SizedBox(height: TSizes.spaceBtwItems),
      itemBuilder: (_, __) {
        return const ShimmerPostCard();
      },
    );
  }
}
