import 'package:denta_koas/src/utils/formatters/formatter.dart';

class UserModel {
  String? id;
  String? givenName;
  String? familyName;
  String? name;
  String? email;
  DateTime? emailVerified;
  String? password;
  String? confirmPassword;
  String? phone;
  String? address;
  String? image;
  String? role;
  KoasProfileModel? koasProfile;
  PasienProfileModel? pasienProfile;

  DateTime? createdAt;
  DateTime? updatedAt;

  UserModel({
    this.id,
    this.givenName,
    this.familyName,
    this.name,
    this.email,
    this.emailVerified,
    this.password,
    this.confirmPassword,
    this.phone,
    this.address,
    this.image,
    this.role,
    this.koasProfile,
    this.pasienProfile,
  });

  // Helper to get the full name
  String get fullName => '$givenName $familyName';

  // Helper function to format the phone number
  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phone!);

  static List<String> nameParts(fullname) => fullname.split(' ');

  bool hasNullFieldsInProfiles() {
    // Check if any field in KoasProfile is null
    final hasNullInKoasProfile =
        koasProfile!.toJson().values.any((value) => value == null);

    // Check if any field in PasienProfile is null
    final hasNullInPasienProfile =
        pasienProfile!.toJson().values.any((value) => value == null);

    return hasNullInKoasProfile || hasNullInPasienProfile;
  }

  // Static function to create an empty user model
  static UserModel empty() {
    return UserModel(
      id: '',
      givenName: '',
      familyName: '',
      email: '',
      password: '',
      confirmPassword: '',
      phone: '',
      address: '',
      image: '',
      role: '',
      koasProfile: KoasProfileModel.empty(),
      pasienProfile: PasienProfileModel.empty(),
    );
  }

  // Convert model to JSON structure for storing data in database
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'givenName': givenName,
      'familyName': familyName,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'phone': phone,
      'address': address,
      'image': image,
      'role': role,
      'koasProfile': koasProfile?.toJson(),
      'pasienProfile': pasienProfile?.toJson(),
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    // Navigate directly to the 'user' object in the 'data' field
    final userJson = json['data']?['user'];

    if (userJson == null) {
      throw ArgumentError(
          'User data is missing'); // Handle cases where 'user' is not found
    }

    return UserModel(
      id: userJson['id'],
      givenName: userJson['givenName'] ?? '', // Default to empty string if null
      familyName: userJson['familyName'] ?? '',
      email: userJson['email'] ?? '',
      emailVerified: userJson['emailVerified'] != null
          ? DateTime.tryParse(userJson['emailVerified']) // Safely parse date
          : null,
      password: userJson['password'] ?? '',
      confirmPassword: userJson['confirmPassword'] ?? '',
      phone: userJson['phone'] ?? '',
      image: userJson['image'] ?? '',
      role: userJson['role'] ?? '',
      koasProfile: userJson['KoasProfile'] != null
          ? KoasProfileModel.fromJson(userJson['KoasProfile'])
          : KoasProfileModel.empty(),
      pasienProfile: userJson['PasienProfile'] != null
          ? PasienProfileModel.fromJson(userJson['PasienProfile'])
          : PasienProfileModel.empty(),
    );
  }
}

// class StatusKoas {
//   static const String rejected = 'Rejected';
//   static const String pending = 'Pending';
//   static const String approved = 'Approved';

//   final String value;

//   const StatusKoas._(this.value);

//   static const List<StatusKoas> values = [
//     StatusKoas._(rejected),
//     StatusKoas._(pending),
//     StatusKoas._(approved),
//   ];

//   static StatusKoas fromString(String status) {
//     return values.firstWhere((element) => element.value == status,
//         orElse: () => throw Exception('Invalid status'));
//   }
// }

class KoasProfileModel {
  final String koasNumber;
  final String age;
  final String gender;
  final String departement;
  final String university;
  final String? bio;
  final String? whatsappLink;
  final String status;

  KoasProfileModel({
    required this.koasNumber,
    required this.age,
    required this.gender,
    required this.departement,
    required this.university,
    this.bio,
    this.whatsappLink,
    this.status = 'Pending',
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
      'status': status,
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
      status: json['status'],
    );
  }
}

class PasienProfileModel {
  final String age;
  final String gender;
  final String? bio;

  PasienProfileModel({
    required this.age,
    required this.gender,
    this.bio,
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
      bio: json['bio'],
    );
  }
}
