import 'dart:convert';

import 'package:denta_koas/src/features/personalization/model/fasilitator_profile.dart';
import 'package:denta_koas/src/features/personalization/model/koas_profile.dart';
import 'package:denta_koas/src/features/personalization/model/pasien_profile.dart';
import 'package:denta_koas/src/utils/formatters/formatter.dart';

class UserModel {
  final String? id;
  final String? givenName;
  final String? familyName;
  final String? name;
  final String? email;
  final DateTime? emailVerified;
  final String? password;
  final String? confirmPassword;
  final String? phone;
  final String? address;
  final String? image;
  final String? role;
  final KoasProfileModel? koasProfile;
  final PasienProfileModel? pasienProfile;
  final FasilitatorProfileModel? fasilitatorProfile;

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
    this.fasilitatorProfile,
  });

  // Helper to get the full name
  String get fullName => '$givenName $familyName';

  // Helper function to format the phone number
  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phone!);

  static List<String> nameParts(fullname) => fullname.split(' ');

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
    Map<String, dynamic> json = {
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
    };

    switch (role) {
      case 'Koas':
        json['koasProfile'] = koasProfile?.toJson();
        break;
      case 'Pasien':
        json['pasienProfile'] = pasienProfile?.toJson();
        break;
      case 'Fasilitator':
        json['fasilitatorProfile'] = fasilitatorProfile?.toJson();
        break;
      default:
        break;
    }

    return json;
  }

  Map<String, dynamic> toJsonAuth() {
    Map<String, dynamic> json = {
      'id': id,
      'givenName': givenName,
      'familyName': familyName,
      'email': email,
      'phone': phone,
      'image': image,
      'role': role,
    };

    // switch (role) {
    //   case 'Koas':
    //     json['koasProfile'] = koasProfile?.toJson();
    //     break;
    //   case 'Pasien':
    //     json['pasienProfile'] = pasienProfile?.toJson();
    //     break;
    //   case 'Fasilitator':
    //     json['fasilitatorProfile'] = fasilitatorProfile?.toJson();
    //     break;
    //   default:
    //     break;
    // }

    return json;
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    // Navigate directly to the 'user' object in the 'data' field
    // final jsonFinal = json['data']?['user'] ;

    // if (jsonFinal == null) {
    //   throw ArgumentError(
    //       'User data is missing'); // Handle cases where 'user' is not found
    // }

    return UserModel(
      id: json['id'],
      givenName: json['givenName'] ?? '', // Default to empty string if null
      familyName: json['familyName'] ?? '',
      email: json['email'] ?? '',
      emailVerified:
          json['emailVerified'] != null && json['emailVerified'] is String
              ? DateTime.tryParse(
                  json['emailVerified']) // Safely parse only if it's a string
              : null,
      password: json['password'] ?? '',
      confirmPassword: json['confirmPassword'] ?? '',
      phone: json['phone'] ?? '',
      image: json['image'] ?? '',
      role: json['role'] ?? '',
      koasProfile: json['KoasProfile'] != null
          ? KoasProfileModel.fromJson(json['KoasProfile'])
          : KoasProfileModel.empty(),
      pasienProfile: json['PasienProfile'] != null
          ? PasienProfileModel.fromJson(json['PasienProfile'])
          : PasienProfileModel.empty(),
      fasilitatorProfile: json['FasilitatorProfile'] != null
          ? FasilitatorProfileModel.fromJson(json['FasilitatorProfile'])
          : FasilitatorProfileModel.empty(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'givenName': givenName,
      'familyName': familyName,
      'email': email,
      'emailVerified': emailVerified,
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

Map<String, dynamic> filterProfileByRole(Map<String, dynamic> data) {
  String role = data['role'] ?? '';
  Map<String, dynamic>? filteredProfile;

  switch (role) {
    case 'Fasilitator':
      filteredProfile = {
        'fasilitatorProfile': data['fasilitatorProfile'] != null
            ? jsonDecode(data['fasilitatorProfile'])
            : null,
      };
      break;
    case 'Koas':
      filteredProfile = {
        'koasProfile': data['koasProfile'],
      };
      break;
    case 'Pasien':
      filteredProfile = {
        'pasienProfile': data['pasienProfile'],
      };
      break;
    default:
      filteredProfile = {
        'message': 'No profile available for this role',
      };
  }

  return {
    'id': data['id'],
    'email': data['email'],
    'password': data['password'],
    'role': role,
    ...filteredProfile, // Spread the filtered profile into the result
  };
}
