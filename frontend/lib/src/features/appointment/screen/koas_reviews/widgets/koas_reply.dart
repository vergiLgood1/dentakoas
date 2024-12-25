import 'package:denta_koas/src/commons/widgets/containers/rounded_container.dart';
import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:denta_koas/src/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class KoasReplyCard extends StatelessWidget {
  const KoasReplyCard({super.key});

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
                          'Dr. John Doe',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                    Text(
                      '12 Nov 2024',
                      style: Theme.of(context).textTheme.bodyMedium,
                    )
                  ],
                ),
                const SizedBox(height: TSizes.spaceBtwItems),
                const ReadMoreText(
                  'The koas was very professional and attentive throughout the entire appointment. They took the time to explain each step of the procedure and made sure I was comfortable at all times. Their expertise and friendly demeanor made the experience much more pleasant. I would highly recommend them to anyone seeking dental care.',
                  trimLines: 2,
                  trimMode: TrimMode.Line,
                  trimExpandedText: ' Show less ',
                  trimCollapsedText: ' Show more ',
                  moreStyle: TextStyle(
                    fontSize: TSizes.fontSizeSm,
                    color: TColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                  lessStyle: TextStyle(
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
