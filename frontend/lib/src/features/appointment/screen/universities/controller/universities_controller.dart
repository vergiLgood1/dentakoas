// import 'package:denta_koas/src/cores/data/repositories/university.repository/universities_repository.dart';
// import 'package:denta_koas/src/features/appointment/screen/universities/data/model/university_model.dart';
// import 'package:flutter/widgets.dart';
// import 'package:get/get.dart';

// class UniversitiesController extends GetxController {
//   static UniversitiesController get instance => Get.find();

//   final university = TextEditingController();
//   final universitiesRepository = Get.put(UniversitiesRepository());
//   final universitiesData = <String>[].obs;
//   RxList<UniversityModel> universities = <UniversityModel>[].obs;


//   @override
//   void onInit() {
//     super.onInit();
//     getUniversities();
//   }

//   void getUniversities() async {
//     try {
//       final fetchedUniversities =
//           await universitiesRepository.getUniversities();

//       universities.assignAll([fetchedUniversities]);
//     } catch (e) {
//       print('Error: $e');
//     }
//   }
// }
