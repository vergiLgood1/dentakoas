import 'package:denta_koas/src/cores/data/repositories/post.repository/post_repository.dart';
import 'package:denta_koas/src/cores/data/repositories/schedules.repository/shcedule_repository.dart';
import 'package:denta_koas/src/features/appointment/data/model/post_model.dart';
import 'package:denta_koas/src/features/appointment/data/model/schedules_model.dart';
import 'package:denta_koas/src/utils/popups/loaders.dart';
import 'package:get/get.dart';

class PostDetailController extends GetxController {
  static PostDetailController get instance => Get.find();

  Rx<PostModel> postDetail = PostModel.empty().obs;
  final isLoading = false.obs;

  Rx<SchedulesModel> schedule = SchedulesModel.empty().obs;

  @override
  void onInit() {
    super.onInit();
    fetchDetailPost(Get.arguments);
    fetchSpecificSchedule(Get.arguments);
  }

  fetchDetailPost(String postId) async {
    try {
      isLoading(true);
      final postData = await PostRepository.instance.getPostByPostId(postId);
      postDetail(postData);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Failed to fetch post');
    } finally {
      isLoading(false);
    }
  }

  fetchSpecificSchedule(String scheduleId) async {
    try {
      isLoading(true);
      final schedulesData =
          await SchedulesRepository.instance.getScheduleById(scheduleId);

      schedule(schedulesData);
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Failed to fetch schedule');
    } finally {
      isLoading(false);
    }
  }

  List<Map<String, dynamic>> getTimeslotList() {
    return schedule.value.timeslot!.map((timeslot) => {
      "id": timeslot.id,
      "startTime": timeslot.startTime,
      "endTime": timeslot.endTime,
      "maxParticipants": timeslot.maxParticipants,
      "currentParticipants": timeslot.currentParticipants,
      "isAvailable": timeslot.isAvailable,
    }).toList();
  }
}
