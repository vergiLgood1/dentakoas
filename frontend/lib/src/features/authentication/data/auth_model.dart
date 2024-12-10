import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:flutter/material.dart';
import 'package:tugas_akhir/src/features/authentication/presentation/pages/login.dart';

class AccountModel {
  final String id;
  final String userId;
  final String type;
  final String provider;
  final String providerAccountId;
  final String tokenType;
  final String refreshToken;
  final String accessToken;
  final String expiresAt;
  final String scope;
  final String idToken;
  final String createdAt;
  final String updatedAt;

  AccountModel({
    required this.id,
    required this.userId,
    required this.type,
    required this.provider,
    required this.providerAccountId,
    required this.tokenType,
    required this.refreshToken,
    required this.accessToken,
    required this.expiresAt,
    required this.scope,
    required this.idToken,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      id: json['id'],
      userId: json['userId'],
      type: json['type'],
      provider: json['provider'],
      providerAccountId: json['providerAccountId'],
      tokenType: json['tokenType'],
      refreshToken: json['refreshToken'],
      accessToken: json['accessToken'],
      expiresAt: json['expiresAt'],
      scope: json['scope'],
      idToken: json['idToken'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}

class SessionModel {
  final String id;
  final String userId;
  final String sessionToken;
  final String accessToken;
  final String expires;
  final String createdAt;
  final String updatedAt;

  SessionModel({
    required this.id,
    required this.userId,
    required this.sessionToken,
    required this.accessToken,
    required this.expires,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
        id: json['id'],
        userId: json['userId'],
        sessionToken: json['sessionToken'],
        accessToken: json['accessToken'],
        expires: json['expires'],
        createdAt: json['createdAt'],
        updatedAt: json['updateAt']);
  }
}

class UserModel {
  final String id;
  final String givenName;
  final String familyName;
  final String name;
  final String email;
  final String password;
  final String token;

  UserModel({
    required this.id,
    required this.givenName,
    required this.familyName,
    required this.name,
    required this.email,
    required this.password,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      givenName: json['givenName'],
      familyName: json['familyName'],
      name: json['name'],
      email: json['email'],
      password: json['password'],
      token: json['token'],
    );
  }
}

class LoginModel extends FlutterFlowModel<LoginPage> {
  ///  State fields for stateful widgets in this page.

  final formKey = GlobalKey<FormState>();
  // State field(s) for EmailAddressField widget.
  FocusNode? emailAddressFieldFocusNode;
  TextEditingController? emailAddressFieldTextController;
  String? Function(BuildContext, String?)?
      emailAddressFieldTextControllerValidator;
  String? _emailAddressFieldTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Email is required.';
    }

    if (!RegExp(kTextValidatorEmailRegex).hasMatch(val)) {
      return 'Has to be a valid email address.';
    }
    return null;
  }

  // State field(s) for PasswordField widget.
  FocusNode? passwordFieldFocusNode;
  TextEditingController? passwordFieldTextController;
  late bool passwordFieldVisibility;
  String? Function(BuildContext, String?)? passwordFieldTextControllerValidator;
  String? _passwordFieldTextControllerValidator(
      BuildContext context, String? val) {
    if (val == null || val.isEmpty) {
      return 'Password is required.';
    }

    return null;
  }

  @override
  void initState(BuildContext context) {
    emailAddressFieldTextControllerValidator =
        _emailAddressFieldTextControllerValidator;
    passwordFieldVisibility = false;
    passwordFieldTextControllerValidator =
        _passwordFieldTextControllerValidator;
  }

  @override
  void dispose() {
    emailAddressFieldFocusNode?.dispose();
    emailAddressFieldTextController?.dispose();

    passwordFieldFocusNode?.dispose();
    passwordFieldTextController?.dispose();
  }
}
