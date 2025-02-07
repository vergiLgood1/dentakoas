import 'package:denta_koas/src/cores/data/repositories/user.repository/user_repository.dart';
import 'package:denta_koas/src/features/personalization/model/koas_profile.dart';
import 'package:denta_koas/src/features/personalization/model/user_model.dart';
import 'package:denta_koas/src/utils/popups/loaders.dart';
import 'package:get/get.dart';

class KoasController extends GetxController {
  static KoasController get instance => Get.find();

  RxList<UserModel> allKoas = <UserModel>[].obs;
  RxList<UserModel> koas = <UserModel>[].obs;
  // RxList<UserModel> featuredKoas = <UserModel>[].obs;
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

      // Filter koas dengan status "Approved"
      final approvedKoas = fetchedKoas
          .where((koas) => koas.koasProfile?.status == StatusKoas.Approved.name)
          .toList();

      // Assign ke berbagai list
      allKoas.assignAll(approvedKoas);
      koas.assignAll(approvedKoas);

      // Popular koas berdasarkan rating dan jumlah review
      popularKoas.assignAll(
        (List.of(approvedKoas)
              ..sort((a, b) {
                final aStats = a.koasProfile?.stats;
                final bStats = b.koasProfile?.stats;

                if (aStats == null || bStats == null) return 0;

                int compareRating =
                    bStats.averageRating.compareTo(aStats.averageRating);
                if (compareRating != 0) {
                  return compareRating;
                } else {
                  return bStats.totalReviews.compareTo(aStats.totalReviews);
                }
              }))
            .where((koas) => koas.koasProfile?.stats?.totalReviews != null)
            .take(5)
            .toList(),
      );

      // Newest koas berdasarkan update terbaru
      newestKoas.assignAll(
        (List.of(approvedKoas)
              ..sort((a, b) {
                final aUpdate = a.updateAt;
                final bUpdate = b.updateAt;

                if (aUpdate == null || bUpdate == null) return 0;
                return bUpdate.compareTo(aUpdate);
              }))
            .where((koas) => koas.updateAt != null)
            .take(5)
            .toList(),
      );
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }

}
