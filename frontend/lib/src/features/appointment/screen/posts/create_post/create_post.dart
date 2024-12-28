import 'package:denta_koas/src/commons/widgets/appbar/appbar.dart';
import 'package:denta_koas/src/commons/widgets/layouts/grid_layout.dart';
import 'package:denta_koas/src/commons/widgets/text/section_heading.dart';
import 'package:denta_koas/src/features/appointment/screen/posts/create_post/widget/date_range_picker.dart';
import 'package:denta_koas/src/features/appointment/screen/posts/create_post/widget/dropdown.dart';
import 'package:denta_koas/src/features/appointment/screen/posts/create_post/widget/dynamic_input.dart';
import 'package:denta_koas/src/utils/constants/colors.dart';
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
      {
        "id": "cm401lfho0000cn6a9ckhlw7p",
        "userId": "cm401i1bm0000rs568ai5zbkf",
        "koasId": "cm401i1br0002rs566ive7e1e",
        "treatmentId": "Surgery",
        "title": "Ini adalah judul",
        "desc":
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla nec purus feugiat, molestie ipsum et, consectetur libero. Nulla facilisi. Nulla nec purus feugiat, molestie ipsum et, consectetur libero. Nulla facilisi.",
        "patientRequirement": [
          "Ini adalah syarat nya",
          "ini adalah syarat nya"
        ],
        "requiredParticipant": 5,
        "status": "Pending",
        "published": false,
        "createdAt": "2024-11-27T15:30:18.925Z",
        "updateAt": "2024-11-28T16:25:34.562Z",
        "Schedule": []
      },
      {
        "id": "cm401lfho0000cn6a9ckhlw7p",
        "userId": "cm401i1bm0000rs568ai5zbkf",
        "koasId": "cm401i1br0002rs566ive7e1e",
        "treatmentId": "cm3znjvlm0000dnorci7ush77",
        "title": "Ini adalah judul",
        "desc":
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla nec purus feugiat, molestie ipsum et, consectetur libero. Nulla facilisi. Nulla nec purus feugiat, molestie ipsum et, consectetur libero. Nulla facilisi.",
        "patientRequirement": [
          "Ini adalah syarat nya",
          "ini adalah syarat nya"
        ],
        "requiredParticipant": 5,
        "status": "Open",
        "published": true,
        "createdAt": "2024-11-27T15:30:18.925Z",
        "updateAt": "2024-11-28T16:25:34.562Z",
        "Schedule": []
      },
      {
        "id": "cm401lfho0000cn6a9ckhlw7p",
        "userId": "cm401i1bm0000rs568ai5zbkf",
        "koasId": "cm401i1br0002rs566ive7e1e",
        "treatmentId": "cm3znjvlm0000dnorci7ush77",
        "title": "Ini adalah judul",
        "desc":
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla nec purus feugiat, molestie ipsum et, consectetur libero. Nulla facilisi. Nulla nec purus feugiat, molestie ipsum et, consectetur libero. Nulla facilisi.",
        "patientRequirement": [
          "Ini adalah syarat nya",
          "ini adalah syarat nya"
        ],
        "requiredParticipant": 5,
        "status": "Closed",
        "published": false,
        "createdAt": "2024-11-27T15:30:18.925Z",
        "updateAt": "2024-11-28T16:25:34.562Z",
        "Schedule": []
      },
    ];
    return Scaffold(
      appBar: DAppBar(
        title: const Text('Post'),
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
      body: GestureDetector(
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
                        padding: const EdgeInsets.all(TSizes.defaultSpace / 2),
                        child: Column(
                          children: [
                            // Section 1
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                          DateTime.parse(post['updateAt']),
                                        ),
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelSmall!
                                            .apply(
                                              color: TColors.textSecondary,
                                            )),
                                    IconButton(
                                      icon: const Icon(Icons.more_vert),
                                      onPressed: () {},
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                        // Add your onPressed code here!
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

class TimeSlotWidget extends StatefulWidget {
  const TimeSlotWidget({super.key});

  @override
  TimeSlotWidgetState createState() => TimeSlotWidgetState();
}

class TimeSlotWidgetState extends State<TimeSlotWidget> {
  final Map<String, List<String>> timeSlots = {
    'Pagi': [],
    'Siang': [],
    'Malam': [],
  };

  Duration sessionDuration = const Duration(hours: 1);
  String selectedSection = 'Pagi';

  void _addTimeSlot(TimeOfDay startTime) {
    final DateTime now = DateTime.now();
    final DateTime startDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      startTime.hour,
      startTime.minute,
    );
    final DateTime endDateTime = startDateTime.add(sessionDuration);

    final String timeSlot =
        "${DateFormat('HH:mm').format(startDateTime)} - ${DateFormat('HH:mm').format(endDateTime)}";

    if (selectedSection == 'Pagi') {
      timeSlots['Pagi']?.add(timeSlot);
    } else if (selectedSection == 'Siang') {
      timeSlots['Siang']?.add(timeSlot);
    } else {
      timeSlots['Malam']?.add(timeSlot);
    }

    setState(() {});
  }

  Future<void> _showTimePicker() async {
    TimeOfDay initialTime;
    if (selectedSection == 'Pagi') {
      initialTime = const TimeOfDay(hour: 6, minute: 0);
    } else if (selectedSection == 'Siang') {
      initialTime = const TimeOfDay(hour: 12, minute: 0);
    } else {
      initialTime = const TimeOfDay(hour: 18, minute: 0);
    }

    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: initialTime,
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
        child: child!,
      ),
    );

    if (pickedTime != null) {
      _addTimeSlot(pickedTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionHeading(title: 'Duration', showActionButton: false),
          const SizedBox(height: TSizes.spaceBtwItems),
          const DDropdownMenu(
            items: [
              '1 Jam',
              '2 Jam',
              '3 Jam',
              '4 Jam',
              '5 Jam',
              '6 Jam',
            ],
            hintText: 'Select Session Duration...',
            prefixIcon: Iconsax.clock,
          ),
          const SizedBox(height: TSizes.spaceBtwItems),
          ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: timeSlots.entries.map((entry) {
              return _buildSection(entry.key, entry.value);
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<String> slots) {
    return SizedBox(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold)),
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  setState(() {
                    selectedSection = title;
                  });
                  _showTimePicker();
                },
              ),
            ],
          ),
          Wrap(
            spacing: 8.0,
            children: slots
                .map((slot) => Chip(
                      label: Text(slot),
                    ))
                .toList(),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
