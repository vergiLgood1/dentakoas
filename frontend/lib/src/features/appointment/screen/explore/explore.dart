import 'package:denta_koas/src/commons/widgets/appbar/appbar.dart';
import 'package:denta_koas/src/commons/widgets/containers/rounded_container.dart';
import 'package:denta_koas/src/commons/widgets/containers/search_container.dart';
import 'package:denta_koas/src/commons/widgets/layouts/grid_layout.dart';
import 'package:denta_koas/src/commons/widgets/notifications/notification_menu.dart';
import 'package:denta_koas/src/commons/widgets/text/doctor_title_with_verified.dart';
import 'package:denta_koas/src/commons/widgets/text/section_heading.dart';
import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/enums.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:denta_koas/src/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: DAppBar(
        title:
            Text('Explore', style: Theme.of(context).textTheme.headlineMedium),
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
                    SectionHeading(title: 'Featured Partner', onPressed: () {}),
                    const SizedBox(height: TSizes.spaceBtwItems / 1.5),

                    DGridLayout(
                      itemCount: 4,
                      mainAxisExtent: 80,
                      itemBuilder: (_, index) {
                        return GestureDetector(
                          onTap: () {},
                          child: RoundedContainer(
                            padding: const EdgeInsets.all(TSizes.sm),
                            showBorder: true,
                            backgroundColor: TColors.transparent,
                            child: Row(
                              children: [
                                const Flexible(
                                  child: CircleAvatar(
                                    radius: 24,
                                    backgroundColor: TColors.transparent,
                                    backgroundImage:
                                        AssetImage(TImages.appleLogo),
                                  ),
                                ),
                                const SizedBox(width: TSizes.spaceBtwItems / 2),

                                // Text
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const DoctorTitleWithVerified(
                                        title: 'POLIJE',
                                        doctorTextSize: TextSizes.medium,
                                      ),
                                      Text(
                                        '200+ koas available',
                                        overflow: TextOverflow.ellipsis,
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium!,
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ];
        },
        body: Container(),
      ),
    );
  }
}
