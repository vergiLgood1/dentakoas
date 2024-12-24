import 'package:denta_koas/src/commons/widgets/appbar/appbar.dart';
import 'package:denta_koas/src/commons/widgets/appbar/tabbar.dart';
import 'package:denta_koas/src/commons/widgets/cards/partner_card.dart';
import 'package:denta_koas/src/commons/widgets/cards/post_card.dart';
import 'package:denta_koas/src/commons/widgets/containers/search_container.dart';
import 'package:denta_koas/src/commons/widgets/layouts/grid_layout.dart';
import 'package:denta_koas/src/commons/widgets/notifications/notification_menu.dart';
import 'package:denta_koas/src/commons/widgets/partnert/partner_showcase.dart';
import 'package:denta_koas/src/commons/widgets/text/section_heading.dart';
import 'package:denta_koas/src/features/appointment/screen/categories/all_category.dart';
import 'package:denta_koas/src/features/appointment/screen/dentist/all_koas.dart';
import 'package:denta_koas/src/features/appointment/screen/home/widgets/cards/doctor_card.dart';
import 'package:denta_koas/src/features/appointment/screen/partners/all_partners.dart';
import 'package:denta_koas/src/features/appointment/screen/posts/posts.dart';
import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:denta_koas/src/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: DAppBar(
          title: Text('Explore',
              style: Theme.of(context).textTheme.headlineMedium),
          actions: [
            NotificationCounterIcon(onPressed: () {}),
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                automaticallyImplyLeading: false,
                pinned: true,
                floating: true,
                backgroundColor: dark ? TColors.black : TColors.white,
                expandedHeight: 440,
                flexibleSpace: Padding(
                  padding: const EdgeInsets.all(TSizes.defaultSpace),
                  child: ListView(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      // Search bar
                      const SizedBox(height: TSizes.spaceBtwItems),
                      const SearchContainer(
                        text: 'Search something...',
                        showBackground: false,
                        padding: EdgeInsets.zero,
                      ),
                      const SizedBox(height: TSizes.spaceBtwSections),

                      // Featured koas
                      SectionHeading(
                        title: 'Categories',
                        onPressed: () =>
                            Get.to(() => const AllCategoryScreen()),
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems / 1.5),

                      DGridLayout(
                        itemCount: 4,
                        mainAxisExtent: 80,
                        itemBuilder: (_, index) {
                          return const CategoryCard(
                            title: 'Category 1',
                            subtitle: 'Category 1 subtitle',
                            showVerifiyIcon: false,
                            maxLines: 2,
                            crossAxisAlignment: CrossAxisAlignment.start,
                          );
                        },
                      )
                    ],
                  ),
                ),

                // Tabs
                bottom: const TabBarApp(tabs: [
                  Tab(text: 'Posts'),
                  Tab(text: 'Dentist'),
                  Tab(text: 'Partners'),
                ]),
              ),
            ];
          },
          body: const TabBarView(
            children: [
              TabPost(),
              TabKoas(),
              TabParnert(),
            ],
          ),
        ),
      ),
    );
  }
}

class TabPost extends StatelessWidget {
  const TabPost({
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
                title: 'Last Chance',
                subtitle: 'Find the best koas in your area',
                images: [
                  TImages.userProfileImage4,
                  TImages.userProfileImage4,
                  TImages.userProfileImage4,
                ],
              ),
              const CardShowcase(
                title: 'Newest Posts',
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
                  onPressed: () => Get.to(() => const AllPostScreen())),
              const SizedBox(height: TSizes.spaceBtwItems),

              DGridLayout(
                itemCount: 2,
                crossAxisCount: 1,
                mainAxisExtent: 330,
                itemBuilder: (_, index) => const PostCard(
                  name: 'Dr. John Doe',
                  university: 'Politeknik Negeri Jember',
                  image: TImages.userProfileImage4,
                  timePosted: '2 hours ago',
                  title: 'Open Relawan Pasien Koas',
                  description:
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                  category: 'Proxidithi',
                  participantCount: 2,
                  requiredParticipant: 5,
                  dateStart: '01 Jan',
                  dateEnd: '31 Jan 2024',
                  likesCount: 20,
                ),
              ),
              
            ],
          ),
        ),
      ],
    );
  }
}

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
                itemBuilder: (_, index) => const DoctorCard(
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

class TabParnert extends StatelessWidget {
  const TabParnert({
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
                title: 'Our top partners',
                subtitle: 'Find the best partners in your area',
                images: [
                  TImages.userProfileImage4,
                  TImages.userProfileImage4,
                  TImages.userProfileImage4,
                ],
              ),
              const CardShowcase(
                title: 'Newest partners',
                subtitle: 'Find the newest partners in your area',
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
                  onPressed: () => Get.to(() => const AllParnertScreen())),
              const SizedBox(height: TSizes.spaceBtwItems),

              DGridLayout(
                itemCount: 2,
                crossAxisCount: 1,
                mainAxisExtent: 80,
                itemBuilder: (_, index) => const CategoryCard(
                  title: 'Politeknik Negeri Jember',
                  subtitle: '200+ Availabel Koas',
                  image: TImages.appleLogo,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
