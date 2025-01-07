import 'package:denta_koas/src/features/appointment/controller/post.controller/posts_controller.dart';
import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TimeStamp extends StatelessWidget {
  final List<Map<String, dynamic>> timeslots;

  const TimeStamp({
    super.key,
    required this.timeslots,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PostController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Text(
          'Available Time',
          style: Theme.of(context)
              .textTheme
              .titleMedium!
              .apply(color: TColors.textPrimary),
        ),
        const SizedBox(height: TSizes.spaceBtwItems),

        // Time List in Grid Format
        Obx(() {
          return Wrap(
            spacing: 8, // Horizontal space between items
            runSpacing: 8, // Vertical space between rows
            children: List.generate(timeslots.length, (index) {
              final timeslot = timeslots[index];
              final isSelected =
                  controller.timeController.selectedTimeStamp.value == index;
              final isAvailable = timeslot['isAvailable'] ?? false;
              final hasSpace = (timeslot['currentParticipants'] ?? 0) <
                  (timeslot['maxParticipants'] ?? 1);

              final isEnabled = isAvailable && hasSpace;

              return GestureDetector(
                onTap: isEnabled
                    ? () {
                        controller.timeController
                            .updateSelectedTimeStamp(index);

                        controller.selectedTime.value =
                            '${timeslot["startTime"]} - ${timeslot["endTime"]}';
                      }
                    : null, // Disable tap if not available
                child: Container(
                  width: (MediaQuery.of(context).size.width - 64) / 2,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: isSelected && isEnabled
                        ? TColors.primary
                        : TColors.transparent,
                    borderRadius: BorderRadius.circular(TSizes.cardRadiusSm),
                    border: Border.all(
                      color: isEnabled
                          ? (isSelected
                              ? TColors.primary
                              : TColors.textSecondary.withOpacity(0.2))
                          : TColors.textSecondary.withOpacity(0.1),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '${timeslot["startTime"]} - ${timeslot["endTime"]}',
                      style: Theme.of(context).textTheme.bodyMedium!.apply(
                            color: isEnabled
                                ? (isSelected
                                    ? TColors.textWhite
                                    : TColors.textPrimary)
                                : TColors.textSecondary,
                          ),
                    ),
                  ),
                ),
              );
            }),
          );
        }),
      ],
    );
  }
}
