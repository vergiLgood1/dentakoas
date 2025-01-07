import 'package:denta_koas/src/commons/widgets/appbar/appbar.dart';
import 'package:denta_koas/src/commons/widgets/layouts/grid_layout.dart';
import 'package:denta_koas/src/commons/widgets/shimmer/treatment_shimmer.dart';
import 'package:denta_koas/src/commons/widgets/state_screeen/state_screen.dart';
import 'package:denta_koas/src/features/appointment/controller/notifications_controller.dart';
import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:denta_koas/src/utils/constants/sizes.dart';
import 'package:denta_koas/src/utils/helpers/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Gunakan Get.find untuk mengambil instance controller
    final controller = Get.put(NotificationsController());

    return Scaffold(
      appBar: DAppBar(
        title: const Text("Notifications"),
        showBackArrow: true,
        centerTitle: true,
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Obx(
                () => Text(
                  "${controller.notificationValue()} NEW",
                          style: Theme.of(context).textTheme.bodySmall!.apply(
                        color: TColors.primary,
                              ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Obx(() {
        final groupedNotifications = controller.groupedNotifications;
        if (controller.isLoading.value) {
          return TreatmentShimmer(
              itemCount: controller.groupedNotifications.length);
        }
        if (groupedNotifications.isEmpty) {
          return const Center(
            child: StateScreen(
              image: TImages.emptyNotification,
              title: "Empty Notifications",
              subtitle: "You don't have any notifications yet.",
            ),
          );
        }
        return ListView(
          padding: const EdgeInsets.all(0),
          children: groupedNotifications.entries.map((entry) {
            return NotificationSection(
              title: entry.key,
              notifications: entry.value,
              onMarkAllAsRead: () => controller.onMarkAllAsRead(entry.key),
            );
          }).toList(),
        );
      }),
    );
  }
}

class NotificationSection extends StatelessWidget {
  final String title;
  final List<Map<String, dynamic>> notifications;
  final VoidCallback onMarkAllAsRead;
  final Function(Map<String, dynamic>)? onMarkAsRead;

  const NotificationSection({
    super.key,
    required this.title,
    required this.notifications,
    required this.onMarkAllAsRead,
    this.onMarkAsRead,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationsController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(
              left: TSizes.defaultSpace / 2, top: TSizes.defaultSpace),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        DGridLayout(
            itemCount: controller.notificationsByUser.length,
            crossAxisCount: 1,
            mainAxisExtent: 50,
            itemBuilder: (_, index) {
              final notification = controller.notificationsByUser[index];
              return NotificationCard(
                title: notification.message,
                name: notification.sender!.fullName,
                time: notification.createdAt ?? DateTime.now(),
                
          );
        }),
      ],
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String title;
  final String name;
  final DateTime time;
  final bool hasActionButton;

  const NotificationCard({
    super.key,
    required this.title,
    required this.name,
    required this.time,
    this.hasActionButton = false,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationsController());
    final dark = THelperFunctions.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.all(0),
      child: Card(
        color: dark ? TColors.dark : TColors.white,
        elevation: 0,
        child: ListTile(
          leading: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle, // Membuat bentuk lingkaran
              border: Border.all(
                color:
                    dark ? TColors.grey : Colors.grey.shade300, // Warna border
                width: 1.0, // Ketebalan border
              ),
            ),
            child: CircleAvatar(
              backgroundColor: dark ? TColors.dark : TColors.white,
              child: Icon(
                Iconsax.menu_1,
                color: dark ? TColors.white : TColors.dark,
              ),
            ),
          ),
          title: Text(
            title,
            style: TextStyle(color: dark ? TColors.white : TColors.dark),
          ),
          subtitle: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(color: dark ? TColors.grey : TColors.darkGrey),
              ),
              const SizedBox(width: TSizes.spaceBtwInputFields),
              Text(
                controller.formatTime(time.toIso8601String()),
                style: TextStyle(color: dark ? TColors.grey : TColors.darkGrey),
              ),
            ],
          ),
          // trailing: hasActionButton
          //     ? ElevatedButton(
          //         onPressed: () {},
          //         style: ElevatedButton.styleFrom(
          //           backgroundColor: Colors.blue,
          //         ),
          //         child: const Text("Follow"),
          //       )
          //     : null,
        ),

      ),
    );
  }
}
