import 'package:denta_koas/src/commons/widgets/cards/partner_card.dart';
import 'package:denta_koas/src/commons/widgets/containers/rounded_container.dart';
import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/enums.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:denta_koas/src/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class CardShowcase extends StatelessWidget {
  const CardShowcase({
    super.key,
    required this.images,
    required this.title,
    required this.subtitle,
    this.prefixImage,
  });

  final List<String> images;
  final String title, subtitle;
  final String? prefixImage;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
      showBorder: true,
      borderColor: TColors.darkGrey,
      backgroundColor: TColors.transparent,
      padding: const EdgeInsets.all(TSizes.md),
      margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
      child: Column(
        children: [
          // Partners with koas count
          CategoryCard(
            showBorder: false,
            showVerifiyIcon: false,
            title: title,
            subtitle: subtitle,
            image: prefixImage,
            doctorTextSize: TextSizes.large,
          ),

          Row(
            children: [
              ...images.map((image) => partnertTopKoasWidget(image, context))
            ],
          ),
        ],
      ),
    );
  }
}

Widget partnertTopKoasWidget(String image, context) {
  return Expanded(
    child: RoundedContainer(
      height: 100,
      backgroundColor: THelperFunctions.isDarkMode(context)
          ? TColors.darkGrey
          : TColors.light,
      margin: const EdgeInsets.only(right: TSizes.sm),
      child: Image(
        image: AssetImage(image),
        fit: BoxFit.cover,
      ),
    ),
  );
}
