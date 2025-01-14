import 'package:denta_koas/src/cores/data/repositories/user.repository/user_repository.dart';
import 'package:denta_koas/src/features/personalization/model/user_model.dart';
import 'package:denta_koas/src/utils/popups/loaders.dart';
import 'package:get/get.dart';

class KoasController extends GetxController {
  static KoasController get instance => Get.find();

  RxList<UserModel> allKoas = <UserModel>[].obs;
  RxList<UserModel> koas = <UserModel>[].obs;
  RxList<UserModel> featuredKoas = <UserModel>[].obs;
  RxList<UserModel> topKoas = <UserModel>[].obs;
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

      topKoas.assignAll(
        fetchedKoas
            .where((koas) => koas.koasProfile!.totalReviews! > 0)
            .toList()
          ..sort(
            (a, b) {
              int compareRating = b.koasProfile!.averageRating!
                  .compareTo(a.koasProfile!.averageRating!);
              if (compareRating != 0) {
                return compareRating;
              } else {
                return b.koasProfile!.totalReviews!
                    .compareTo(a.koasProfile!.totalReviews!);
              }
            },
          ),
      );
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
