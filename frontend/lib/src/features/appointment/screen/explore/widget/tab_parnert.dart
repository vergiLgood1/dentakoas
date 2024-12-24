import 'package:denta_koas/src/commons/widgets/cards/partner_card.dart';
import 'package:denta_koas/src/commons/widgets/layouts/grid_layout.dart';
import 'package:denta_koas/src/commons/widgets/partnert/partner_showcase.dart';
import 'package:denta_koas/src/commons/widgets/text/section_heading.dart';
import 'package:denta_koas/src/features/appointment/screen/partners/all_partners.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabParnert extends StatelessWidget {
  const TabParnert({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              // Partners showcase
              const CardShowcase(
                title: 'Our top partners',
                subtitle: 'Find the best partners in your area',
                images: [
                  TImages.userProfileImage4,
                  TImages.userProfileImage4,
                  TImages.userProfileImage4,
                ],
              ),
              const CardShowcase(
                title: 'Newest partners',
                subtitle: 'Find the newest partners in your area',
                images: [
                  TImages.userProfileImage4,
                  TImages.userProfileImage4,
                  TImages.userProfileImage4,
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwItems),

              // Posts
              SectionHeading(
                  title: 'You might interest',
                  onPressed: () => Get.to(() => const AllParnertScreen())),
              const SizedBox(height: TSizes.spaceBtwItems),

              DGridLayout(
                itemCount: 2,
                crossAxisCount: 1,
                mainAxisExtent: 80,
                itemBuilder: (_, index) => const CategoryCard(
                  title: 'Politeknik Negeri Jember',
                  subtitle: '200+ Availabel Koas',
                  image: TImages.appleLogo,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
