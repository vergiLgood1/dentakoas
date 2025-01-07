import 'package:denta_koas/navigation_menu.dart';
import 'package:denta_koas/src/commons/widgets/appbar/appbar.dart';
import 'package:denta_koas/src/commons/widgets/state_screeen/state_screen.dart';
import 'package:denta_koas/src/commons/widgets/text/section_heading.dart';
import 'package:denta_koas/src/features/appointment/screen/posts/create_post/widget/dropdown.dart';
import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PostPreviewScren extends StatelessWidget {
  final Map<String, dynamic> data = {
    "id": "cm401lfho0000cn6a9ckhlw7p",
    "userId": "cm401i1bm0000rs568ai5zbkf",
    "koasId": "cm401i1br0002rs566ive7e1e",
    "treatmentId": "cm3znjvlm0000dnorci7ush77",
    "title": "Ini adalah judul",
    "desc": "Ini adalah deskripsi",
    "patientRequirement": ["Ini adalah syarat nya", "ini adalah syarat nya"],
    "requiredParticipant": 5,
    "status": "Closed",
    "published": false,
    "createdAt": "2024-11-27T15:30:18.925Z",
    "updateAt": "2024-11-28T16:25:34.562Z",
    "Schedule": [
      {
        "id": "cm401mb2x0001cn6ad58efuax",
        "dateStart": "2024-12-27T00:00:00.000Z",
        "dateEnd": "2024-12-31T00:00:00.000Z",
        "timeslot": [
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
            "startTime": "19:00",
            "endTime": "21:00",
            "maxParticipants": 2,
            "currentParticipants": 2,
            "isAvailable": false
          }
        ]
      }
    ],
    "likes": 0
  };

  PostPreviewScren({super.key});

  @override
  Widget build(BuildContext context) {
    final title = data['title'];
    final desc = data['desc'];
    final patientRequirements = data['patientRequirement'] as List;
    final schedule = data['Schedule'] as List;

    return Scaffold(
      appBar: DAppBar(
        title: const Text('Post Preview'),
        onBack: () => Get.back(),
        showBackArrow: true,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // General Information

            const SectionHeading(
              title: 'General Information',
              showActionButton: false,
            ),
            const SizedBox(height: TSizes.spaceBtwSections),

            // Title
            TextFormField(
              initialValue: title,
              decoration: const InputDecoration(
                labelText: 'Title',
                prefixIcon: Icon(Icons.title),
              ),
              readOnly: true,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            // Description
            TextFormField(
              maxLines: 5,
              initialValue: desc,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                alignLabelWithHint: true,
                labelText: 'Description',
              ),
              readOnly: true,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            // Required Participant
            TextFormField(
              initialValue: data['requiredParticipant'].toString(),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.group),
                labelText: 'Required Participants',
              ),
              readOnly: true,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            // Category
            TextFormField(
              initialValue: data['treatmentId'],
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.category),
                labelText: 'Treatment Category',
              ),
              readOnly: true,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            const DDropdownMenu(
              prefixIcon: Icons.info,
              hintText: 'Select Status',
              selectedItem: 'Open',
              items: ['Open', 'Pending'],
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            // Schedule
            const SectionHeading(
              title: 'Schedule',
              showActionButton: false,
            ),
            const SizedBox(height: TSizes.spaceBtwItems),

            ...schedule.map((sched) {
              final dateStart = DateFormat('dd MMM yyyy')
                  .format(DateTime.parse(sched['dateStart']));
              final dateEnd = DateFormat('dd MMM yyyy')
                  .format(DateTime.parse(sched['dateEnd']));
              final timeslots = sched['timeslot'] as List;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    initialValue: '$dateStart - $dateEnd',
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.calendar_today),
                      labelText: 'Date Range',
                    ),
                    readOnly: true,
                  ),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  // Time Slots

                  ...['Morning', 'Afternoon', 'Evening'].map((period) {
                    timeslotFilter(slot) {
                      final startTime =
                          DateFormat('HH:mm').parse(slot['startTime']);
                      if (period == 'Morning') {
                        return startTime
                            .isBefore(DateFormat('HH:mm').parse('12:00'));
                      } else if (period == 'Afternoon') {
                        return startTime
                                .isAfter(DateFormat('HH:mm').parse('12:00')) &&
                            startTime
                                .isBefore(DateFormat('HH:mm').parse('18:00'));
                      } else {
                        return startTime
                            .isAfter(DateFormat('HH:mm').parse('18:00'));
                      }
                    }

                    final filteredSlots =
                        timeslots.where(timeslotFilter).toList();
                    if (filteredSlots.isEmpty) return const SizedBox.shrink();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SectionHeading(title: period, showActionButton: false),
                        const SizedBox(height: TSizes.spaceBtwItems),
                        ...filteredSlots.map((slot) {
                          return Container(
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.only(
                                bottom: TSizes.spaceBtwItems / 2),
                            decoration: BoxDecoration(
                              color: TColors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: TColors.grey),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${slot['startTime']} - ${slot['endTime']}',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                                Text(
                                  'Max: ${slot['maxParticipants']}',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                ),
                              ],
                            ),
                          );
                        }),
                        const SizedBox(height: TSizes.spaceBtwItems / 2),
                      ],
                    );
                  }),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  // Patient Requirements
                  const SectionHeading(
                      title: 'Patient Requirements', showActionButton: false),
                  const SizedBox(height: TSizes.spaceBtwItems),

                  ...patientRequirements.map(
                    (req) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: TColors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: TColors.grey),
                        ),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.checklist,
                              size: 20,
                              color: TColors.textPrimary,
                            ),
                            const SizedBox(width: TSizes.spaceBtwItems / 2),
                            Expanded(
                              child: Text(
                                req,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: TColors.textPrimary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: TSizes.spaceBtwSections),

                  // Submit Button
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () => Get.to(() => StateScreen(
                              image: TImages.successCreatePost,
                              title: 'Your post has been created',
                              subtitle:
                                  'Your post has been created successfully. please click continue to go back to the main menu',
                              showButton: true,
                              primaryButtonTitle: 'Continue',
                              onPressed: () =>
                                  Get.offAll(() => const NavigationMenu()),
                            )),
                        child: const Text('Submit'),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
