class SignupReqParams {
  final String givenName;
  final String familyName;
  final String email;
  final String password;

  SignupReqParams({
    required this.givenName,
    required this.familyName,
    required this.email,
    required this.password
});
}
