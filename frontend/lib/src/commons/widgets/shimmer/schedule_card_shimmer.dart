import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ScheduleCardShimmer extends StatelessWidget {
  const ScheduleCardShimmer({super.key, required this.itemCount});
  final int itemCount;

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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: TColors.white,
                      borderRadius: BorderRadius.circular(TSizes.cardRadiusMd),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.grey[300],
                            ),
                            const SizedBox(
                              width: TSizes.spaceBtwInputFields,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 20,
                                    width: 100,
                                    color: Colors.grey[300],
                                  ),
                                  const SizedBox(
                                      height: TSizes.spaceBtwItems / 4),
                                  Container(
                                    height: 14,
                                    width: 60,
                                    color: Colors.grey[300],
                                  ),
                                ],
                              ),
                            ),
                            const Icon(
                              Icons.chevron_right,
                              color: Colors.grey,
                              size: TSizes.iconLg,
                            ),
                          ],
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems),
                        Divider(
                          color: Colors.grey[300],
                          thickness: 0.1,
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  color: Colors.grey[300],
                                  size: TSizes.iconMd,
                                ),
                                const SizedBox(width: TSizes.spaceBtwItems / 2),
                                Container(
                                  height: 14,
                                  width: 60,
                                  color: Colors.grey[300],
                                ),
                              ],
                            ),
                            const SizedBox(width: TSizes.spaceBtwItems),
                            Row(
                              children: [
                                Icon(
                                  Icons.access_time,
                                  color: Colors.grey[300],
                                  size: TSizes.iconMd,
                                ),
                                const SizedBox(width: TSizes.spaceBtwItems / 2),
                                Container(
                                  height: 14,
                                  width: 60,
                                  color: Colors.grey[300],
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: TSizes.spaceBtwItems + 4),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                height: 40,
                                color: Colors.grey[300],
                              ),
                            ),
                            const SizedBox(width: TSizes.spaceBtwItems),
                            Expanded(
                              child: Container(
                                height: 40,
                                color: Colors.grey[300],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
