import '../models/user_model.dart';
import '../services/auth_service.dart';

class AuthController {
  final AuthService _authService = AuthService();

  Future<User?> login(String email, String password) async {
    // Mengambil data user dari auth service
    final user = await _authService.signIn(email, password);
    return user;
  }

  Future<bool> register(String name, String email, String phone, String password) async {
    // Mendaftarkan user melalui auth service
    return await _authService.register(name, email, phone, password);
  }
}
