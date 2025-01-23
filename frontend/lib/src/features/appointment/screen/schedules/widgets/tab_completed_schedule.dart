import 'package:denta_koas/src/commons/widgets/layouts/grid_layout.dart';
import 'package:denta_koas/src/features/appointment/controller/appointment.controller/appointments_controller.dart';
import 'package:denta_koas/src/features/appointment/screen/koas_reviews/koas_reviews.dart';
import 'package:denta_koas/src/features/appointment/screen/schedules/widgets/schedule_card.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:denta_koas/src/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabCompletedAppointments extends StatelessWidget {
  const TabCompletedAppointments({
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
                if (controller.completedAppointments.isEmpty) {
                  return Center(
                      child: Column(
                    children: [
                      Image(
                        image: const AssetImage(TImages.emptyPost),
                        width: THelperFunctions.screenWidth(),
                      ),
                      const SizedBox(height: TSizes.spaceBtwSections),
                      Text(
                        'Empty completed koas',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: TSizes.spaceBtwSections),
                      Text(
                        'You don\'t have any completed koas yet.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ));
                }
                {
                  return DGridLayout(
                    itemCount: controller.completedAppointments.length,
                    crossAxisCount: 1,
                    mainAxisExtent: 230,
                    itemBuilder: (_, index) {
                      final appointment =
                          controller.completedAppointments[index];
                      return ScheduleCard(
                        imgUrl: TImages.user,
                        name: appointment.user!.fullName,
                        category: appointment.post!.treatment.alias,
                        date:
                            controller.formatAppointmentDate(appointment.date),
                        timestamp: controller
                            .getAppointmentTimestampRange(appointment),
                        primaryBtnText: 'Details',
                        onPrimaryBtnPressed: () {},
                        onSecondaryBtnPressed: () {},
                        onTap: () => Get.to(() => const KoasReviewsScreen()),
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
