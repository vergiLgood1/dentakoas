import 'dart:convert';

class FasilitatorProfileModel {
  final String university;

  FasilitatorProfileModel({
    required this.university,
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
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'FasilitatorProfileModel(university: $university)';
}
