import 'package:denta_koas/src/commons/widgets/layouts/grid_layout.dart';
import 'package:denta_koas/src/commons/widgets/shimmer/schedule_card_shimmer.dart';
import 'package:denta_koas/src/commons/widgets/text/section_heading.dart';
import 'package:denta_koas/src/features/appointment/controller/appointment.controller/appointments_controller.dart';
import 'package:denta_koas/src/features/appointment/screen/home/widgets/cards/appointment_card.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeUpcomingScheduleSection extends StatelessWidget {
  const HomeUpcomingScheduleSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AppointmentsController());
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
      child: Column(
        // Heading
        children: [
          Obx(() {
            if (controller.confirmedAppointments.isNotEmpty) {
              return SectionHeading(
                title: 'Upcoming Schedule',
                showActionButton: true,
                onPressed: () {},
              );
            }
            return const SizedBox();
          } 
          ),

          // Popular Appointments
          Obx(() {
            if (controller.isLoading.value) {
              return DGridLayout(
                itemCount: 1,
                crossAxisCount: 1,
                mainAxisExtent: 200,
                itemBuilder: (_, index) {
                    return const ScheduleCardShimmer();
                },
              );
            }
            if (controller.confirmedAppointments.isEmpty) {
              return const SizedBox();
              // return const Padding(
              //   padding: EdgeInsets.all(TSizes.defaultSpace),
              //   child: Text('you do not have any upcoming schedule'),
              // );
            }
            return DGridLayout(
                itemCount: 1,
                crossAxisCount: 1,
                mainAxisExtent: 165,
                itemBuilder: (_, index) {
                  final appointment = controller.confirmedAppointments[index];
                  return AppointmentCards(
                    imgUrl: TImages.user,
                    name: appointment.koas?.user?.fullName ?? '',
                    category: appointment.schedule?.post.treatment.alias ?? '',
                    date: controller.formatAppointmentDate(appointment.date),
                    timestamp:
                        controller.getAppointmentTimestampRange(appointment),
                  );
                },
              );
            },
          )
          // const UpcomingScheduleShimmer(),
        ],
      ),
    );
  }
}
