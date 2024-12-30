import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController get instance => Get.find();

  // Variable untuk menyimpan index role yang dipilih
  var selectedIndex = 0.obs; // Default ke opsi kedua (For personal use)

  // Variable untuk menyimpan nama role berdasarkan pilihan
  final roleNames = ["Fasilitator", "Koas", "Pasien"];

  // Fungsi untuk mengubah pilihan
  void selectRole(int index) {
    selectedIndex.value = index;
  }

  // Fungsi untuk mendapatkan role yang dipilih
  String get selectedRoleName => roleNames[selectedIndex.value];
}
