import 'package:denta_koas/src/commons/widgets/layouts/grid_layout.dart';
import 'package:denta_koas/src/commons/widgets/shimmer/schedule_card_shimmer.dart';
import 'package:denta_koas/src/commons/widgets/state_screeen/state_screen.dart';
import 'package:denta_koas/src/features/appointment/controller/appointment.controller/appointments_controller.dart';
import 'package:denta_koas/src/features/appointment/screen/schedules/widgets/my_appointment/my_appointment.dart';
import 'package:denta_koas/src/features/appointment/screen/schedules/widgets/schedule_card.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabCancelAppointments extends StatelessWidget {
  const TabCancelAppointments({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AppointmentsController());

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
          child: Column(
            children: [
              Obx(() {
                if (controller.isLoading.value) {
                  return DGridLayout(
                    itemCount: controller.canceledAppointments.length,
                    mainAxisExtent: 230,
                    crossAxisCount: 1,
                    itemBuilder: (_, index) {
                      return const ScheduleCardShimmer();
                    },
                  );
                }
                if (controller.canceledAppointments.isEmpty) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: const StateScreen(
                      image: TImages.emptyCalendar,
                      title: "Empty Cancelled Appointments",
                      subtitle:
                          "Oppss. You don't have any cancelled appointments yet.",
                    ),
                  );
                }
                {
                  return DGridLayout(
                    itemCount: controller.canceledAppointments.length,
                    crossAxisCount: 1,
                    mainAxisExtent: 230,
                    itemBuilder: (_, index) {
                      final appointment =
                          controller.canceledAppointments[index];
                      return ScheduleCard(
                        imgUrl: TImages.user,
                        name: appointment.koas!.user!.fullName,
                        category: appointment.schedule!.post.treatment.alias,
                        date:
                            controller.formatAppointmentDate(appointment.date),
                        timestamp: controller
                            .getAppointmentTimestampRange(appointment),
                        primaryBtnText: 'Details',
                        onPrimaryBtnPressed: () {},
                        onSecondaryBtnPressed: () {},
                        onTap: () => Get.to(() => const MyAppointmentScreen(),
                            arguments: appointment),
                      );
                    },
                  );
                }
              }),
            ],
          ),
        ),
      ],
    );
  }
}
