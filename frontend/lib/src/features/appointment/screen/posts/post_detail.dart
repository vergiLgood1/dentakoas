import 'package:denta_koas/src/commons/widgets/appbar/appbar.dart';
import 'package:denta_koas/src/commons/widgets/text/title_with_verified.dart';
import 'package:denta_koas/src/features/appointment/screen/posts/widgets/calendar_horizontal.dart';
import 'package:denta_koas/src/features/appointment/screen/posts/widgets/timestamp.dart';
import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class PostDetailScreen extends StatelessWidget {
  static List<Map<String, dynamic>> schedule = [
    {
      "id": "cm401n1xj0002cn6acp61qbpz",
      "startTime": "09:00",
      "endTime": "12:00",
      "maxParticipants": 3,
      "currentParticipants": 3,
      "isAvailable": false
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
      "isAvailable": false
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            DAppBar(
              title: const Text(
                'Post Detail',
                textAlign: TextAlign.center,
              ),
              showBackArrow: true,
              actions: [
                IconButton(
                  icon: const Icon(Icons.favorite_border),
                  onPressed: () {},
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Image Profile
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          width: 100,
                          height: 100,
                          color: Colors
                              .grey[200], // Placeholder color for missing image
                          child: Image.asset(
                            TImages.userProfileImage2,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: TSizes.spaceBtwItems),

                      // Doctor Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Doctor Name
                            Text(
                              'Dr. John Doe',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .apply(
                                    color: TColors.textPrimary,
                                  ),
                            ),
                            const SizedBox(height: 4),

                            // Specialty and Distance
                            const Row(
                              children: [
                                Expanded(
                                  child: TitleWithVerified(
                                    title: 'Politeknik Negeri Jember',
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: TSizes.spaceBtwItems),

                            // Rating
                            Row(
                              children: [
                                // const Icon(Icons.star,
                                //     size: TSizes.iconBase,
                                //     color: TColors.secondary),
                                const SizedBox(width: 4),
                                Text(
                                  'KID-0001',
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .apply(
                                        color: TColors.textSecondary,
                                      ),
                                ),
                              ],
                            ),
                            const SizedBox(height: TSizes.spaceBtwItems),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Post Title
                  const SizedBox(height: TSizes.spaceBtwItems),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Post Title',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .apply(
                                    color: TColors.textPrimary,
                                  ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'This is a detailed description of the post. It provides all the necessary information about the appointment, including the doctor\'s expertise, the required participants, and other relevant details. Make sure to read through the entire description to understand the post fully.',
                              style:
                                  Theme.of(context).textTheme.bodyMedium!.apply(
                                        color: TColors.textSecondary,
                                      ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  // Require participants, Category, and like count
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        const Icon(CupertinoIcons.person_2, color: Colors.grey),
                        const SizedBox(width: 8),
                        Text('3 / 5',
                            style: Theme.of(context).textTheme.bodyMedium),
                      ]),
                      Row(children: [
                        const Icon(Iconsax.category, color: Colors.grey),
                        const SizedBox(width: 8),
                        Text('Proximithi',
                            style: Theme.of(context).textTheme.bodyMedium),
                      ]),
                      Row(children: [
                        const Icon(Iconsax.like, color: Colors.grey),
                        const SizedBox(width: 8),
                        Text('20 likes',
                            style: Theme.of(context).textTheme.bodyMedium),
                      ]),
                    ],
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  // Calendar
                  CalendarHorizontal(
                    startDate: DateTime(2024, 12, 1),
                    endDate: DateTime(2024, 12, 10),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  // Available time
                  TimeStamp(timeslots: schedule),

                  // Button
                  const SizedBox(height: TSizes.spaceBtwSections),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // Add your onPressed code here!
                      },
                      child: const Text('Book Appointment'),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
