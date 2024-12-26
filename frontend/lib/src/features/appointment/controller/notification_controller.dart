import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NotificationController extends GetxController {
  final notifications = <Map<String, dynamic>>[
    {
      "title": "Appointment Success",
      "message":
          "Congratulations - your appointment is confirmed! We're looking forward to meeting with you.",
      "icon": Icons.calendar_today,
      "iconColor": Colors.green,
      "isRead": false,
      "createdAt": "2024-12-26T15:30:18.925Z",
      "updatedAt": "2024-12-26T15:30:18.925Z",
    },
    {
      "title": "Schedule Changed",
      "message":
          "You have successfully changed your appointment with Dr. Joshua Doe. Don’t forget to activate your reminder.",
      "icon": Icons.schedule,
      "iconColor": Colors.blue,
      "isRead": false,
      "createdAt": "2024-12-26T15:30:18.925Z",
      "updatedAt": "2024-12-26T15:30:18.925Z",
    },
    {
      "title": "Video Call Appointment",
      "message":
          "We'll send you a link to join the call at the booking details, so all you need is a computer or mobile device with a camera and an internet connection.",
      "icon": Icons.check,
      "iconColor": Colors.green,
      "isRead": false,
      "createdAt": "2024-12-25T15:30:18.925Z",
      "updatedAt": "2024-12-25T15:30:18.925Z",
    },
    {
      "title": "Appointment Cancelled",
      "message":
          "You have successfully cancelled your appointment with Dr. Joshua Doe. 90% of the funds will be returned to your account.",
      "icon": Icons.cancel,
      "iconColor": Colors.red,
      "isRead": false,
      "createdAt": "2024-12-25T15:30:18.925Z",
      "updatedAt": "2024-12-25T15:30:18.925Z",
    },
    {
      "title": "Video Call Appointment",
      "message":
          "We'll send you a link to join the call at the booking details, so all you need is a computer or mobile device with a camera and an internet connection.",
      "icon": Icons.check,
      "iconColor": Colors.green,
      "isRead": false,
      "createdAt": "2024-12-24T15:30:18.925Z",
      "updatedAt": "2024-12-24T15:30:18.925Z",
    },
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
