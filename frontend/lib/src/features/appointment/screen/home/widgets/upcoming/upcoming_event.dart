import 'package:denta_koas/src/features/appointment/screen/home/widgets/cards/doctor_card.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class FindUpcomingKoas extends StatelessWidget {
  const FindUpcomingKoas({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: TSizes.spaceBtwItems),
          DoctorCard(
            doctorName: 'Dr. Joseph Brostito',
            specialty: 'Dental Specialist',
            distance: '1 KM',
            rating: 4.8,
            reviewsCount: 120,
            openTime: '17.00',
            doctorImageUrl:
                TImages.userProfileImage1, // Pastikan asset ada di folder
          ),
        ],
      ),
    );
  }
}
