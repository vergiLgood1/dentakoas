import 'package:denta_koas/src/commons/widgets/appbar/appbar.dart';
import 'package:denta_koas/src/commons/widgets/appbar/tabbar.dart';
import 'package:denta_koas/src/commons/widgets/cards/treatment_card.dart';
import 'package:denta_koas/src/commons/widgets/containers/search_container.dart';
import 'package:denta_koas/src/commons/widgets/layouts/grid_layout.dart';
import 'package:denta_koas/src/commons/widgets/notifications/notification_menu.dart';
import 'package:denta_koas/src/commons/widgets/text/section_heading.dart';
import 'package:denta_koas/src/features/appointment/controller/treatment_controller.dart';
import 'package:denta_koas/src/features/appointment/screen/categories/all_category.dart';
import 'package:denta_koas/src/features/appointment/screen/explore/widget/tab_koas.dart';
import 'package:denta_koas/src/features/appointment/screen/explore/widget/tab_parnert.dart';
import 'package:denta_koas/src/features/appointment/screen/explore/widget/tab_post.dart';
import 'package:denta_koas/src/features/appointment/screen/posts/category_post/post_with_specific_category.dart';
import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:denta_koas/src/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TreatmentController());
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

                      // Featured tratments
                      SectionHeading(
                        title: 'Treatments',
                        onPressed: () =>
                            Get.to(() => const AllCategoryScreen()),
                      ),
                      const SizedBox(height: TSizes.spaceBtwItems / 1.5),

                      Obx(
                        () {
                          if (controller.isLoading.value) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (controller.featuredTreatments.isEmpty) {
                            return const Center(child: Text('No data'));
                          }
                          return DGridLayout(
                            itemCount: 4,
                            mainAxisExtent: 80,
                            itemBuilder: (_, index) {
                              final treatment =
                                  controller.featuredTreatments[index];
                              return TreatmentCard(
                                title: treatment.alias!,
                                subtitle: treatment.description,
                                showVerifiyIcon: false,
                                maxLines: 1,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                onTap: () => Get.to(
                                  () => const PostWithSpecificCategory(),
                                  arguments: treatment,
                                ),
                              );
                            },
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


