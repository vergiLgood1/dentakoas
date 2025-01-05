class KoasProfileModel {
  final String? koasNumber;
  final String? age;
  final String? gender;
  final String? departement;
  final String? university;
  final String? bio;
  final String? whatsappLink;
  final Object? status;


  KoasProfileModel({
    this.koasNumber,
    this.age,
    this.gender,
    this.departement,
    this.university,
    this.bio,
    this.whatsappLink,
    this.status,

  });

  // Static function to create an empty user model
  static KoasProfileModel empty() {
    return KoasProfileModel(
      koasNumber: '',
      age: '',
      gender: '',
      departement: '',
      university: '',
      bio: '',
      whatsappLink: '',
      status: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'koasNumber': koasNumber,
      'age': age,
      'gender': gender,
      'departement': departement,
      'university': university,
      'bio': bio,
      'whatsappLink': whatsappLink,
      'status': status ?? 'Pending',
    };
  }

  factory KoasProfileModel.fromJson(Map<String, dynamic> json) {
    return KoasProfileModel(
      koasNumber: json['koasNumber'] ?? '',
      age: json['age'] ?? '',
      gender: json['gender'] ?? '',
      departement: json['departement'] ?? '',
      university: json['university'] ?? '',
      bio: json['bio'] ?? '',
      whatsappLink: json['whatsappLink'] ?? '',
      status: json['status'] ?? '',
    );
  }
}
