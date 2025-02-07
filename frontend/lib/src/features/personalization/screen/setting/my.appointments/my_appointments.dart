import 'package:denta_koas/src/commons/widgets/appbar/appbar.dart';
import 'package:denta_koas/src/commons/widgets/layouts/grid_layout.dart';
import 'package:denta_koas/src/commons/widgets/shimmer/schedule_card_shimmer.dart';
import 'package:denta_koas/src/commons/widgets/state_screeen/state_screen.dart';
import 'package:denta_koas/src/features/appointment/controller/appointment.controller/appointments_controller.dart';
import 'package:denta_koas/src/features/appointment/screen/schedules/widgets/schedule_card.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyOngoingAppointmentsScreen extends StatelessWidget {
  const MyOngoingAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = AppointmentsController.instance;
    return Scaffold(
      appBar: const DAppBar(
        title: Text('My Appointments'),
        showBackArrow: true,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: Obx(
          () {
            if (controller.isLoading.value) {
              return ScheduleCardShimmer(
                  itemCount: controller.ongoingAppointments.length);
            }
            if (controller.ongoingAppointments.isEmpty) {
              return const StateScreen(
                image: TImages.emptyCalendar,
                title: 'No Appointments Found',
                subtitle: "You don't have ongoing appointment for today",
                isLottie: false,
              );
            }
            return DGridLayout(
              itemCount: 1,
              crossAxisCount: 1,
              mainAxisExtent: 130,
              itemBuilder: (_, index) {
                final appointment = controller.ongoingAppointments[index];
                return ScheduleCard(
                  isNetworkImage: true,
                  imgUrl:
                      'https://images.pexels.com/photos/4167541/pexels-photo-4167541.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1',
                  name: appointment.koas?.user?.name ?? 'N/A',
                  category: appointment.schedule?.post.treatment.alias ?? 'N/A',
                  date: controller.formatAppointmentDate(appointment.date),
                  timestamp:
                      controller.getAppointmentTimestampRange(appointment),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
