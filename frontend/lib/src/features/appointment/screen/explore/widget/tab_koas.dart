import 'package:denta_koas/src/commons/widgets/layouts/grid_layout.dart';
import 'package:denta_koas/src/commons/widgets/partnert/partner_showcase.dart';
import 'package:denta_koas/src/commons/widgets/text/section_heading.dart';
import 'package:denta_koas/src/features/appointment/screen/dentist/all_koas.dart';
import 'package:denta_koas/src/features/appointment/screen/home/widgets/cards/doctor_card.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabKoas extends StatelessWidget {
  const TabKoas({
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
                title: 'Top Koas',
                subtitle: 'Find the best koas in your area',
                images: [
                  TImages.userProfileImage4,
                  TImages.userProfileImage4,
                  TImages.userProfileImage4,
                ],
              ),
              const CardShowcase(
                title: 'Newest Koas',
                subtitle: 'Find the newest koas in your area',
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
                  onPressed: () => Get.to(() => const AllKoasScreen())),
              const SizedBox(height: TSizes.spaceBtwItems),

              DGridLayout(
                itemCount: 4,
                crossAxisCount: 1,
                itemBuilder: (_, index) => const KoasCard(
                  doctorName: 'Dr. John Doe',
                  specialty: 'Dentist',
                  distance: '2 km',
                  rating: 4.5,
                  reviewsCount: 120,
                  openTime: '9:00 AM - 5:00 PM',
                  doctorImageUrl: TImages.userProfileImage4,
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwSections),
            ],
          ),
        ),
      ],
    );
  }
}
