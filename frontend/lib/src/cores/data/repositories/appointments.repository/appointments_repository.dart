import 'package:denta_koas/src/cores/data/repositories/authentication.repository/authentication_repository.dart';
import 'package:denta_koas/src/features/appointment/data/model/appointments_model.dart';
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

class AppointmentsRepository extends GetxController {
  static AppointmentsRepository get instance => Get.find();

Future<List<AppointmentsModel>> getAppointments() async {
    try {
      final response = await DioClient().get(Endpoints.appointments);

      // Periksa status code respons
      // if (response.statusCode == 200) {
      //   final data = response.data;

      //   // Pastikan respons adalah Map dan memiliki key 'appointments'
      //   if (data is Map<String, dynamic> && data.containsKey('appointments')) {
      //     final appointments = data['appointments'];

      //     // Pastikan 'appointments' adalah List
      //     if (appointments is List) {
      //       return AppointmentsModel.appointmentsFromJson(appointments);
      //     } else {
      //       throw const FormatException(
      //           'Invalid "appointments" format: not a List.');
      //     }
      //   } else {
      //     throw const FormatException(
      //         'Key "appointments" not found in response.');
      //   }
      // } else {
      //   throw Exception('Failed to fetch data: ${response.statusCode}');
      // }

      if (response.statusCode == 200) {
        // Ambil array appointments dari data
        final data = response.data as Map<String, dynamic>? ?? {};
        final appointments = data['appointments'] as List<dynamic>? ?? [];
        return appointments
            .map((json) =>
                AppointmentsModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
    } catch (e) {
      // Tangani berbagai error
      Logger().e('Error fetching appointments: $e');
      rethrow;
    }
}

Future<List<AppointmentsModel>> getAppointmentByUser() async {
    try {
      final response =
          await DioClient().get(Endpoints.appointmentWithSpecificUser(
        AuthenticationRepository.instance.authUser!.uid,
      ));

      // Pastikan respons memiliki kode status 200 dan data yang valid
      if (response.statusCode == 200) {
        // Ambil array appointments dari data
        final data = response.data as Map<String, dynamic>? ?? {};
        final appointments = data['appointments'] as List<dynamic>? ?? [];
        return appointments
            .map((json) =>
                AppointmentsModel.fromJson(json as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Failed to fetch data: ${response.statusCode}');
      }
 
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    } on FirebaseException catch (e) {
      throw TFirebaseException(e.code).message;
    } on TExceptions catch (e) {
      throw TExceptions(e.message);
    } on FormatException catch (e) {
      Logger().e('FormatException: ${e.message}');
      throw const TFormatException();
    } on PlatformException catch (e) {
      throw TPlatformException(e.code).message;
    } catch (e) {
      Logger().e('Error fetching appointments: $e');
      throw 'Something went wrong. Please try again later.';
    }
}


  Future<AppointmentsModel> createAppointment(
      AppointmentsModel appointment) async {
    try {
      final response = await DioClient().post(
        Endpoints.appointments,
        data: appointment.toJson(),
      );

      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 201) {
        return AppointmentsModel.fromJson(response.data);
      } else {
        throw 'Failed to create appointment.';
      }
    } catch (e) {
      print('Error during appointment creation: $e');
      rethrow;
    }
  }

  Future<AppointmentsModel> updateAppointment(
    String appointmentId,
    AppointmentsModel appointment,
  ) async {
    try {
      final response = await DioClient().patch(
        Endpoints.appointment(appointmentId),
        data: appointment.toJson(),
      );

      if (response.statusCode == 200) {
        return AppointmentsModel.fromJson(response.data);
      } else {
        throw 'Failed to update appointment.';
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
      Logger().e(['Error updating appointment: $e']);
      throw 'Something went wrong. Please try again later.';
    }
  }

  Future<void> deleteAppointment(String appointmentId) async {
    try {
      final response = await DioClient().delete(
        Endpoints.appointments,
        queryParameters: {'id': appointmentId},
      );

      if (response.statusCode == 200) {
        return;
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
      Logger().e(['Error deleting appointment: $e']);
      throw 'Something went wrong. Please try again later.';
    }
    throw 'Failed to delete appointment.';
  }
}
