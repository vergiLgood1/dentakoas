import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

class TitlePost extends StatelessWidget {
  const TitlePost({
    super.key,
    required this.title,
    required this.content,
  });

  final String title, content;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall!.apply(
                  color: TColors.textPrimary,
                ),
          ),
          const SizedBox(height: 8),
          ReadMoreText(
            content,
            style: const TextStyle(
              fontSize: 14,
              color: TColors.textPrimary,
            ),
            textAlign: TextAlign.justify,
            trimLines: 5,
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
    );
  }
}
