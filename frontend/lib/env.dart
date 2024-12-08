class Env {
  static const String baseUrl = bool.fromEnvironment('dart.vm.product')
      ? 'https://localhost:3000/api'
      : 'https://localhost:3000/api';
}
