import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Avatar extends StatelessWidget {
  final String imgUrl;
  final String name;
  final VoidCallback? onTap;

  const Avatar({
    super.key,
    required this.imgUrl,
    required this.name,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Stack(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage(imgUrl),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: TColors.primary,
                    border: Border.all(color: TColors.white, width: 2),
                  ),
                  child: GestureDetector(
                    onTap: () => Get.to(() => ()),
                    child:
                        const Icon(Icons.edit, color: TColors.white, size: 20),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),
        Text(
          name,
          style: const TextStyle(
            fontSize: TSizes.fontSizeLg,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
