import 'package:denta_koas/src/commons/widgets/appbar/tabbar.dart';
import 'package:denta_koas/src/features/appointment/screen/schedules/widgets/tab_cancel_schedule.dart';
import 'package:denta_koas/src/features/appointment/screen/schedules/widgets/tab_completed_schedule.dart';
import 'package:denta_koas/src/features/appointment/screen/schedules/widgets/tab_ongoing_schedule.dart';
import 'package:denta_koas/src/features/appointment/screen/schedules/widgets/tab_upcoming_schedules.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:denta_koas/src/utils/device/device_utility.dart';
import 'package:flutter/material.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appBarHeight = TDeviceUtils.getAppBarHeight();
    return DefaultTabController(
      length: 4,
      initialIndex: 1,
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: appBarHeight), // Menambahkan jarak ke bawah
            TabBarApp(
              splashFactory: NoSplash.splashFactory,
              splashBorderRadius: BorderRadius.circular(30.0),
              dividerColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.label,
              indicator: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(30.0),
              ),
              isScrollable: true,
              tabAlignment: TabAlignment.center,
              tabs: [
                Tab(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: TSizes.spaceBtwItems), // Margin antar tab
                    child: const Text('Canceled Schedule'),
                  ),
                ),
                Tab(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: TSizes.spaceBtwItems),
                    child: const Text('Upcoming Schedule'),
                  ),
                ),
                Tab(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: TSizes.spaceBtwItems),
                    child: const Text('Ongoing Schedule'),
                  ),
                ),
                Tab(
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        horizontal: TSizes.spaceBtwItems),
                    child: const Text('Completed Schedule'),
                  ),
                ),
              ],
            ),
            const Expanded(
              child: TabBarView(
                children: [
                  TabCancelSchedule(),
                  TabUpcomingSchedules(),
                  TabOngoingSchedule(),
                  TabCompletedSchedule(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
