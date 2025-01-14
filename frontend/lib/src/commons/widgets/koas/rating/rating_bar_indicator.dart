import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:iconsax/iconsax.dart';

class DRatingBarIndicator extends StatelessWidget {
  const DRatingBarIndicator({
    super.key,
    required this.rating,
    this.size = 20,
  });

  final double rating;
  final double size;

  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      rating: rating,
      itemSize: size,
      unratedColor: TColors.grey,
      itemBuilder: (_, __) => const Icon(
        Iconsax.star1,
        color: TColors.primary,
      ),
    );
  }
}
