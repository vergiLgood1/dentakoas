import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class RoleController extends GetxController {
  static RoleController get instance => Get.find();
  // Get role from the role screen

  final storage = GetStorage();
  final selectedIndexRole = 0.obs;
  final roleNames = ["Fasilitator", "Koas", "Pasien"];

  void selectRole(int index) {
    selectedIndexRole.value = index;
  }

  String get role => roleNames[selectedIndexRole.value];

  void setSelectedRole() {
    storage.write('SELECTED_ROLE', role);
  }
}
