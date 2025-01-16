import 'package:denta_koas/src/cores/data/repositories/university.repository/universities_repository.dart';
import 'package:denta_koas/src/features/appointment/screen/universities/data/model/university_model.dart';
import 'package:get/get.dart';

class UniversityController extends GetxController {
  static UniversityController get instance => Get.find();

  RxList<UniversityModel> universities = <UniversityModel>[].obs;
  RxList<UniversityModel> featuredUniversities = <UniversityModel>[].obs;

  RxList<UniversityModel> newestUniversities = <UniversityModel>[].obs;
  RxList<UniversityModel> popularUniversities = <UniversityModel>[].obs;

  final universitiesRepository = Get.put(UniversitiesRepository());

  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUniversities();
  }

  Future<void> fetchUniversities() async {
    try {
      isLoading.value = true;
      final fetchedUniversities =
          await universitiesRepository.getUniversities();
      universities.assignAll(fetchedUniversities);

      featuredUniversities.assignAll(
        fetchedUniversities.where((university) => true).toList(),
      );

      newestUniversities.assignAll(fetchedUniversities
          .where((university) => university.createdAt != null)
          .toList()
        ..sort((a, b) => b.createdAt!.compareTo(a.createdAt!))
        ..take(3));

      popularUniversities.assignAll(fetchedUniversities
          .where((university) => university.koasCount != 0)
          .toList()
        ..sort((a, b) => b.koasCount.compareTo(a.koasCount))
        ..take(3));
    } catch (e) {
      print(e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
