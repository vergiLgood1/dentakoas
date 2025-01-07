import 'package:denta_koas/src/features/appointment/data/model/appointments_model.dart';
import 'package:denta_koas/src/features/appointment/data/model/post_model.dart';
import 'package:denta_koas/src/features/appointment/data/model/timeslot_model.dart';

class SchedulesModel {
  String? id;
  String? postId;
  DateTime? dateStart;
  DateTime? dateEnd;
  String? createdAt;
  String? updateAt;
  PostModel? post;
  List<TimeslotModel>? timeslot;
  List<Appointment>? appointment;

  SchedulesModel({
    this.id,
    this.postId,
    this.dateStart,
    this.dateEnd,
    this.createdAt,
    this.updateAt,
    this.post,
    this.timeslot,
    this.appointment,
  });

  factory SchedulesModel.fromJson(Map<String, dynamic> json) {
    return SchedulesModel(
      id: json['id'],
      postId: json['postId'],
      dateStart: json['dateStart'],
      dateEnd: json['dateEnd'],
      createdAt: json['createdAt'],
      updateAt: json['updateAt'],
      post: PostModel.fromJson(json['Post']),
      timeslot: (json['timeslots'] as List)
          .map((e) => TimeslotModel.fromJson(e))
          .toList(),
      appointment: (json['Appointment'] as List)
          .map((e) => Appointment.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'postId': postId,
      'dateStart': dateStart,
      'dateEnd': dateEnd,
      'createdAt': createdAt,
      'updateAt': updateAt,
      'Post': post?.toJson(),
      'timeslots': timeslot?.map((e) => e.toJson()).toList(),
      'Appointment': appointment?.map((e) => e.toJson()).toList(),
    };
  }

  static SchedulesModel empty() {
    return SchedulesModel(
      id: '',
      postId: '',
      dateStart: null,
      dateEnd: null,
      createdAt: '',
      updateAt: '',
      post: PostModel.empty(),
      timeslot: [],
      appointment: [],
    );
  }

  static List<SchedulesModel> schedulesFromJson(dynamic data) {
    // Pastikan data adalah Map dan memiliki key "schedules".
    if (data is Map<String, dynamic> && data.containsKey("schedule")) {
      final schedules = data["schedule"] as List;
      return schedules.map((item) => SchedulesModel.fromJson(item)).toList();
    }
    throw Exception('Invalid data format for schedules');
  }
}
