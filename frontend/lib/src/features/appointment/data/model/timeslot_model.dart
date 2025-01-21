import 'package:denta_koas/src/features/appointment/data/model/appointments_model.dart';
import 'package:denta_koas/src/features/appointment/data/model/schedules_model.dart';

class TimeslotModel {
  String? id;
  String? scheduleId;
  String? startTime;
  String? endTime;
  int? maxParticipants;
  int? currentParticipants;
  bool? isAvailable;
  SchedulesModel? schedule;
  List<AppointmentsModel>? appointment;

  TimeslotModel({
    this.id,
    this.scheduleId,
    this.startTime,
    this.endTime,
    this.maxParticipants,
    this.currentParticipants,
    this.isAvailable,
    this.schedule,
    this.appointment,
  });

  factory TimeslotModel.fromJson(Map<String, dynamic> json) {
    return TimeslotModel(
      id: json['id'],
      scheduleId: json['scheduleId'],
      startTime: json['startTime'],
      endTime: json['endTime'],
      maxParticipants: json['maxParticipants'],
      currentParticipants: json['currentParticipants'],
      isAvailable: json['isAvailable'],
      schedule: SchedulesModel.fromJson(json['Schedule']),
      appointment: (json['Appointment'] as List)
          .map((e) => AppointmentsModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'scheduleId': scheduleId,
      'startTime': startTime,
      'endTime': endTime,
      'maxParticipants': maxParticipants,
      'currentParticipants': currentParticipants,
      'isAvailable': isAvailable,
      'Schedule': schedule?.toJson(),
      'Appointment': appointment?.map((e) => e.toJson()).toList(),
    };
  }

  static TimeslotModel empty() {
    return TimeslotModel(
      id: '',
      scheduleId: '',
      startTime: '',
      endTime: '',
      maxParticipants: null,
      currentParticipants: 0,
      isAvailable: true,
      schedule: SchedulesModel.empty(),
      appointment: [],
    );
  }

  static List<TimeslotModel> timeslotsFromJson(dynamic data) {
    // Pastikan data adalah Map dan memiliki key "timeslots".
    if (data is Map<String, dynamic> && data.containsKey("timeslots")) {
      final timeslots = data["timeslots"] as List;
      return timeslots.map((item) => TimeslotModel.fromJson(item)).toList();
    }
    throw Exception('Invalid data format for timeslots');
  }
}
