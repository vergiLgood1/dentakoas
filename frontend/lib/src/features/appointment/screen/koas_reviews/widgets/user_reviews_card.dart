import 'package:denta_koas/src/commons/widgets/koas/rating/rating_bar_indicator.dart';
import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class UserReviewsCard extends StatelessWidget {
  const UserReviewsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const CircleAvatar(
                  backgroundImage: AssetImage(TImages.userProfileImage3),
                ),
                const SizedBox(width: TSizes.spaceBtwItems),
                Text('John Doe',
                    style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
            const SizedBox(width: TSizes.spaceBtwItems),
            IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert))
          ],
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        // Review
        Row(
          children: [
            const DRatingBarIndicator(rating: 4),
            const SizedBox(width: TSizes.spaceBtwItems),
            Text(
              '01 Nov 2024',
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
        const SizedBox(height: TSizes.spaceBtwSections),
      ],
    );
  }
}
