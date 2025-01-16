import 'package:denta_koas/src/commons/widgets/shimmer/banner_promotion_shimmer.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class HomeBannerSection extends StatelessWidget {
  const HomeBannerSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
      child: Column(
        children: [
          BannerPromotionShimmer(),
          // BannerSlider(
          //   banners: [
          //     TImages.banner1,
          //     TImages.banner2,
          //     TImages.banner3,
          //   ],
          // ),
        ],
      ),
    );
  }
}
