import 'package:denta_koas/src/features/personalization/model/user_model.dart';

class PasienProfileModel {
  final String? id;
  final String? age;
  final String? gender;
  final String? bio;
  final String userId;
  final UserModel? user;
  final DateTime? createdAt;

  PasienProfileModel({
    this.id,
    this.age,
    this.gender,
    this.bio,
    this.userId = '',
    this.user,
    this.createdAt,
  });

  // Static function to create an empty user model
  static PasienProfileModel empty() {
    return PasienProfileModel(
      age: '',
      gender: '',
      bio: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'age': age,
      'gender': gender,
      'bio': bio,
    };
  }

  factory PasienProfileModel.fromJson(Map<String, dynamic> json) {
    return PasienProfileModel(
      id: json['id'] ?? '',
      age: json['age'] ?? '',
      gender: json['gender'] ?? '',
      bio: json['bio'] ?? '',
      user: json['user'] != null
          ? UserModel.fromJson(json['user'])
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
    );
  }
}
