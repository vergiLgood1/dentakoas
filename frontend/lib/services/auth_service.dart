import '../models/user_model.dart';

class AuthService {
  Future<User?> signIn(String email, String password) async {
    // Logika untuk sign in (bisa via API, Firebase, dll.)
    // Sementara return data dummy:
    return User(id: '1', name: 'John Doe', email: email, phone: '1234567890');
  }

  Future<bool> register(String name, String email, String phone, String password) async {
    // Logika untuk registrasi user (bisa via API, Firebase, dll.)
    return true;  // Return true jika sukses
  }
}
