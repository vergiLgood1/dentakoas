import 'package:denta_koas/src/features/appointment/data/model/tes.dart';
import 'package:denta_koas/src/features/personalization/model/user_model.dart';
import 'package:logger/logger.dart';

class AppointmentsModel {
  String? id;
  String? pasienId;
  String? koasId;
  String? scheduleId;
  String? timeslotId;
  String? date; // Tetap string jika tidak ingin mengubah ke DateTime
  StatusAppointment? status;
  UserModel? user;
  Post? post;
  Schedule? schedule;
  DateTime? createdAt;
  DateTime? updatedAt;

  AppointmentsModel({
    this.id,
    this.pasienId,
    this.koasId,
    this.scheduleId,
    this.timeslotId,
    this.date,
    this.status = StatusAppointment.Pending,
    this.user,
    this.post,
    this.schedule,
    this.createdAt,
    this.updatedAt,
  });

  factory AppointmentsModel.fromJson(Map<String, dynamic> json) {
    return AppointmentsModel(
      id: json['id'] ?? '',
      pasienId: json['pasienId'] ?? '',
      koasId: json['koasId'] ?? '',
      scheduleId: json['scheduleId'] ?? '',
      timeslotId: json['timeslotId'] ?? '',
      date: json['date'] ?? '',
      status: json['status'] != null
          ? StatusAppointment.values.firstWhere(
              (e) => e.toString().split('.').last == json['status'],
              orElse: () => StatusAppointment.Pending,
            )
          : StatusAppointment.Pending,
      user: json['user'] != null
          ? UserModel.fromJson(json['user'] as Map<String, dynamic>)
          : null,
      post: json['post'] != null
          ? Post.fromJson(json['post'] as Map<String, dynamic>)
          : null,
      schedule: json['schedule'] != null
          ? Schedule.fromJson(json['schedule'] as Map<String, dynamic>)
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pasienId': pasienId,
      'koasId': koasId,
      'scheduleId': scheduleId,
      'timeslotId': timeslotId,
      'date': date,
      'status': status?.toString().split('.').last,
 
    };
  }

  static AppointmentsModel empty() {
    return AppointmentsModel(
      id: '',
      pasienId: '',
      koasId: '',
      scheduleId: '',
      timeslotId: '',
      date: DateTime.now().toIso8601String(),
      status: StatusAppointment.Pending,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

static List<AppointmentsModel> appointmentsFromJson(dynamic data) {
    print('Received data: $data');
    try {
      
    if (data is Map<String, dynamic> && data.containsKey("appointments")) {
        final appointments = data["appointments"];
        var logger = Logger();
        logger.i('Appointments list: $appointments');
        if (appointments is List) {
      return appointments
          .map((item) => AppointmentsModel.fromJson(item))
          .toList();
        } else {
          throw Exception('Key "appointments" is not a List');
        }
      }
    } catch (e) {
      throw Exception(e);
    }
    throw Exception('Invalid data format for appointments' + data.toString());
  }
}

enum StatusAppointment {
  Canceled,
  Rejected,
  Pending,
  Confirmed,
  Ongoing,
  Completed
}
