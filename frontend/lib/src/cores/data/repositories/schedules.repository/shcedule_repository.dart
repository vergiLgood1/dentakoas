import 'package:denta_koas/src/features/appointment/data/model/schedules_model.dart';
import 'package:denta_koas/src/utils/constants/api_urls.dart';
import 'package:denta_koas/src/utils/dio.client/dio_client.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

class SchedulesRepository extends GetxController {
  static SchedulesRepository get instance => Get.find();

  Future<List<SchedulesModel>> fetchSchedules() async {
    try {
      final response = await DioClient().get(Endpoints.schedules);

      if (response.statusCode == 200) {
        return SchedulesModel.schedulesFromJson(response.data);
      }
    } catch (e) {
      Logger().e(e);
      throw e.toString();
    }
    throw 'Failed to fetch schedules.';
  }

  Future<SchedulesModel> createSchedule(SchedulesModel schedule) async {
    try {
      final response =
          await DioClient().post(Endpoints.schedules, data: schedule.toJson());

      if (response.statusCode == 201) {
        return SchedulesModel.fromJson(response.data);
      }
    } catch (e) {
      Logger().e(e);
      throw e.toString();
    }
    throw 'Failed to create schedule.';
  }

  Future<SchedulesModel> updateSchedule(SchedulesModel schedule) async {
    try {
      final response = await DioClient().put(
          '${Endpoints.schedules}/${schedule.id}',
          data: schedule.toJson());

      if (response.statusCode == 200) {
        return SchedulesModel.fromJson(response.data);
      }
    } catch (e) {
      Logger().e(e);
      throw e.toString();
    }
    throw 'Failed to update schedule.';
  }

  Future<void> deleteSchedule(String id) async {
    try {
      final response = await DioClient().delete('${Endpoints.schedules}/$id');

      if (response.statusCode == 200) {
        return;
      }
    } catch (e) {
      Logger().e(e);
      throw e.toString();
    }
    throw 'Failed to delete schedule.';
  }
}
