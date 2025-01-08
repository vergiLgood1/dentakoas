import 'package:denta_koas/src/features/appointment/data/model/likes_model.dart';
import 'package:denta_koas/src/features/appointment/data/model/review-model.dart';
import 'package:denta_koas/src/features/appointment/data/model/schedules_model.dart';
import 'package:denta_koas/src/features/appointment/data/model/treatment.dart';
import 'package:denta_koas/src/features/personalization/model/koas_profile.dart';
import 'package:denta_koas/src/features/personalization/model/user_model.dart';

class PostModel {
  String? id;
  String? userId;
  UserModel? user;
  String? koasId;
  KoasProfileModel? koasProfile;
  String? treatmentId;
  TreatmentModel? treatment;
  String? title;
  String? desc;
  dynamic patientRequirement; // json type can be dynamic
  int? requiredParticipant;
  StatusPost? status;
  bool? published;
  List<SchedulesModel>? schedule;
  
  List<Review>? review;
  List<Like>? likes;
  DateTime? createdAt;
  DateTime? updatedAt;

  PostModel({
    this.id,
    this.userId,
    this.koasId,
    this.user,
    this.koasProfile,
    this.treatmentId,
    this.treatment,
    this.title,
    this.desc,
    this.patientRequirement,
    this.requiredParticipant = 0,
    this.status = StatusPost.Pending,
    this.published = false,
    this.schedule,
    this.review,
    this.likes,
    this.createdAt,
    this.updatedAt,
  });

  factory PostModel.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw Exception('Invalid JSON data');
    }
    return PostModel(
      id: json['id'],
      userId: json['userId'],
      koasId: json['koasId'],
      treatmentId: json['treatmentId'],
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null, 
      koasProfile: json['koas'] != null ? KoasProfileModel.fromJson(json['koas']) : null,
      treatment: json['treatment'] != null
          ? TreatmentModel.fromJson(json['treatment'])
          : null,
      title: json['title'],
      desc: json['desc'],
      patientRequirement: List<String>.from(json['patientRequirement']),
      requiredParticipant: json['requiredParticipant'],
      status: json['status'] == 'Pending'
          ? StatusPost.Pending
          : json['status'] == 'Open'
              ? StatusPost.Open
              : StatusPost.Closed,
      published: json['published'],
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      updatedAt:
          json['updateAt'] != null ? DateTime.tryParse(json['updateAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'koasId': koasId,
      'treatmentId': treatmentId,
      'title': title,
      'desc': desc,
      'patientRequirement': patientRequirement,
      'requiredParticipant': requiredParticipant,
      'status': status.toString().split('.').last,
      'published': published,
      'Schedule': schedule?.map((e) => e.toJson()).toList(),
      'Review': review?.map((e) => e.toJson()).toList(),
      'likes': likes?.map((e) => e.toJson()).toList(),
      'createdAt': createdAt?.toIso8601String(),
      'updateAt': updatedAt?.toIso8601String(),
    };
  }

  static PostModel empty() {
    return PostModel(
      id: '',
      userId: '',
      koasId: '',
      treatmentId: '',
      treatment: TreatmentModel.empty(),
      title: '',
      desc: '',
      schedule: [],
      review: [],
      likes: [],
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  static List<PostModel> postsFromJson(dynamic data) {
    if (data == null) {
      throw Exception('Data is null');
    }
    // Pastikan data adalah Map dan memiliki key "posts".
    if (data is Map<String, dynamic> && data.containsKey("posts")) {
      final posts = data["posts"] as List;
      return posts.map((item) => PostModel.fromJson(item)).toList();
    }
    throw Exception('Invalid data format for posts');
  }
}

enum StatusPost { Pending, Open, Closed }
