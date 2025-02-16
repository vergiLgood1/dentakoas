import 'package:denta_koas/src/commons/widgets/appbar/appbar.dart';
import 'package:denta_koas/src/commons/widgets/shimmer/card_reviews.dart';
import 'package:denta_koas/src/commons/widgets/text/section_heading.dart';
import 'package:denta_koas/src/features/appointment/controller/post.controller/post_detail_controller.dart';
import 'package:denta_koas/src/features/appointment/controller/post.controller/posts_controller.dart';
import 'package:denta_koas/src/features/appointment/data/model/tes.dart';
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
  const PostDetailScreen({super.key, this.postId, this.scheduleId});

  final String? postId;
  final String? scheduleId;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PostDetailController());

    final Post post = Get.arguments;
    
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
      bottomNavigationBar: BottomBookAppointment(
        name: post.user.fullName,
        koasId: post.user.koasProfile!.id!,
        scheduleId: post.schedule[0].id,
        timeslotId: post.schedule[0].timeslot[0].id,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  // Doctor Profile
                  KoasProfileCard(
                    name: post.user.fullName,
                    university:
                        post.user.koasProfile!.university!,
                    koasNumber:
                        post.user.koasProfile!.koasNumber!,
                    image: post.user.image ?? TImages.userProfileImage2,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  // Post Title
                  TitlePost(
                    title: post.title,
                    content:
                        post.desc,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  // Post Badges
                  PostBadges(
                    category: post.treatment.alias,
                    requiredParticipants:
                        post.requiredParticipant,
                    currentParticipants: post.totalCurrentParticipants,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  // Patient Requirements
                  PatientRequirments(
                      patientRequirements:
                          post.patientRequirement),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  // Calendar Horizontal
                  CalendarHorizontal(
                    startDate: post.schedule[0].dateStart,
                    endDate: post.schedule[0].dateEnd,
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  // Available time
                  TimeStamp(
                    timeslots: post.schedule
                        .expand((schedule) => schedule.timeslot)
                        .map((timeslot) => {
                              'id': timeslot.id,
                              'startTime': timeslot.startTime,
                              'endTime': timeslot.endTime,
                              'maxParticipants': timeslot.maxParticipants,
                              'currentParticipants':
                                  timeslot.currentParticipants,
                              'isAvailable': timeslot.isAvailable,
                            })
                        .toList(),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  // Reviews and Ratings
                  SectionHeading(
                    title: 'Reviews & Ratings',
                    isSuffixIcon: true,
                    suffixIcon: CupertinoIcons.chevron_right,
                    onPressed: () => Get.to(() => const KoasReviewsScreen(
                     
                    )),
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Obx(
                    () {
                      if (controller.isLoading.value) {
                        return ShimmerUserReviewsCard(
                          itemCount: post.reviews!.length,
                        );
                      }
                      if (post.reviews!.isEmpty) {
                        return const Center(
                          child:
                              Text('Unfortunately, there are no reviews yet'),
                        );
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: post.reviews!.length,
                        itemBuilder: (context, index) {
                          final review = post.reviews?[index];
                          return const UserReviewsCard(
                            image: TImages.userProfileImage4,
                            name: 'Anri',
                            rating: 4.5,
                            date: '12 Jan 2021',
                            comment:
                                'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                          );
                        },
                      );
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

// class ReviewSummaryScreen extends StatelessWidget {
//   const ReviewSummaryScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(PostDetailController());
    
//     return Scaffold(
//       appBar: const DAppBar(
//         title: Text(
//           'Review Summary',
//           textAlign: TextAlign.center,
//         ),
//         centerTitle: true,
//         showBackArrow: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Profile Section
//             Row(
//               children: [
//                 const CircleAvatar(
//                   radius: 40,
//                   backgroundImage: AssetImage(TImages.userProfileImage3),
//                 ),
//                 const SizedBox(width: 16),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       controller.postDetail.value.user!.fullName,
//                       style: const TextStyle(
//                         fontSize: 18,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                     Text(
//                       controller.postDetail.value.koasProfile!.koasNumber!,
//                       style: const TextStyle(fontSize: 16, color: Colors.grey),
//                     ),
//                     Row(
//                       children: [
//                         const Icon(Icons.location_pin,
//                             size: 16, color: Colors.blue),
//                         const SizedBox(width: 4),
//                         Text(
//                           controller.postDetail.value.koasProfile!.university!,
//                           style:
//                               const TextStyle(fontSize: 14, color: Colors.grey),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//             const Divider(height: 32, thickness: 1),

//             const SizedBox(height: TSizes.spaceBtwItems),

//             // Date & Hour Section
//             const SectionHeading(
//               title: "Appointment Information",
//               showActionButton: false,
//             ),
//             const SizedBox(height: TSizes.spaceBtwItems),
//             // buildInfoRow("Date",
//             //     "${controller.postDetail.value.schedule!.dateStart} | ${controller.postDetail.value.schedule!.dateEnd}"),
//             buildInfoRow("Category", "Perawatan gigi"),
//             buildInfoRow("Duration", "1 hours"),

//             const Divider(height: 32, thickness: 1),
//             const SectionHeading(
//               title: "Patient Information",
//               showActionButton: false,
//             ),
//             const SizedBox(height: TSizes.spaceBtwItems),
//             // Pasien Section
//             buildInfoRow('name', 'Anri'),
//             buildInfoRow('Phone', '08123456789'),
//             buildInfoRow('Email', 'example@email.com'),
//             buildInfoRow('Address', 'Jl. Jendral Sudirman No. 1'),

//             // const Divider(height: 32, thickness: 1),
//             // Payment Method Section

//             const Spacer(),
//             // Pay Now Button
//             Center(
//               child: SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: () => Get.to(() => const BookingSuccessScreen()),
//                   style: ElevatedButton.styleFrom(
//                     padding: const EdgeInsets.symmetric(vertical: 16),
//                     backgroundColor: Colors.blue,
//                   ),
//                   child: const Text(
//                     "Booking now",
//                     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget buildInfoRow(String title, String value, {bool isBold = false}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(fontSize: 16, color: Colors.grey),
//           ),
//           Text(
//             value,
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
