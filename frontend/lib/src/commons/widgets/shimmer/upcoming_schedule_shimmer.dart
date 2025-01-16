import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class UpcomingScheduleShimmer extends StatelessWidget {
  const UpcomingScheduleShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: double.infinity,
              height: 20.0,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 16.0),
          Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              width: double.infinity,
              height: 100.0,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
