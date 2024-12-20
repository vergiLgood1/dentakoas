import 'package:denta_koas/src/commons/widgets/containers/search_container.dart';
import 'package:denta_koas/src/features/appointment/screen/home/widgets/header/home_appbar.dart';
import 'package:denta_koas/src/features/appointment/screen/home/widgets/home_banner_section.dart';
import 'package:denta_koas/src/features/appointment/screen/home/widgets/home_popular_koas.dart';
import 'package:denta_koas/src/features/appointment/screen/home/widgets/home_popular_section.dart';
import 'package:denta_koas/src/features/appointment/screen/home/widgets/home_upcoming_schedule_section.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                // Appbar
                HomeAppBar(),
                SizedBox(height: TSizes.spaceBtwSections),

                // Search Bar
                SearchContainer(
                  text: 'Search something...',
                  showBackground: false,
                ),
                SizedBox(height: TSizes.spaceBtwSections),

                HomeBannerSection(),
                SizedBox(height: TSizes.spaceBtwSections),

                // Upcoming Schedule
                HomeUpcomingScheduleSection(),
                SizedBox(height: TSizes.spaceBtwSections),

                // Categories
                HomePopularCategoriesSection(),
                SizedBox(height: TSizes.spaceBtwSections),

                // Find Popular Koas
                HomePopularKoasSection(),
              ],
            )
          ],
        ),
      ),
    );
  }
}
