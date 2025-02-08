import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class RatingBarShimmer extends StatelessWidget {
  const RatingBarShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(5, (index) {
          return const Icon(
            Icons.star,
            color: Colors.grey,
            size: 42.0,
          );
        }),
      ),
    );
  }
}

class CommentFieldShimmer extends StatelessWidget {
  const CommentFieldShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        height: 150.0,
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
