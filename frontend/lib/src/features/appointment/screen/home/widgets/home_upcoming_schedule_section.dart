import 'package:denta_koas/src/commons/widgets/text/section_heading.dart';
import 'package:denta_koas/src/features/appointment/screen/home/widgets/cards/appointment_card.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class HomeUpcomingScheduleSection extends StatelessWidget {
  const HomeUpcomingScheduleSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
      child: Column(
        // Heading
        children: [
          SectionHeading(
            title: 'Upcoming Schedule',
            showActionButton: true,
            onPressed: () {},
          ),

          // Popular Appointments
          const AppointmentCards(
            imgUrl: TImages.user,
            name: 'Dr. John Doe',
            category: 'Scaling',
            date: 'Sunday, 12 June',
            timestamp: '10:00 - 11:00 AM',
          )
          
          // const UpcomingScheduleShimmer(),
        ],
      ),
    );
  }
}
