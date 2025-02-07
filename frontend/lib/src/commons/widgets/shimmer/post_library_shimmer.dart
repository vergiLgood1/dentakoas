import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:denta_koas/src/utils/loaders/shimmer.dart';
import 'package:flutter/material.dart';

class ShimmerCardPostUser extends StatelessWidget {
  const ShimmerCardPostUser({super.key, required this.itemCount});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemCount,
      itemBuilder: (context, index) => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
          side: const BorderSide(
            color: TColors.grey,
          ),
        ),
        color: TColors.grey.withOpacity(0.0),
        elevation: 0,
        child: const Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace / 2),
          child: Column(
            children: [
              // Section 1
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      TShimmerEffect(width: 8.0, height: 8.0),
                      SizedBox(width: TSizes.spaceBtwItems / 4),
                      TShimmerEffect(width: 50.0, height: 10.0),
                    ],
                  ),
                  Row(
                    children: [
                      TShimmerEffect(width: 80.0, height: 10.0),
                      SizedBox(width: TSizes.spaceBtwItems / 4),
                      TShimmerEffect(width: 20.0, height: 20.0),
                    ],
                  ),
                ],
              ),
              SizedBox(height: TSizes.spaceBtwItems),
              // Section 2
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TShimmerEffect(width: 150.0, height: 20.0),
                    SizedBox(height: TSizes.spaceBtwItems / 2),
                    TShimmerEffect(width: double.infinity, height: 14.0),
                    SizedBox(height: TSizes.spaceBtwItems / 2),
                    TShimmerEffect(width: double.infinity, height: 14.0),
                  ],
                ),
              ),
              SizedBox(height: TSizes.spaceBtwItems),
              Divider(),
              SizedBox(height: TSizes.spaceBtwItems),
              // Section 3
              Align(
                alignment: Alignment.centerLeft,
                child: TShimmerEffect(width: 100.0, height: 10.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
