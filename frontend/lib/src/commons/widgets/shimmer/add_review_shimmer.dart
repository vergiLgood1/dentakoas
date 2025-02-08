import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AddReviewShimmer extends StatelessWidget {
  const AddReviewShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Add Review'),
        centerTitle: true,
      ),
      body: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Column(
          children: [
            const SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[300],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: 100,
                    height: 20,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 5),
                  Container(
                    width: 150,
                    height: 20,
                    color: Colors.grey[300],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                width: double.infinity,
                height: 20,
                color: Colors.grey[300],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return Icon(
                  Icons.star,
                  color: Colors.grey[300],
                  size: 30,
                );
              }),
            ),
            const SizedBox(height: 20),
            Container(
              width: 100,
              height: 20,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 150,
                    height: 20,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    height: 100,
                    color: Colors.grey[300],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Container(
                width: double.infinity,
                height: 50,
                color: Colors.grey[300],
              ),
            ),
          ],
        ),
      ),
    );
  }
}