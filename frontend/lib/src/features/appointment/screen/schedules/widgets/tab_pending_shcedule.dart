import 'package:denta_koas/src/commons/widgets/layouts/grid_layout.dart';
import 'package:denta_koas/src/commons/widgets/shimmer/schedule_card_shimmer.dart';
import 'package:denta_koas/src/commons/widgets/state_screeen/state_screen.dart';
import 'package:denta_koas/src/features/appointment/controller/appointment.controller/appointments_controller.dart';
import 'package:denta_koas/src/features/appointment/screen/schedules/widgets/my_appointment/my_appointment.dart';
import 'package:denta_koas/src/features/appointment/screen/schedules/widgets/schedule_card.dart';
import 'package:denta_koas/src/features/personalization/controller/user_controller.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabPendingAppointments extends StatelessWidget {
  const TabPendingAppointments({
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
                    itemCount: controller.pendingAppointments.length,
                    mainAxisExtent: 230,
                    crossAxisCount: 1,
                    itemBuilder: (_, index) {
                      return const ScheduleCardShimmer();
                    },
                  );
                }
                if (controller.pendingAppointments.isEmpty) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: const StateScreen(
                      image: TImages.emptyCalendar,
                      title: "Empty Pending Appointments",
                      subtitle:
                          "Oppss. You don't have any pending appointments yet.",
                    ),
                  );
                }
                if (UserController.instance.user.value.role != 'Koas') {
                  return DGridLayout(
                    itemCount: controller.pendingAppointments.length,
                    crossAxisCount: 1,
                    mainAxisExtent: 230,
                    itemBuilder: (_, index) {
                      final appointment = controller.pendingAppointments[index];
                      return ScheduleCard(
                        imgUrl: TImages.user,
                        name: appointment.koas!.user!.fullName,
                        category: appointment.schedule!.post.treatment.alias,
                        date:
                            controller.formatAppointmentDate(appointment.date),
                        timestamp: controller
                            .getAppointmentTimestampRange(appointment),
                        primaryBtnText: 'Details',
                        onPrimaryBtnPressed: () => Get.to(
                          () => const MyAppointmentScreen(),
                          arguments: appointment,
                        ),
                        onSecondaryBtnPressed: () {},
                        onTap: () => Get.to(
                          () => const MyAppointmentScreen(),
                          arguments: appointment,
                        ),
                      );
                    },
                  );
                }
                {
                  return DGridLayout(
                    itemCount: controller.pendingAppointments.length,
                    crossAxisCount: 1,
                    mainAxisExtent: 230,
                    itemBuilder: (_, index) {
                      final appointment = controller.pendingAppointments[index];
                      return ScheduleCard(
                        imgUrl: TImages.user,
                        name: appointment.koas!.user!.fullName,
                        category: appointment.schedule!.post.treatment.alias,
                        date:
                            controller.formatAppointmentDate(appointment.date),
                        timestamp: controller
                            .getAppointmentTimestampRange(appointment),
                        showSecondaryBtn: true,
                        primaryBtnText: 'Confirm',
                        secondaryBtnText: 'Reject',
                        onPrimaryBtnPressed: () {
                          controller.confirmAppointmentConfirmation(
                            appointment.id!,
                            appointment.pasien?.id ?? '',
                            appointment.koas?.id ?? '',
                            appointment.schedule?.id ?? '',
                            appointment.schedule?.timeslot.first.id ?? '',
                          );
                        },
                        onSecondaryBtnPressed: () {
                          controller.rejectAppointmentConfirmation(
                            appointment.id!,
                            appointment.pasien?.id ?? '',
                            appointment.koas?.id ?? '',
                            appointment.schedule?.id ?? '',
                            appointment.schedule?.timeslot.first.id ?? '',
                          );
                        },
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
