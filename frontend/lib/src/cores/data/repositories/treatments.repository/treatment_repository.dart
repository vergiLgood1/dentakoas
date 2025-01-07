import 'package:denta_koas/src/features/appointment/data/model/treatment.dart';
import 'package:denta_koas/src/utils/constants/api_urls.dart';
import 'package:denta_koas/src/utils/dio.client/dio_client.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class TreatmentRepository extends GetxController {
  static TreatmentRepository get instance => Get.find();

  Future<List<TreatmentModel>> getAllTreatmentTypes() async {
    try {
      final response = await DioClient().get(Endpoints.treatments);

      if (response.statusCode == 200) {
        return TreatmentModel.treatmentsFromJson(response.data);
      }
    } catch (e) {
      Logger().e(e);
      throw e.toString();
      
    }
    throw 'Failed to fetch treatment types.';
  }
}
