import 'package:denta_koas/src/cores/data/repositories/user.repository/user_repository.dart';
import 'package:denta_koas/src/features/personalization/model/user_model.dart';
import 'package:denta_koas/src/utils/popups/loaders.dart';
import 'package:get/get.dart';

class KoasController extends GetxController {
  static KoasController get instance => Get.find();

  RxList<UserModel> allKoas = <UserModel>[].obs;

  final RxList<UserModel> featuredKoas = <UserModel>[].obs;

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    initializeKoas();
  }

  Future<void> initializeKoas() async {
    try {
      isLoading.value = true;
      final fetchedKoas =
          await UserRepository.instance.fetchUsersByRole('Koas');
      allKoas.assignAll(fetchedKoas);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
