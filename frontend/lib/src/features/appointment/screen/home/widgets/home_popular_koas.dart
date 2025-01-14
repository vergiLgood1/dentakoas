import 'package:denta_koas/src/commons/widgets/layouts/grid_layout.dart';
import 'package:denta_koas/src/commons/widgets/text/section_heading.dart';
import 'package:denta_koas/src/features/appointment/screen/dentist/all_koas.dart';
import 'package:denta_koas/src/features/appointment/screen/home/widgets/cards/doctor_card.dart';
import 'package:denta_koas/src/features/appointment/screen/koas/koas_details/koas_detail.dart';
import 'package:denta_koas/src/features/personalization/controller/koas_controller.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePopularKoasSection extends StatelessWidget {
  const HomePopularKoasSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(KoasController());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Heading
          SectionHeading(
            title: 'Popular Koas',
            showActionButton: true,
            onPressed: () => Get.to(() => const AllKoasScreen()),
          ),

          // Popular Koas
          Obx(
            () {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.topKoas.isEmpty) {
                return const Center(child: Text('No data'));
              }
              return DGridLayout(
                itemCount: 2,
                crossAxisCount: 1,
                itemBuilder: (_, index) {
                  final topKoas = controller.topKoas[index];
                  return KoasCard(
                    name: topKoas.fullName,
                    university: topKoas.koasProfile!.university!,
                    distance: '1 KM',
                    rating: topKoas.koasProfile!.averageRating!,
                    totalReviews: topKoas.koasProfile!.totalReviews!,
                    image: TImages.userProfileImage3,
                    onTap: () => Get.to(() => const KoasDetailScreen()),
                  );
                },
              );
            }, 
          ),
        ],
      ),
    );
  }
}
