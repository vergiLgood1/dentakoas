import 'package:denta_koas/src/commons/widgets/appbar/appbar.dart';
import 'package:denta_koas/src/commons/widgets/notifications/notification_menu.dart';
import 'package:denta_koas/src/features/appointment/screen/notifications/notification.dart';
import 'package:denta_koas/src/features/personalization/controller/user_controller.dart';
import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/loaders/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return DAppBar(
      avatar: Image.asset(
        TImages.user,
        fit: BoxFit.cover,
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Obx(() {
            if (controller.profileLoading.value) {
              return const TShimmerEffect(width: 80, height: 15);
            } else {
            final greeting = controller.updateGreetingMessage();
            return Text(
              greeting,
              style: Theme.of(context)
                .textTheme
                .labelMedium!
                .apply(color: TColors.black),
            );
            }
          }),
          Obx(() {
            if (controller.profileLoading.value) {
              return const TShimmerEffect(width: 80, height: 15);
            } else {
              return Text(
                controller.user.value.fullName,
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .apply(color: TColors.black),
              );
            }
          }),
        ],
      ),
      actions: [
        NotificationCounterIcon(
            onPressed: () => Get.to(() => NotificationScreen())),
      ],
    );
  }
}
