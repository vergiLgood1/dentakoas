import 'dart:convert';

class FasilitatorProfileModel {
  final String university;
  final DateTime? createdAt;

  FasilitatorProfileModel({
    required this.university,
    this.createdAt,
  });

  FasilitatorProfileModel copyWith({
    String? university,
  }) {
    return FasilitatorProfileModel(
      university: university ?? this.university,
    );
  }

  static FasilitatorProfileModel empty() {
    return FasilitatorProfileModel(
      university: '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'university': university,
    };
  }

  factory FasilitatorProfileModel.fromJson(Map<String, dynamic> json) {
    return FasilitatorProfileModel(
      university: json['university'] ?? '',
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'FasilitatorProfileModel(university: $university)';
}
