import 'package:denta_koas/src/features/appointment/data/model/timeslot_model.dart';
import 'package:denta_koas/src/utils/constants/api_urls.dart';
import 'package:denta_koas/src/utils/dio.client/dio_client.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class TimeslotRepository extends GetxController {
  static TimeslotRepository get instance => Get.find();

  Future<List<TimeslotModel>> fetchTimeslots() async {
    try {
      final response = await DioClient().get(Endpoints.timeslots);

      if (response.statusCode == 200) {
        return TimeslotModel.timeslotsFromJson(response.data);
      }
    } catch (e) {
      Logger().e(e);
      throw e.toString();
    }
    throw 'Failed to fetch timeslots.';
  }

  Future<TimeslotModel> createTimeslot(TimeslotModel timeslot) async {
    try {
      final response =
          await DioClient().post(Endpoints.timeslots, data: timeslot.toJson());

      if (response.statusCode == 201) {
        return TimeslotModel.fromJson(response.data);
      }
    } catch (e) {
      Logger().e(e);
      throw e.toString();
    }
    throw 'Failed to create timeslot.';
  }

  Future<TimeslotModel> updateTimeslot(TimeslotModel timeslot) async {
    try {
      final response = await DioClient().put(
          '${Endpoints.timeslots}/${timeslot.id}',
          data: timeslot.toJson());

      if (response.statusCode == 200) {
        return TimeslotModel.fromJson(response.data);
      }
    } catch (e) {
      Logger().e(e);
      throw e.toString();
    }
    throw 'Failed to update timeslot.';
  }

  Future<void> deleteTimeslot(String id) async {
    try {
      final response = await DioClient().delete('${Endpoints.timeslots}/$id');

      if (response.statusCode == 200) {
        return;
      }
    } catch (e) {
      Logger().e(e);
      throw e.toString();
    }
    throw 'Failed to delete timeslot.';
  }
}
