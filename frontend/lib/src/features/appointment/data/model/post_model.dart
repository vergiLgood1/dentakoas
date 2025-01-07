import 'package:denta_koas/src/features/appointment/data/model/likes_model.dart';
import 'package:denta_koas/src/features/appointment/data/model/review-model.dart';
import 'package:denta_koas/src/features/appointment/data/model/schedules_model.dart';
import 'package:denta_koas/src/features/appointment/data/model/treatment.dart';

class PostModel {
  String? id;
  String? userId;
  String? koasId;
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

  factory PostModel.fromJson(Map<String, dynamic> json) {
    final post = json['post'] ?? {};
    return PostModel(
      id: post['id'],
      userId: post['userId'],
      koasId: post['koasId'],
      treatmentId: post['treatmentId'],
      treatment: post['treatment'],
      title: post['title'],
      desc: post['desc'],
      patientRequirement: post['patientRequirement'],
      requiredParticipant: post['requiredParticipant'] ?? 0,
      status: post['status'] == 'Pending'
          ? StatusPost.Pending
          : post['status'] == 'Open'
              ? StatusPost.Open
              : StatusPost.Closed,
      published: post['published'] ?? false,
      schedule: (post['Schedule'] as List?)
          ?.map((e) => SchedulesModel.fromJson(e))
          .toList(),
      review:
          (post['Review'] as List?)?.map((e) => Review.fromJson(e)).toList(),
      likes: (post['likes'] as List?)?.map((e) => Like.fromJson(e)).toList(),
      createdAt: DateTime.tryParse(post['createdAt'] ?? ''),
      updatedAt: DateTime.tryParse(post['updateAt'] ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
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
    // Pastikan data adalah Map dan memiliki key "posts".
    if (data is Map<String, dynamic> && data.containsKey("posts")) {
      final posts = data["posts"] as List;
      return posts.map((item) => PostModel.fromJson(item)).toList();
    }
    throw Exception('Invalid data format for posts');
  }
}

enum StatusPost { Pending, Open, Closed }
