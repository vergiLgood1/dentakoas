import 'package:denta_koas/src/commons/widgets/appbar/appbar.dart';
import 'package:denta_koas/src/commons/widgets/state_screeen/state_screen.dart';
import 'package:denta_koas/src/features/appointment/controller/notification_controller.dart';
import 'package:denta_koas/src/utils/constants/colors.dart';
import 'package:denta_koas/src/utils/constants/image_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationScreen extends StatelessWidget {
  final NotificationController controller = Get.put(NotificationController());

  NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DAppBar(
        title: const Text("Notifications"),
        showBackArrow: true,
        centerTitle: true,
        actions: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(right: 0.0),
              child: Obx(
                () => controller.notificationValue() != '0'
                    ? Chip(
                        label: Text(
                          "${controller.notificationValue()} NEW",
                          style: Theme.of(context).textTheme.bodySmall!.apply(
                                color: TColors.white,
                              ),
                        ),
                        backgroundColor: TColors.primary,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ),
          ),
        ],
      ),
 
      body: Obx(() {
        final groupedNotifications = controller.groupedNotifications;
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
          padding: const EdgeInsets.all(16.0),
          children: groupedNotifications.entries.map((entry) {
            return NotificationSection(
              title: entry.key,
              notifications: entry.value,
              onMarkAllAsRead: () => controller.onMarkAllAsRead(entry.key),
              onMarkAsRead: (notification) =>
                  controller.onMarkAsRead(notification),
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
  final Function(Map<String, dynamic>) onMarkAsRead;

  const NotificationSection({
    super.key,
    required this.title,
    required this.notifications,
    required this.onMarkAllAsRead,
    required this.onMarkAsRead,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              TextButton(
                onPressed: onMarkAllAsRead,
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 0,
                  ),
                ),
                child: Text(
                  "Mark all as read",
                  style: Theme.of(context).textTheme.bodySmall!.apply(
                        color: Colors.blue,
                      ),
                ),
              ),
            ],
          ),
        ),
        ...notifications.map((notification) {
          return NotificationCard(
            notification: notification,
            onMarkAsRead: () => onMarkAsRead(notification),
          );
        }),
      ],
    );
  }
}

class NotificationCard extends StatelessWidget {
  final Map<String, dynamic> notification;
  final VoidCallback onMarkAsRead;

  const NotificationCard({
    super.key,
    required this.notification,
    required this.onMarkAsRead,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onMarkAsRead,
      child: Card(
        color: notification["isRead"] ? Colors.white : Colors.blue.shade50,
        elevation: 0,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor:
                    (notification["iconColor"] as Color).withOpacity(0.2),
                child: Icon(
                  notification["icon"] as IconData,
                  color: notification["iconColor"] as Color,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                    Text(
                      notification["title"] as String,
                      style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                      ),
                    ),
                        Text(
                          _formatTime(notification["createdAt"] as String),
                          style:
                              const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notification["message"] as String,
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _formatTime(String dateTime) {
    final date = DateTime.parse(dateTime);
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return "${difference.inDays}d";
    } else if (difference.inHours > 0) {
      return "${difference.inHours}h";
    } else {
      return "${difference.inMinutes}m";
    }
  }
}
