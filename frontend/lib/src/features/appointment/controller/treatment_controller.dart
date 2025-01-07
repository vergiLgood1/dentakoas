import 'package:denta_koas/src/cores/data/repositories/treatments.repository/treatment_repository.dart';
import 'package:denta_koas/src/features/appointment/data/model/treatment.dart';
import 'package:denta_koas/src/utils/popups/loaders.dart';
import 'package:get/get.dart';

class TreatmentController extends GetxController {
  static TreatmentController get instance => Get.find();

  final treatmentRepository = Get.put(TreatmentRepository());
  final isLoading = false.obs;
  RxList<TreatmentModel> treatments = <TreatmentModel>[].obs;
  RxList<TreatmentModel> featuredTreatments = <TreatmentModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchTreatments();
  }

  Future<void> fetchTreatments() async {
    try {
      isLoading.value = true;
      final fetchedTreatments =
          await treatmentRepository.getAllTreatmentTypes();

      treatments.assignAll(fetchedTreatments);

      // filter
      featuredTreatments.assignAll(
        fetchedTreatments.where((treatment) => treatment.id != null).toList(),
      );
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Error', message: e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
