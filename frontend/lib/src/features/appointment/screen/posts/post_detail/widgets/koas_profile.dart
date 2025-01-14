import 'package:denta_koas/src/commons/widgets/text/title_with_verified.dart';
import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class KoasProfileCard extends StatelessWidget {
  const KoasProfileCard({
    super.key,
    required this.name,
    required this.university,
    required this.koasNumber,
    this.isNetworkImage = false,
    required this.image,
  });

  final String name;
  final String university;
  final String koasNumber;
  final String image;
  final bool isNetworkImage;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Image Profile
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            width: 100,
            height: 100,
            color: Colors.grey[200], // Placeholder color for missing image
            child: Image(
              image: isNetworkImage ? NetworkImage(image) : AssetImage(image),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: TSizes.spaceBtwItems),

        // Doctor Details
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Doctor Name
              Text(
                name,
                style: Theme.of(context).textTheme.titleMedium!.apply(
                      color: TColors.textPrimary,
                    ),
              ),
              const SizedBox(height: 4),

              // university and Distance
              Row(
                children: [
                  Expanded(
                    child: TitleWithVerified(
                      title: university,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              // Rating
              Row(
                children: [
                  const SizedBox(width: 4),
                  Text(
                    koasNumber,
                    style: Theme.of(context).textTheme.labelMedium!.apply(
                          color: TColors.textSecondary,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
            ],
          ),
        ),
      ],
    );
  }
}
