import 'package:denta_koas/src/commons/styles/spacing_styles.dart';
import 'package:denta_koas/src/features/appointment/presentasion/widgets/cards/appointment_card.dart';
import 'package:denta_koas/src/features/appointment/presentasion/widgets/header/search_bar.dart';
import 'package:denta_koas/src/features/appointment/presentasion/widgets/header/topbar.dart';
import 'package:denta_koas/src/features/appointment/presentasion/widgets/upcoming/upcoming_event.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: DSpacingStyle.paddingWithAppBarHeight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // header
              WelcomeCard(),
              SizedBox(height: TSizes.spaceBtwSections),

              // Search Bar
              SearchBarApp(),
              SizedBox(height: TSizes.spaceBtwSections),

              AppointmentCards(
                imgUrl: TImages.user,
                name: 'Dr. John Doe',
                category: 'Dentist',
                date: 'Sunday, 12 June',
                timestamp: '10:00 - 11:00 AM',
              ),
              SizedBox(height: TSizes.spaceBtwSections),

              // Categories
              // CategorySection(),
              // SizedBox(height: TSizes.spaceBtwSections),

              // Find Upcoming Koas
              FindUpcomingKoas(),
            ],
          ),
        ),
      ),
    );
  }
}
