import 'package:denta_koas/src/commons/widgets/appbar/appbar.dart';
import 'package:denta_koas/src/commons/widgets/text/section_heading.dart';
import 'package:denta_koas/src/features/appointment/screen/koas_reviews/koas_reviews.dart';
import 'package:denta_koas/src/features/appointment/screen/koas_reviews/widgets/user_reviews_card.dart';
import 'package:denta_koas/src/features/appointment/screen/posts/post_detail/widgets/koas_profile.dart';
import 'package:denta_koas/src/features/appointment/screen/posts/post_detail/widgets/post_detail_badge.dart';
import 'package:denta_koas/src/features/appointment/screen/posts/post_detail/widgets/title_post_detail.dart';
import 'package:denta_koas/src/features/appointment/screen/posts/widgets/bottom_book_appointment.dart';
import 'package:denta_koas/src/features/appointment/screen/posts/widgets/calendar_horizontal.dart';
import 'package:denta_koas/src/features/appointment/screen/posts/widgets/patient_requirment.dart';
import 'package:denta_koas/src/features/appointment/screen/posts/widgets/timestamp.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PostDetailScreen extends StatelessWidget {
  static List<Map<String, dynamic>> schedule = [
    {
      "id": "cm401n1xj0002cn6acp61qbpz",
      "startTime": "09:00",
      "endTime": "12:00",
      "maxParticipants": 3,
      "currentParticipants": 3,
      "isAvailable": true
    },
    {
      "id": "cm401ne990003cn6ao29oocuw",
      "startTime": "13:00",
      "endTime": "14:00",
      "maxParticipants": 2,
      "currentParticipants": 1,
      "isAvailable": true
    },
    {
      "id": "cm401ne990003cn6ao29oocuw",
      "startTime": "19:00",
      "endTime": "20:00",
      "maxParticipants": 2,
      "currentParticipants": 1,
      "isAvailable": true
    },
    {
      "id": "cm401ne990003cn6ao29oocuw",
      "startTime": "21:00",
      "endTime": "22:00",
      "maxParticipants": 2,
      "currentParticipants": 1,
      "isAvailable": true
    },
    {
      "id": "cm401ne990003cn6ao29oocuw",
      "startTime": "23:00",
      "endTime": "00:00",
      "maxParticipants": 2,
      "currentParticipants": 1,
      "isAvailable": false
    }
  ];

  const PostDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DAppBar(
        title: const Text(
          'Post Detail',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        showBackArrow: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border),
            onPressed: () {},
          ),
        ],
      ),
      bottomNavigationBar: const BottomBookAppointment(
        name: 'Dr. John Doe',
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  // Doctor Profile
                  const KoasProfileCard(
                    name: 'Dr. John Doe',
                    university: 'University of Dental Sciences',
                    koasNumber: '123456',
                    image: TImages.userProfileImage3,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  // Post Title
                  const TitlePost(
                    title: 'Post Title',
                    content:
                        'The koas was very professional and attentive throughout the entire appointment. They took the time to explain each step of the procedure and made sure I was comfortable at all times. Their expertise and friendly demeanor made the experience much more pleasant. I would highly recommend them to anyone seeking dental care.',
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  // Post Badges
                  const PostBadges(
                    category: 'Dental Care',
                    requiredParticipants: 5,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  // Patient Requirements
                  const PatientRequirments(patientRequirements: [
                    'Hand sanitizer',
                    '12',
                    'Datang ke lokasi',
                    'Umur min 18 tahun',
                    'Membawa KTP',
                    'Membawa masker',
                  ]),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  // Calendar Horizontal
                  CalendarHorizontal(
                    startDate: DateTime(2024, 12, 1),
                    endDate: DateTime(2024, 12, 10),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  // Available time
                  TimeStamp(timeslots: schedule),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  // Reviews and Ratings
                  SectionHeading(
                    title: 'Reviews & Ratings',
                    isSuffixIcon: true,
                    suffixIcon: CupertinoIcons.chevron_right,
                    onPressed: () => Get.to(() => const KoasReviewsScreen()),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return const UserReviewsCard();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
