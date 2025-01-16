import 'package:denta_koas/src/features/appointment/screen/universities/data/model/university_model.dart';
import 'package:denta_koas/src/utils/constants/api_urls.dart';
import 'package:denta_koas/src/utils/dio.client/dio_client.dart';
import 'package:get/get.dart';

class UniversitiesRepository extends GetxController {
  static UniversitiesRepository get instance => Get.find();

  // Future<UniversityModel> getUniversities() async {
  //   try {
  //     final response = await DioClient().get(Endpoints.universities);

  //     if (response.statusCode == 200) {
  //       final data = response.data['data']['university']; // Perbaikan akses
  //       if (data is Map<String, dynamic>) {
  //         return UniversityModel.fromJson(data);
  //       }
  //     }
  //   } catch (e) {
  //     throw 'Something went wrong. Please try again later.';
  //   }
  //   throw 'Failed to fetch universities data.';
  // }


  Future<List<UniversityModel>> getUniversities() async {
    try {
      final response = await DioClient().get(Endpoints.universities);

      if (response.statusCode == 200) {
        return UniversityModel.universitiesFromJson(response.data);
      }
    } catch (e) {
      throw e.toString();
    }
    throw 'Failed to fetch treatment types.';
  }

  Future<UniversityModel> getUniversityById(String id) async {
    try {
      final response = await DioClient().get('${Endpoints.universities}/$id');

      if (response.statusCode == 200) {
        final data = response.data['data'];
        return UniversityModel.fromJson(data);
      }
    } catch (e) {
      throw 'Something went wrong. Please try again later.';
    }
    throw 'Failed to fetch university data.';
  }

  Future<List<String>> getUniversityNames() async {
    final response = await DioClient().get(Endpoints.universities);

    if (response.statusCode == 200) {
      final data = response.data;

      if (data['data'] == null || data['data']['university'] == null) {
        throw Exception('University data not found');
      }

      // Ambil hanya key 'name' dari setiap objek
      return (data['data']['university'] as List)
          .map((universityJson) =>
              (universityJson as Map<String, dynamic>)['name'] as String)
          .toList();
    } else {
      throw Exception('Failed to fetch universities');
    }
  }
}
