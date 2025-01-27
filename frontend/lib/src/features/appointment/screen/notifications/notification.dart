import 'package:denta_koas/src/commons/widgets/appbar/appbar.dart';
import 'package:denta_koas/src/commons/widgets/shimmer/treatment_shimmer.dart';
import 'package:denta_koas/src/commons/widgets/state_screeen/state_screen.dart';
import 'package:denta_koas/src/features/appointment/controller/notifications_controller.dart';
import 'package:denta_koas/src/features/appointment/data/model/notifications_model.dart';
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
        // DGridLayout(
        //     itemCount: controller.notificationsByUser.length,
        //     crossAxisCount: 1,
        //     mainAxisExtent: 100,
        //     itemBuilder: (_, index) {
        //       final notification = controller.notificationsByUser[index];
        //       return NotificationCard(
        //         title: notification.message,
        //         name: notification.sender!.fullName,
        //         time: notification.createdAt ?? DateTime.now(),
        //         isRead: notification.status ==
        //             StatusNotification.Read, // Tambahkan parameter status
        //         onTap: () {
        //           if (notification.status == StatusNotification.Unread) {
        //             controller.markAsRead(notification.id!);
        //           }
        //         },

        //   );
        // }),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            final notification = controller.notificationsByUser[index];
            return NotificationCard(
                title: notification.message,
                name: notification.sender!.fullName,
                time: notification.createdAt ?? DateTime.now(),
              isRead: notification.status ==
                  StatusNotification.Read, // Tambahkan parameter status
              onTap: () {
                if (notification.status == StatusNotification.Unread) {
                  controller.markAsRead(notification.id!);
                }
              },
                
          );
          },
        )
      ],
    );
  }
}

class NotificationCard extends StatelessWidget {
  final String title;
  final String name;
  final DateTime time;
  final bool hasActionButton;
  final bool isRead; // Tambahkan parameter status
  final VoidCallback onTap; // Tambahkan handler untuk tap

  const NotificationCard({
    super.key,
    required this.title,
    required this.name,
    required this.time,
    this.hasActionButton = false,
    required this.isRead, // Tambahkan required parameter
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NotificationsController());
    final dark = THelperFunctions.isDarkMode(context);
    
    // Tentukan warna background berdasarkan status
    final backgroundColor = isRead
        ? (dark ? TColors.dark : TColors.white)
        : (dark ? TColors.darkerGrey : TColors.primary.withOpacity(0.1));

    return InkWell(
      // Wrap dengan InkWell untuk handling tap
      onTap: isRead ? null : onTap,
      splashColor: TColors.primary.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: Card(
          color: backgroundColor, // Gunakan warna dinamis
          elevation: 0,
          child: ListTile(
            leading: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: dark ? TColors.grey : Colors.grey.shade300,
                  width: 1.0,
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
              style: TextStyle(
                color: dark ? TColors.white : TColors.dark,
                fontWeight: isRead
                    ? FontWeight.normal
                    : FontWeight.bold, // Tambahkan perbedaan weight
              ),
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style:
                      TextStyle(color: dark ? TColors.grey : TColors.darkGrey),
                ),
                Text(
                  controller.formatTime(time.toIso8601String()),
                  style:
                      TextStyle(color: dark ? TColors.grey : TColors.darkGrey),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
