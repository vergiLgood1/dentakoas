import 'package:denta_koas/src/commons/widgets/appbar/appbar.dart';
import 'package:denta_koas/src/commons/widgets/text/section_heading.dart';
import 'package:denta_koas/src/features/appointment/controller/post.controller/schedule_controller.dart';
import 'package:denta_koas/src/features/appointment/screen/posts/create_post/widget/date_range_picker.dart';
import 'package:denta_koas/src/features/appointment/screen/posts/create_post/widget/timeslot.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:time_slot/controller/day_part_controller.dart';

class CreateSchedulePost extends StatelessWidget {
  const CreateSchedulePost({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SchedulePostController());
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
                        controller.createPostSchedule();
                        Logger().e('Date Start: ${controller.dateStartValue}');
                        Logger().e('Date End: ${controller.dateEndValue}');
                        // controller2.createAllTimeSlots(postId);
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
