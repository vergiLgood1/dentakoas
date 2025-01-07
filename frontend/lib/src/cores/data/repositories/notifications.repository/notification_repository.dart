import 'package:denta_koas/src/cores/data/repositories/authentication.repository/authentication_repository.dart';
import 'package:denta_koas/src/features/appointment/data/model/notifications_model.dart';
import 'package:denta_koas/src/utils/constants/api_urls.dart';
import 'package:denta_koas/src/utils/dio.client/dio_client.dart';
import 'package:denta_koas/src/utils/exceptions/exceptions.dart';
import 'package:denta_koas/src/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:denta_koas/src/utils/exceptions/firebase_exceptions.dart';
import 'package:denta_koas/src/utils/exceptions/format_exceptions.dart';
import 'package:denta_koas/src/utils/exceptions/platform_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class NotificationRepository extends GetxController {
  static NotificationRepository get instance => Get.find();

  Future<List<NotificationsModel>> getNotificationsById() async {
    try {
      // Mendapatkan response dari API
      final response = await DioClient().get(
        Endpoints.notifications(
            AuthenticationRepository.instance.authUser!.uid),
      );

      // Memeriksa apakah response.data mengandung key "notifications"
      if (response.statusCode == 200) {
        return NotificationsModel.notificationsFromJson(response.data);
      }
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on TExceptions catch (e) {
      throw TExceptions(e.message);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      Logger().e(e);
      throw 'Something went wrong. Please try again later.';
    }
    throw 'Failed to fetch notifications.';
  }

  // Post notification
  Future<NotificationsModel> createNotification(
      NotificationsModel notification) async {
    try {
      final response = await DioClient().post(
        Endpoints.notifications(
            AuthenticationRepository.instance.authUser!.uid),
        data: notification.toJson(),
      );
      if (response.statusCode == 201) {
        return NotificationsModel.fromJson(response.data);
      }
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on TExceptions catch (e) {
      throw TExceptions(e.message);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      Logger().e(e);
      throw 'Something went wrong. Please try again later.';
    }
    throw 'Failed to create notification.';
  }

  Future<void> updateNotification(NotificationsModel notification) async {
    try {
      final response = await DioClient().patch(
        Endpoints.notifications(
            AuthenticationRepository.instance.authUser!.uid),
        data: notification.toJson(),
      );
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on TExceptions catch (e) {
      throw TExceptions(e.message);
    } on FormatException catch (_) {
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      Logger().e(e);
      throw 'Something went wrong. Please try again later.';
    }
    throw 'Failed to update notifications.';
  }

  Future<void> getNotificationById(String id) async {
    // Get notification by id from the server
  }

  Future<void> getUnreadNotifications() async {
    // Get unread notifications from the server
  }

  Future<void> markNotificationAsRead(String id) async {
    // Mark notification as read
  }

  Future<void> markAllNotificationsAsRead() async {
    // Mark all notifications as read
  }

  Future<void> deleteNotification(String id) async {
    // Delete notification
  }

  Future<void> deleteAllNotifications() async {
    // Delete all notifications
  }
}
