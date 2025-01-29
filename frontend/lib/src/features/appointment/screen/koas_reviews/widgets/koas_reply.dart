import 'package:denta_koas/src/commons/widgets/containers/rounded_container.dart';
import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:denta_koas/src/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class KoasReplyCard extends StatelessWidget {
  const KoasReplyCard({
    super.key,
    required this.image,
    required this.name,
    required this.comment,
    required this.date,
  });

  final String image;
  final String name;
  final String comment;
  final String date;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        // Koas Reply
        RoundedContainer(
          backgroundColor: dark ? TColors.darkerGrey : TColors.grey,
          child: Padding(
            padding: const EdgeInsets.all(TSizes.md),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          backgroundImage:
                              AssetImage(TImages.userProfileImage4),
                        ),
                        const SizedBox(width: TSizes.spaceBtwItems),
                        Text(
                          name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    Text(
                      date,
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                ReadMoreText(
                  comment,
                  trimLines: 2,
                  trimMode: TrimMode.Line,
                  trimExpandedText: ' Show less ',
                  trimCollapsedText: ' Show more ',
                  moreStyle: const TextStyle(
                    fontSize: TSizes.fontSizeSm,
                    color: TColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                  lessStyle: const TextStyle(
                    fontSize: TSizes.fontSizeSm,
                    color: TColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: TSizes.spaceBtwSections),
      ],
    );
  }
}
