import 'package:denta_koas/src/commons/widgets/layouts/grid_layout.dart';
import 'package:denta_koas/src/commons/widgets/text/section_heading.dart';
import 'package:denta_koas/src/features/appointment/screen/dentist/all_koas.dart';
import 'package:denta_koas/src/features/appointment/screen/home/widgets/cards/doctor_card.dart';
import 'package:denta_koas/src/features/appointment/screen/koas/koas_details/koas_detail.dart';
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
          DGridLayout(
            itemCount: 2,
            crossAxisCount: 1,
            itemBuilder: (_, index) => DoctorCard(
                onTap: () => Get.to(() => const KoasDetailScreen()),
                doctorName: 'Dr. Joseph Brostito',
                specialty: 'Dental Specialist',
                distance: '1 KM',
                rating: 4.8,
                reviewsCount: 120,
                openTime: '17.00',
                doctorImageUrl: TImages.userProfileImage3),
          ),
        ],
      ),
    );
  }
}
