import 'package:denta_koas/navigation_menu.dart';
import 'package:denta_koas/src/commons/widgets/appbar/appbar.dart';
import 'package:denta_koas/src/commons/widgets/layouts/grid_layout.dart';
import 'package:denta_koas/src/commons/widgets/state_screeen/state_screen.dart';
import 'package:denta_koas/src/commons/widgets/text/section_heading.dart';
import 'package:denta_koas/src/features/appointment/screen/posts/create_post/widget/date_range_picker.dart';
import 'package:denta_koas/src/features/appointment/screen/posts/create_post/widget/dropdown.dart';
import 'package:denta_koas/src/features/appointment/screen/posts/create_post/widget/dynamic_input.dart';
import 'package:denta_koas/src/features/appointment/screen/posts/create_post/widget/timeslot.dart';
import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:time_slot/controller/day_part_controller.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> posts = [
      // {
      //   "id": "cm401lfho0000cn6a9ckhlw7p",
      //   "userId": "cm401i1bm0000rs568ai5zbkf",
      //   "koasId": "cm401i1br0002rs566ive7e1e",
      //   "treatmentId": "Surgery",
      //   "title": "Ini adalah judul",
      //   "desc":
      //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla nec purus feugiat, molestie ipsum et, consectetur libero. Nulla facilisi. Nulla nec purus feugiat, molestie ipsum et, consectetur libero. Nulla facilisi.",
      //   "patientRequirement": [
      //     "Ini adalah syarat nya",
      //     "ini adalah syarat nya"
      //   ],
      //   "requiredParticipant": 5,
      //   "status": "Pending",
      //   "published": false,
      //   "createdAt": "2024-11-27T15:30:18.925Z",
      //   "updateAt": "2024-11-28T16:25:34.562Z",
      //   "Schedule": []
      // },
      // {
      //   "id": "cm401lfho0000cn6a9ckhlw7p",
      //   "userId": "cm401i1bm0000rs568ai5zbkf",
      //   "koasId": "cm401i1br0002rs566ive7e1e",
      //   "treatmentId": "cm3znjvlm0000dnorci7ush77",
      //   "title": "Ini adalah judul",
      //   "desc":
      //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla nec purus feugiat, molestie ipsum et, consectetur libero. Nulla facilisi. Nulla nec purus feugiat, molestie ipsum et, consectetur libero. Nulla facilisi.",
      //   "patientRequirement": [
      //     "Ini adalah syarat nya",
      //     "ini adalah syarat nya"
      //   ],
      //   "requiredParticipant": 5,
      //   "status": "Open",
      //   "published": true,
      //   "createdAt": "2024-11-27T15:30:18.925Z",
      //   "updateAt": "2024-11-28T16:25:34.562Z",
      //   "Schedule": []
      // },
      // {
      //   "id": "cm401lfho0000cn6a9ckhlw7p",
      //   "userId": "cm401i1bm0000rs568ai5zbkf",
      //   "koasId": "cm401i1br0002rs566ive7e1e",
      //   "treatmentId": "cm3znjvlm0000dnorci7ush77",
      //   "title": "Ini adalah judul",
      //   "desc":
      //       "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla nec purus feugiat, molestie ipsum et, consectetur libero. Nulla facilisi. Nulla nec purus feugiat, molestie ipsum et, consectetur libero. Nulla facilisi.",
      //   "patientRequirement": [
      //     "Ini adalah syarat nya",
      //     "ini adalah syarat nya"
      //   ],
      //   "requiredParticipant": 5,
      //   "status": "Closed",
      //   "published": false,
      //   "createdAt": "2024-11-27T15:30:18.925Z",
      //   "updateAt": "2024-11-28T16:25:34.562Z",
      //   "Schedule": []
      // },
    ];
    return Scaffold(
      appBar: DAppBar(
        title: const Text('Post'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 0),
            child: IconButton(
              icon: const Icon(Iconsax.add_circle),
              onPressed: () => Get.to(() => const CreateGeneralInformation()),
            ),
          ),
        ],
      ),
      body: posts.isEmpty
          ? GestureDetector(
              onTap: () => Get.to(() => const CreateGeneralInformation()),
              child: const StateScreen(
                image: TImages.emptyPost,
                title: 'Empty Post',
                subtitle: 'You don\'t have any post yet. Click to create one.',
              ),
            )
          : GestureDetector(
              onTap: () => Get.to(() => const CreateGeneralInformation()),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(
                    TSizes.defaultSpace,
                  ),
                  child: Column(
                    children: [
                      DGridLayout(
                        crossAxisCount: 1,
                        mainAxisExtent: 250,
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          final post = posts[index];
                          Color statusColor;
                          switch (post['status']) {
                            case 'Pending':
                              statusColor = TColors.warning;
                              break;
                            case 'Open':
                              statusColor = TColors.success;
                              break;
                            case 'Closed':
                              statusColor = TColors.error;
                              break;
                            default:
                              statusColor = TColors.grey;
                          }
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(TSizes.cardRadiusLg),
                              side: const BorderSide(
                                color: TColors.grey,
                              ),
                            ),
                            color: TColors.grey.withOpacity(0.0),
                            elevation: 0,
                            child: Padding(
                              padding:
                                  const EdgeInsets.all(TSizes.defaultSpace / 2),
                              child: Column(
                                children: [
                                  // Section 1
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.circle,
                                            size: 8.0,
                                            color: statusColor,
                                          ),
                                          const SizedBox(
                                              width: TSizes.spaceBtwItems / 4),
                                          Text(
                                            post['status'],
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall!
                                                .apply(
                                                  color: statusColor,
                                                ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                              DateFormat('dd MMM yyyy').format(
                                                DateTime.parse(
                                                    post['updateAt']),
                                              ),
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall!
                                                  .apply(
                                                    color:
                                                        TColors.textSecondary,
                                                  )),
                                          IconButton(
                                            icon: const Icon(Icons.more_vert),
                                            onPressed: () {
                                              showModalBottomSheet(
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    topLeft:
                                                        Radius.circular(12),
                                                    topRight:
                                                        Radius.circular(12),
                                                  ),
                                                ),
                                                context: context,
                                                builder: (context) {
                                                  return Wrap(
                                                    children: [
                                                      ListTile(
                                                        leading: const Icon(
                                                            Icons.open_in_new),
                                                        title: const Text(
                                                            'Publish'),
                                                        onTap: () {
                                                          // Handle open action
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                      ListTile(
                                                        leading: const Icon(
                                                            Icons.update),
                                                        title: const Text(
                                                            'Update'),
                                                        onTap: () {
                                                          // Handle update action
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                      ListTile(
                                                        leading: const Icon(
                                                            Iconsax.trash,
                                                            color: Colors.red),
                                                        title: const Text(
                                                            'Delete',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .red)),
                                                        onTap: () {
                                                          // Handle delete action
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                    ],
                                                  );
                                                },
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: TSizes.spaceBtwItems),
                                  // Section 2
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          post['title'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .apply(
                                                color: TColors.textPrimary,
                                              ),
                                        ),
                                        const SizedBox(
                                            height: TSizes.spaceBtwItems / 2),
                                        Text(
                                          post['desc'],
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .apply(
                                                color: TColors.textSecondary,
                                              ),
                                          textAlign: TextAlign.justify,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: TSizes.spaceBtwItems),
                                  const Divider(),
                                  const SizedBox(height: TSizes.spaceBtwItems),
                                  // Section 3
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'Category: ${post['treatmentId'] ?? 'N/A'}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall!
                                          .apply(
                                            color: TColors.textSecondary,
                                          ),
                                    ),
                                  ),
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
            ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () => Get.to(() => const CreateGeneralInformation()),
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}

class CreateSchedulePost extends StatelessWidget {
  const CreateSchedulePost({super.key});

  @override
  Widget build(BuildContext context) {
    DateTime selectTime = DateTime.now();

    DayPartController dayPartController = DayPartController();
    return Scaffold(
      appBar: DAppBar(
        title: const Text('Schedule Appointment'),
        onBack: () => Get.back(),
        showBackArrow: true,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Form(
            child: Column(
              children: [
                const SectionHeading(
                  title: 'Date Start & Date End',
                  showActionButton: false,
                ),
                const SizedBox(height: TSizes.spaceBtwItems),

                // Calendar Date Picker
                const DateRangePicker(),
                const SizedBox(height: TSizes.spaceBtwItems),

                const TimeSlotWidget(),
                const SizedBox(height: TSizes.spaceBtwInputFields),

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
                      onPressed: () {
                        Get.to(() => PostPreviewScren());
                      },
                      child: const Text('Submit'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CreateGeneralInformation extends StatelessWidget {
  const CreateGeneralInformation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DAppBar(
        title: const Text('Create Post'),
        onBack: () => Get.back(),
        showBackArrow: true,
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 0),
            child: IconButton(
              icon: const Icon(Icons.more_vert),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(
            TSizes.defaultSpace,
          ),
          child: Form(
              child: Column(
            children: [
              //
              const SectionHeading(
                title: 'General Information',
                showActionButton: false,
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),

              // Title
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.title),
                  labelText: 'Title',
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),

              // Description
              TextFormField(
                maxLines: 5,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  alignLabelWithHint: true,
                  labelText: 'Description',
                ),
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),

              // max participant
              TextFormField(
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.group),
                  labelText: 'Required Participant',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),

              // Category
              const DDropdownMenu(
                items: ['Surgery', 'Dentist', 'General Checkup'],
              ),
              const SizedBox(height: TSizes.spaceBtwInputFields),

              const DynamicInputForm(),
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
                    onPressed: () => Get.to(() => const CreateSchedulePost()),
                    child: const Text('Next'),
                  ),
                ),
              )
              // SizedBox(
              //   width: double.infinity,
              //   child: ElevatedButton(
              //     style: ElevatedButton.styleFrom(
              //       shape: RoundedRectangleBorder(
              //         borderRadius: BorderRadius.circular(12),
              //       ),
              //     ),
              //     onPressed: () {},
              //     child: const Text('Submit'),
              //   ),
              // ),
            ],
          )),
        ),
      ),
    );
  }
}

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

