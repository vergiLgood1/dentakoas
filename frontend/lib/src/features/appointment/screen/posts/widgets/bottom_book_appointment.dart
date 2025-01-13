import 'package:denta_koas/src/features/appointment/controller/post.controller/posts_controller.dart';
import 'package:denta_koas/src/features/personalization/controller/user_controller.dart';
import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:denta_koas/src/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomBookAppointment extends StatelessWidget {
  const BottomBookAppointment({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(PostController());
    return Obx(
      () {
      if (UserController.instance.user.value.role != 'Pasien') {
        return const SizedBox.shrink();
      }
      return controller.selectedDate.value != '' &&
              controller.selectedTime.value != ''
          ? Container(
              height: 130,
              padding: const EdgeInsets.symmetric(
                horizontal: TSizes.defaultSpace,
                vertical: TSizes.defaultSpace,
              ),
              decoration: BoxDecoration(
                color: dark ? TColors.darkerGrey : TColors.light,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(TSizes.cardRadiusLg),
                  topRight: Radius.circular(TSizes.cardRadiusLg),
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          Text(
                            name,
                            style:
                                Theme.of(context).textTheme.titleMedium!.apply(
                                      color: dark
                                          ? TColors.white
                                          : TColors.textPrimary,
                                    ),
                          ),
                        ],
                      ),
                      const SizedBox(height: TSizes.defaultSpace),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${controller.selectedDate.value} | ${controller.selectedTime.value}',
                            style:
                                Theme.of(context).textTheme.labelLarge!.apply(
                                      color: dark
                                          ? TColors.white
                                          : TColors.textPrimary,
                                    ),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () =>
                            {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: TColors.primary,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(TSizes.cardRadiusSm),
                          ),
                        ),
                        child: const Text('Book Appointment'),
                      ),
                    ],
                  ),
                ],
              ),
            )
          : const SizedBox.shrink();
    } 
    );
  }
}
