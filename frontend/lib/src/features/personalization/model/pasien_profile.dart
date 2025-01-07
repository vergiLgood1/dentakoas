class PasienProfileModel {
  final String? age;
  final String? gender;
  final String? bio;
  final String userId;
  final DateTime? createdAt;

  PasienProfileModel({
    this.age,
    this.gender,
    this.bio,
    this.userId = '',
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
      age: json['age'] ?? '',
      gender: json['gender'] ?? '',
      bio: json['bio'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
    );
  }
}
