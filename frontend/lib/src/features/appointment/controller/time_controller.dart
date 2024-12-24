import 'package:get/get.dart';

class TimeController extends GetxController {
  static TimeController get instance => Get.find();

  final selectedTimeStamp = (-1).obs;

  void updateSelectedTimeStamp(int index) {
    selectedTimeStamp.value = index;
  }
}
