import 'package:denta_koas/src/commons/widgets/cards/post_card.dart';
import 'package:denta_koas/src/commons/widgets/layouts/grid_layout.dart';
import 'package:denta_koas/src/commons/widgets/partnert/partner_showcase.dart';
import 'package:denta_koas/src/commons/widgets/text/section_heading.dart';
import 'package:denta_koas/src/features/appointment/screen/posts/post_detail/post_detail.dart';
import 'package:denta_koas/src/features/appointment/screen/posts/posts.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
                itemBuilder: (_, index) => PostCard(
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
                  onTap: () => Get.to(() => const PostDetailScreen()),
                  onPressed: () => Get.to(() => const PostDetailScreen()),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
