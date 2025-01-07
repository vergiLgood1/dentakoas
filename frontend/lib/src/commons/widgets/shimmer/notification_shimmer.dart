import 'package:denta_koas/src/utils/loaders/shimmer.dart';
import 'package:flutter/material.dart';

class NotificationShimmer extends StatelessWidget {
  const NotificationShimmer({super.key, required this.itemCount});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: itemCount,
      separatorBuilder: (_, __) => const SizedBox(
        height: 16.0,
      ),
      itemBuilder: (_, __) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TShimmerEffect(
              widht: 100,
              height: 20,
              radius: 5,
            ),
            const SizedBox(height: 16.0),
            Row(
              children: [
                const TShimmerEffect(
                  widht: 40,
                  height: 40,
                  radius: 20,
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TShimmerEffect(
                        widht: MediaQuery.of(context).size.width * 0.6,
                        height: 10,
                        radius: 5,
                      ),
                      const SizedBox(height: 8.0),
                      const TShimmerEffect(
                        widht: 150,
                        height: 10,
                        radius: 5,
                      ),
                    ],
                  ),
                ),
                const TShimmerEffect(
                  widht: 20,
                  height: 10,
                  radius: 5,
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
