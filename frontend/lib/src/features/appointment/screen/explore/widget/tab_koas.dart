import 'package:denta_koas/src/commons/widgets/layouts/grid_layout.dart';
import 'package:denta_koas/src/commons/widgets/partnert/partner_showcase.dart';
import 'package:denta_koas/src/commons/widgets/text/section_heading.dart';
import 'package:denta_koas/src/features/appointment/screen/dentist/all_koas.dart';
import 'package:denta_koas/src/features/appointment/screen/home/widgets/cards/doctor_card.dart';
import 'package:denta_koas/src/features/personalization/controller/koas_controller.dart';
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
    final controller = Get.put(KoasController());
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

              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.koas.isEmpty) {
                  return const Center(child: Text('No data'));
                }
                return DGridLayout(
                  itemCount: 2,
                  mainAxisExtent: 205,
                  crossAxisCount: 1,
                  itemBuilder: (_, index) {
                    final koas = controller.koas[index];
                    return KoasCard(
                      name: koas.fullName,
                      university: koas.koasProfile!.university!,
                      distance: '1.2 km',
                      rating: koas.koasProfile!.averageRating!,
                      totalReviews: koas.koasProfile!.totalReviews!,
                      image: TImages.userProfileImage4,
                    );
                  },
                );
              }),
              // const SizedBox(height: TSizes.spaceBtwItems / 2),
            ],
          ),
        ),
      ],
    );
  }
}
