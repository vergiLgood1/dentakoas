import 'package:denta_koas/src/cores/data/repositories/user.repository/user_repository.dart';
import 'package:denta_koas/src/features/personalization/model/user_model.dart';
import 'package:denta_koas/src/utils/popups/loaders.dart';
import 'package:get/get.dart';

class KoasController extends GetxController {
  static KoasController get instance => Get.find();

  RxList<UserModel> allKoas = <UserModel>[].obs;
  RxList<UserModel> koas = <UserModel>[].obs;
  RxList<UserModel> featuredKoas = <UserModel>[].obs;
  RxList<UserModel> popularKoas = <UserModel>[].obs;
  RxList<UserModel> newestKoas = <UserModel>[].obs;



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
      koas.assignAll(fetchedKoas);

      // filter
      featuredKoas.assignAll(
        fetchedKoas.where((koas) => koas.id != null).toList(),
      );

      popularKoas.assignAll(
        fetchedKoas
            .where((koas) => koas.koasProfile!.stats!.totalReviews > 0)
            .toList()
          ..sort(
            (a, b) {
              int compareRating = b.koasProfile!.stats!.averageRating
                  .compareTo(a.koasProfile!.stats!.averageRating);
              if (compareRating != 0) {
                return compareRating;
              } else {
                return b.koasProfile!.stats!.totalReviews
                    .compareTo(a.koasProfile!.stats!.totalReviews);
              }
            },
          ),
      );

      newestKoas.assignAll(
          fetchedKoas.where((koas) => koas.updateAt != null).toList()
            ..sort((a, b) => b.updateAt!.compareTo(a.updateAt!)));
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
