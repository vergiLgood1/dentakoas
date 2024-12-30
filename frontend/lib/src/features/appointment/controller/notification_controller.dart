import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  final notifications = <Map<String, dynamic>>[

  ].obs;

  final groupedNotifications = <String, List<Map<String, dynamic>>>{}.obs;

  @override
  void onInit() {
    super.onInit();
    groupNotifications();
  }

  String getSection(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    if (date.isAfter(today)) {
      return "TODAY";
    } else if (date.isAfter(yesterday)) {
      return "YESTERDAY";
    } else {
      return "EARLIER";
    }
  }

  void groupNotifications() {
    final Map<String, List<Map<String, dynamic>>> grouped = {};

    for (var notification in notifications) {
      final createdAt = DateTime.parse(notification["createdAt"]);
      final section = getSection(createdAt);

      if (!grouped.containsKey(section)) {
        grouped[section] = [];
      }
      grouped[section]!.add(notification);
    }

    groupedNotifications.value = grouped;
  }

  void onMarkAsRead(Map<String, dynamic> notification) {
    notification["isRead"] = true;
    notifications.refresh();
    groupedNotifications.refresh();
  }

  void onMarkAllAsRead(String section) {
    if (groupedNotifications.containsKey(section)) {
      for (var notif in groupedNotifications[section]!) {
        notif["isRead"] = true;
      }
      notifications.refresh();
      groupedNotifications.refresh();
    }
  }
  

  String notificationValue() {
    final newNotifications =
        notifications.where((notification) => !notification["isRead"]).length;
    return newNotifications.toString();
  }
}
