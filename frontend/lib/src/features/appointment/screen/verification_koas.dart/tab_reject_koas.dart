import 'package:denta_koas/src/commons/widgets/layouts/grid_layout.dart';
import 'package:denta_koas/src/features/appointment/controller/verification_koas_controller.dart';
import 'package:denta_koas/src/features/appointment/screen/koas/koas_details/koas_detail.dart';
import 'package:denta_koas/src/features/appointment/screen/schedules/widgets/schedule_card.dart';
import 'package:denta_koas/src/features/personalization/controller/user_controller.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:denta_koas/src/utils/formatters/formatter.dart';
import 'package:denta_koas/src/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabRejectedKoas extends StatelessWidget {
  const TabRejectedKoas({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VerificationKoasController());

    final universityFasilitator =
        UserController.instance.user.value.profile.university;
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
                if (controller.rejectedKoas.isEmpty) {
                  return Center(
                      child: Column(
                    children: [
                      Image(
                        image: const AssetImage(TImages.emptyCalendar),
                        width: THelperFunctions.screenWidth(),
                      ),
                      const SizedBox(height: TSizes.spaceBtwSections),
                      Text(
                        'Empty Rejected koas',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: TSizes.spaceBtwSections),
                      Text(
                        'You don\'t have any Rejected koas yet.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ));
                }
                {
                  return DGridLayout(
                    itemCount: controller.rejectedKoas.length,
                    crossAxisCount: 1,
                    mainAxisExtent: 230,
                    itemBuilder: (_, index) {
                      final koas = controller.rejectedKoas[index];
                      return ScheduleCard(
                        imgUrl: TImages.user,
                        name: koas.name!,
                        category: koas.koasProfile!.university!,
                        date: TFormatter.formatDateToFullDayName(koas.updateAt),
                        timestamp:
                            TFormatter.formatTimeToLocal(koas.updateAt),
                        primaryBtnText: 'Details',
                        onPrimaryBtnPressed: () {},
                        onSecondaryBtnPressed: () {},
                        onTap: () => Get.to(() => const KoasDetailScreen(),
                            arguments: koas),
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
