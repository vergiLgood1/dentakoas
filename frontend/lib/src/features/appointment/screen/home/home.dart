import 'package:denta_koas/src/commons/widgets/containers/search_container.dart';
import 'package:denta_koas/src/commons/widgets/text/section_heading.dart';
import 'package:denta_koas/src/features/appointment/screen/home/widgets/cards/appointment_card.dart';
import 'package:denta_koas/src/features/appointment/screen/home/widgets/header/home_appbar.dart';
import 'package:denta_koas/src/features/appointment/screen/home/widgets/home_categories.dart';
import 'package:denta_koas/src/features/appointment/screen/home/widgets/upcoming/upcoming_event.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // @override
  // Widget build(BuildContext context) {
  //   return const Scaffold(
  //     body: SingleChildScrollView(
  //       child: Padding(
  //         padding: DSpacingStyle.paddingWithAppBarHeight,
  //         child: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             // header
  //             WelcomeCard(),
  //             SizedBox(height: TSizes.spaceBtwSections),

  //             // Search Bar
  //             SearchBarApp(),
  //             SizedBox(height: TSizes.spaceBtwSections),

  //             AppointmentCards(
  //               imgUrl: TImages.user,
  //               name: 'Dr. John Doe',
  //               category: 'Dentist',
  //               date: 'Sunday, 12 June',
  //               timestamp: '10:00 - 11:00 AM',
  //             ),
  //             SizedBox(height: TSizes.spaceBtwSections),

  //             // Categories
  //             // CategorySection(),
  //             // SizedBox(height: TSizes.spaceBtwSections),

  //             // Find Upcoming Koas
  //             FindUpcomingKoas(),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              children: [
                // Appbar
                const HomeAppBar(),
                const SizedBox(height: TSizes.spaceBtwSections),

                // Search Bar
                const SearchContainer(
                  text: 'Search something...',
                  showBackground: false,
                ),
                const SizedBox(height: TSizes.spaceBtwSections),

                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: TSizes.defaultSpace),
                  child: Column(
                    // Heading
                    children: [
                      SectionHeading(
                        title: 'Upcoming Schedule',
                        showActionButton: true,
                        onPressed: () {},
                      ),
                      
                      // Upcoming Appointments
                      const AppointmentCards(
                        imgUrl: TImages.user,
                        name: 'Dr. John Doe',
                        category: 'Scaling',
                        date: 'Sunday, 12 June',
                        timestamp: '10:00 - 11:00 AM',
                      )
                    ],
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwSections),

                // Categories
                const Padding(
                  padding: EdgeInsets.only(left: TSizes.defaultSpace),
                  child: Column(
                    children: [
                      // Heading
                      SectionHeading(
                        title: 'Popular Categories',
                        showActionButton: false,
                      ),
                      SizedBox(height: TSizes.spaceBtwItems),

                      HomeCategories()
                    ],
                  ),
                ),
                const SizedBox(height: TSizes.spaceBtwSections),

                // Find Upcoming Koas
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: TSizes.defaultSpace),
                  child: Column(
                    children: [
                      // Heading
                      SectionHeading(
                        title: 'Find Upcoming Koas',
                        showActionButton: true,
                        onPressed: () {},
                      ),

                      // Upcoming Koas
                      const FindUpcomingKoas(),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

