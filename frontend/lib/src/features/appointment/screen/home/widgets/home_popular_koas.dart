import 'package:denta_koas/src/commons/widgets/layouts/grid_layout.dart';
import 'package:denta_koas/src/commons/widgets/text/section_heading.dart';
import 'package:denta_koas/src/features/appointment/screen/home/widgets/cards/doctor_card.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

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
            onPressed: () {},
          ),

          // Popular Koas
          DGridLayout(
            itemCount: 2,
            itemBuilder: (_, index) => const DoctorCard(
                doctorName: 'Dr. Joseph Brostito',
                specialty: 'Dental Specialist',
                distance: '1 KM',
                rating: 4.8,
                reviewsCount: 120,
                openTime: '17.00',
                doctorImageUrl: TImages.userProfileImage3),
            crossAxisCount: 1,
          ),
        ],
      ),
    );
  }
}
