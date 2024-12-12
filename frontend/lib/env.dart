class Env {
  static const String baseUrl = bool.fromEnvironment('dart.vm.product')
      ? 'http://localhost:3000/api'
      : 'http://localhost:3000/api';

  static const String contentType = 'Content-Type';
  static const String applicationType = 'application/json';
  static const String accept = 'Accept';
  static const String applicationJson = 'application/json';
  static const Duration apiTimeOut = Duration(seconds: 100000);
}
