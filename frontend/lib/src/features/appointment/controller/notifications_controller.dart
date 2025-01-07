import 'package:denta_koas/src/cores/data/repositories/notifications.repository/notification_repository.dart';
import 'package:denta_koas/src/features/appointment/data/model/notifications_model.dart';
import 'package:denta_koas/src/features/personalization/model/user_model.dart';
import 'package:get/get.dart';

class NotificationsController extends GetxController {
  static NotificationsController get instance => Get.find();

  // Observables
  final isLoading = false.obs; // Indikator loading
  final notificationCount = 0.obs; // Jumlah notifikasi belum dibaca

  final RxList<NotificationsModel> notifications = <NotificationsModel>[].obs;
  final RxList<UserModel> users = <UserModel>[].obs;
  final RxList<NotificationsModel> notificationsByUser =
      <NotificationsModel>[].obs;
  final groupedNotifications = <String, List<Map<String, dynamic>>>{}.obs;
  final notificationRepository = Get.put(NotificationRepository());

  @override
  void onInit() {
    super.onInit();
    fetchNotifications(); // Memuat notifikasi pada inisialisasi controller
  }

  /// Mengambil daftar notifikasi dari repository
  void fetchNotifications() async {
    try {
      isLoading.value = true;

      final fetchedNotifications =
          await notificationRepository.getNotificationsById();
      notifications.assignAll(fetchedNotifications);

      notificationsByUser.assignAll(
        fetchedNotifications
            .where((notification) => notification.id != null)
            .toList(),
      );

      groupNotifications();

      updateNotificationCount();
    } catch (e) {
      notifications.clear();
    } finally {
      isLoading.value = false;
    }
  }

  /// Mengelompokkan notifikasi berdasarkan tanggal
  void groupNotifications() {
    groupedNotifications.clear();

    for (var notification in notifications) {
      final section =
          getSection(notification.createdAt!); // Menggunakan createdAt
      if (!groupedNotifications.containsKey(section)) {
        groupedNotifications[section] = [];
      }
      groupedNotifications[section]!
          .add(notification.toJson()); // Menyimpan dalam bentuk map
    }
  }

  /// Mendapatkan kategori untuk notifikasi berdasarkan tanggal
  String getSection(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    if (date.isAtSameMomentAs(today) || date.isAfter(today)) {
      return "TODAY";
    } else if (date.isAtSameMomentAs(yesterday) || date.isAfter(yesterday)) {
      return "YESTERDAY";
    } else {
      return "EARLIER";
    }
  }

  // void onMarkAsRead(NotificationsModel notification) {
  //   final index = notifications.indexOf(notification);
  //   if (index != -1) {
  //     notifications[index] = NotificationsModel(
  //       id: notification.id,
  //       title: notification.title,
  //       message: notification.message,
  //       status: "Read", // Ubah status menjadi "Read"
  //       userId: notification.userId,
  //       senderId: notification.senderId,
  //       koasId: notification.koasId,
  //       createdAt: notification.createdAt,
  //       updateAt: DateTime.now(),
  //     );
  //     notifications.refresh();
  //     groupedNotifications.refresh();
  //     updateNotificationCount();
  //   }
  // }

  /// Menandai semua notifikasi di sebuah kategori sebagai "dibaca"
  void onMarkAllAsRead(String section) {
    if (groupedNotifications.containsKey(section)) {
      for (var notif in groupedNotifications[section]!) {
        notif["Read"] = true;
      }
      notifications.refresh();
      groupedNotifications.refresh();
      updateNotificationCount();
    }
  }

  /// Menghitung jumlah notifikasi belum dibaca
  void updateNotificationCount() {
    int unreadCount = notifications
        .where((notification) => notification.status == "Unread")
        .length;
    notificationCount.value = unreadCount;
  }

  /// Memperbarui nilai notifikasi di UI
  String notificationValue() {
    return notificationCount.value.toString();
  }

  // Create notification
  Future<void> createNotification(NotificationsModel notification) async {
    try {
      await notificationRepository.createNotification(notification);
    } catch (e) {
      rethrow;
    }
  }

  String formatTime(String dateTime) {
    final date = DateTime.parse(dateTime);
    final formattedTime =
        "${date.hour}:${date.minute.toString().padLeft(2, '0')} ${date.hour >= 12 ? 'PM' : 'AM'}";
    return formattedTime;
  }
}
