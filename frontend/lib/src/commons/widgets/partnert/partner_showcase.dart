import 'package:denta_koas/src/commons/widgets/cards/partner_card.dart';
import 'package:denta_koas/src/commons/widgets/containers/rounded_container.dart';
import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:denta_koas/src/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class PartnertShowcase extends StatelessWidget {
  const PartnertShowcase({
    super.key,
    required this.images,
  });

  final List<String> images;

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
          const PartnertCard(
            showBorder: false,
            title: 'Universitas Negeri Jember',
            subtitle: '200+ Available Koas',
            image: TImages.appleLogo,
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
