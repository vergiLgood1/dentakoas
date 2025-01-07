import 'package:denta_koas/src/cores/data/repositories/university.repository/universities_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class UniversitiesController extends GetxController {
  static UniversitiesController get instance => Get.find();

  final university = TextEditingController();
  final universitiesRepository = Get.put(UniversitiesRepository());
  final universitiesData = <String>[].obs;

  // @override
  // void onInit() {
  //   super.onInit();
  //   getUniversities();
  // }

  void getUniversities() async {
    try {
      await universitiesRepository.getUniversities();
    } catch (e) {
      print('Error: $e');
    }
  }
}
