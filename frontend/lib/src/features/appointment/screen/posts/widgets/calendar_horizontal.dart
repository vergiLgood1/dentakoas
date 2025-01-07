import 'package:denta_koas/src/commons/widgets/text/section_heading.dart';
import 'package:denta_koas/src/features/appointment/controller/post.controller/posts_controller.dart';
import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class CalendarHorizontal extends StatelessWidget {
  const CalendarHorizontal({
    super.key,
    required this.startDate,
    required this.endDate,
  });

  final DateTime startDate;
  final DateTime endDate;

  @override
  Widget build(BuildContext context) {
    final calendarController = Get.put(CalendarController());
    final postController = Get.put(PostController());

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Heading Section
        GestureDetector(
          onTap: () async {
            // Show Date Picker
            final selectedDate = await showDatePicker(
              context: context,
              initialDate: startDate,
              firstDate: startDate,
              lastDate: endDate,
              builder: (BuildContext context, Widget? child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    colorScheme: const ColorScheme.light(
                      primary: TColors.primary, // Header background color
                      onPrimary: Colors.white, // Header text color
                      onSurface: TColors.textPrimary, // Body text color
                    ),
                  ),
                  child: child!,
                );
              },
            );

            // Update header text if a date is selected
            if (selectedDate != null) {
              calendarController.updateSelectedDay(
                selectedDate.difference(startDate).inDays,
              );

              // 
              postController.selectedDate.value =
                  DateFormat('dd MMM yyyy').format(selectedDate);
            }
          },
          child: Obx(() {
            final selectedIndex = calendarController.selectedIndex.value;
            final selectedDate = startDate.add(Duration(days: selectedIndex));
            return Row(children: [
              SectionHeading(
                title: DateFormat('MMM, yyyy').format(selectedDate),
                showActionButton: false,
              ),
              const SizedBox(width: 4),
              const Icon(
                CupertinoIcons.chevron_down,
                size: TSizes.iconSm,
                color: TColors.textPrimary,
              ),
            ]);
          }),
        ),
        const SizedBox(
            height:
                TSizes.spaceBtwItems), // Spacing between heading and calendar

        // Calendar
        Row(
          children: [
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Obx(() {
                  final totalDays = endDate.difference(startDate).inDays + 1;
                  return Row(
                    children: List.generate(
                      totalDays,
                      (index) {
                        final currentDate =
                            startDate.add(Duration(days: index));
                        final isSelected =
                            index == calendarController.selectedIndex.value;

                        return GestureDetector(
                          onTap: () {
                            calendarController.updateSelectedDay(index);
                            postController.selectedDate.value =
                                DateFormat('dd MMM yyyy').format(currentDate);
                          },
                          child: Container(
                            width: 80,
                            height: 90,
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? TColors.primary
                                  : TColors.transparent,
                              borderRadius:
                                  BorderRadius.circular(TSizes.cardRadiusMd),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  currentDate.day < 10
                                      ? '0${currentDate.day}'
                                      : currentDate.day.toString(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineMedium!
                                      .apply(
                                        color: isSelected
                                            ? TColors.textWhite
                                            : TColors.darkGrey,
                                      ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  DateFormat('EEE')
                                      .format(currentDate)
                                      .toUpperCase(),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .apply(
                                        color: isSelected
                                            ? TColors.textWhite
                                            : TColors.darkGrey,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }),
              ),
            )
          ],
        ),
      ],
    );
  }
}
