class SignupReqParams  {
  final String givenName;
  final String familyName;
  final String email;
  final String password;
  final String confirmPassword;

  SignupReqParams({
    required this.givenName,
    required this.familyName,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  Map<String, dynamic> toMap() {
    return {
      'givenName': givenName,
      'familyName': familyName,
      'email': email,
      'password': password,
      'confirmPassword': confirmPassword,
      
    };
  }
}
