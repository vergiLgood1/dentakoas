import 'package:denta_koas/src/commons/widgets/appbar/appbar.dart';
import 'package:denta_koas/src/commons/widgets/koas/rating/rating_bar_indicator.dart';
import 'package:denta_koas/src/features/appointment/screen/koas_reviews/widgets/koas_reply.dart';
import 'package:denta_koas/src/features/appointment/screen/koas_reviews/widgets/overal_koas_rating.dart';
import 'package:denta_koas/src/features/appointment/screen/koas_reviews/widgets/user_reviews_card.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class KoasReviewsScreen extends StatelessWidget {
  const KoasReviewsScreen(
      {super.key,
      required this.image,
      required this.name,
      required this.rating,
      required this.comment,
      required this.date});

  final String image;
  final String name;
  final double rating;
  final String comment;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DAppBar(
        title: Text(
          'Reviews & Ratings',
        ),
        showBackArrow: true,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Rating and comments are verifed and are based on the feedback of the patients who visited the clinic.',
              ),
              const SizedBox(height: TSizes.spaceBtwItems),
              // Overall Rating
              const OverallKoasRating(),
              const DRatingBarIndicator(
                rating: 4.8,
              ),
              Text(
                '143',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: TSizes.spaceBtwSections),

              // User Reviews
              // const UserReviewsCard(),
              // const KoasReplyCard(),
              // const UserReviewsCard(),
              // const UserReviewsCard(),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      UserReviewsCard(
                        image: image,
                        name: name,
                        rating: rating,
                        date: date,
                        comment: comment,
                      ),
                      KoasReplyCard(
                        image: image,
                        name: name,
                        date: date,
                        comment: comment,
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

