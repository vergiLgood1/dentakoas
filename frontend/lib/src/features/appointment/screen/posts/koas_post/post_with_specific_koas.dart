import 'package:denta_koas/src/commons/widgets/appbar/appbar.dart';
import 'package:denta_koas/src/commons/widgets/cards/post_card.dart';
import 'package:denta_koas/src/commons/widgets/koas/sortable/sortable_koas.dart';
import 'package:denta_koas/src/features/appointment/screen/home/widgets/cards/doctor_card.dart';
import 'package:denta_koas/src/features/appointment/screen/posts/post_detail/post_detail.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostWithSpecificKoas extends StatelessWidget {
  const PostWithSpecificKoas({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const DAppBar(
        title: Text('Koas Post'),
        showBackArrow: true,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(
            TSizes.defaultSpace,
          ),
          child: Column(
            children: [
              const KoasCard(
                doctorName: 'Dr. John Doe',
                specialty: 'Dentist',
                distance: '2 km',
                rating: 4.5,
                reviewsCount: 120,
                openTime: '9:00 AM - 5:00 PM',
                doctorImageUrl: TImages.userProfileImage4,
                hideButton: true,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              SortableField(
                itemCount: 10,
                crossAxisCount: 1,
                mainAxisExtent: 330,
                itemBuilder: (_, index) => PostCard(
                  postId: '1',
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
