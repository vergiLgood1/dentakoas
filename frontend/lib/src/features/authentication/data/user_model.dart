import 'package:denta_koas/src/utils/formatters/formatter.dart';

class UserModel {
  final String? id;
  final String? givenName;
  final String? familyName;
  final String? email;
  final DateTime? emailVerified;
  final String? password;
  final String? confirmPassword;
  final String? phone;
  final String? image;
  final String? role;

  // Constructor for UserModel
  UserModel({
    this.id,
    this.givenName,
    this.familyName,
    this.email,
    this.emailVerified,
    this.password,
    this.confirmPassword,
    this.phone,
    this.role,
    this.image,
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
      role: '',
    );
  }

  // Convert model to JSON structure for storing data in database
  Map<String, dynamic> toJson() {
    return {
      'givenName': givenName,
      'familyName': familyName,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      'phone': phone,
      'image': image,
      'role': role,
    };
  }

  // Factory function to create a user model from a JSON structure
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      givenName: json['givenName'],
      familyName: json['familyName'],
      email: json['email'],
      emailVerified: json['emailVerified'],
      password: json['password'],
      confirmPassword: json['confirmPassword'],
      phone: json['phone'],
      role: json['role'],
    );
  }
}
