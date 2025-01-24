import 'package:denta_koas/src/commons/widgets/layouts/grid_layout.dart';
import 'package:denta_koas/src/features/appointment/controller/appointment.controller/appointments_controller.dart';
import 'package:denta_koas/src/features/appointment/screen/schedules/widgets/my_appointment/my_appointment.dart';
import 'package:denta_koas/src/features/appointment/screen/schedules/widgets/schedule_card.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:denta_koas/src/utils/helpers/helper_functions.dart';
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
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.canceledAppointments.isEmpty) {
                  return Center(
                      child: Column(
                    children: [
                      Image(
                        image: const AssetImage(TImages.emptyPost),
                        width: THelperFunctions.screenWidth(),
                      ),
                      const SizedBox(height: TSizes.spaceBtwSections),
                      Text(
                        'Empty canceled koas',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: TSizes.spaceBtwSections),
                      Text(
                        'You don\'t have any canceled koas yet.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ));
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
