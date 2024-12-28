import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:denta_koas/src/features/appointment/controller/post_controller';
import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DateRangePicker extends StatelessWidget {
  const DateRangePicker({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PostController());
    final rangeDatePickerValueWithDefaultValue =
        controller.calendarController.selectedDateRange;

    final config = CalendarDatePicker2Config(
      centerAlignModePicker: true,
      calendarType: CalendarDatePicker2Type.range,
      selectedDayHighlightColor: TColors.primary,
      weekdayLabelTextStyle: const TextStyle(
        color: TColors.textSecondary,
        fontWeight: FontWeight.bold,
      ),
      controlsTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      dynamicCalendarRows: true,
      daySplashColor: TColors.primary.withOpacity(0.2),
      disableVibration: true,
      dayMaxWidth: 64,
      modePickerBuilder: ({
        required viewMode,
        required monthDate,
        isMonthPicker,
      }) {
        return Center(
          child: Container(
            padding: const EdgeInsets.all(0),
            margin: const EdgeInsets.symmetric(horizontal: 0),
            child: Text(
              isMonthPicker == true
                  ? getLocaleFullMonthFormat(const Locale('en'))
                      .format(monthDate)
                  : monthDate.year.toString(),
              style: const TextStyle(
                color: TColors.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        );
      },
      weekdayLabelBuilder: ({required weekday, isScrollViewTopHeader}) {
        if (weekday == DateTime.sunday) {
          return const Center(
            child: Text(
              'M',
              style: TextStyle(
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }
        return null;
      },
      disabledDayTextStyle:
          const TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
      selectableDayPredicate: (day) => !day.isBefore(
        DateUtils.dateOnly(
          DateTime.now(),
        ),
      ),
    );
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Column(
        children: [
          Obx(() {
            final selectedRange =
                controller.calendarController.selectedDateRange;
            final startDate =
                selectedRange.isNotEmpty && selectedRange[0] != null
                    ? selectedRange[0]!.toLocal().toString().split(' ')[0]
                    : '';
            final endDate = selectedRange.length > 1 && selectedRange[1] != null
                ? selectedRange[1]!.toLocal().toString().split(' ')[0]
                : '';
            final dateRange = startDate.isNotEmpty && endDate.isNotEmpty
                ? '$startDate - $endDate'
                : 'Select Date Range';

            return TextFormField(
              readOnly: true,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.calendar_today),
                hintText: dateRange,
              ),
              onTap: () async {
                final selectedDates = await showDialog<List<DateTime?>>(
                  context: context,
                  builder: (context) => Dialog(
                    child: CalendarDatePicker2(
                      config: config,
                      value: controller.calendarController.selectedDateRange,
                      onValueChanged: (dates) {
                        controller.calendarController.selectedDateRange.value =
                            dates;
                      },
                    ),
                  ),
                );
                if (selectedDates != null) {
                  controller.calendarController.selectedDateRange.value =
                      selectedDates;
                }
              },
            );
          }),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
