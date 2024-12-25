import 'package:get/get.dart';

class PatientRequirementsController extends GetxController {
  // Objek observable untuk menyimpan hasil requirements
  var requirements = <String>[].obs;

  // Fungsi untuk memproses data menjadi pola panjang-pendek
  void sortRequirments(List<String> inputRequirements) {
    // Sort data berdasarkan panjang karakter
    List<String> sorted = List.from(inputRequirements);
    sorted.sort((a, b) => a.length.compareTo(b.length));

    // Pisahkan menjadi grup panjang dan pendek
    List<String> long = sorted.where((item) => item.length > 10).toList();
    List<String> short = sorted.where((item) => item.length <= 10).toList();

    // Gabungkan dalam pola panjang-pendek
    List<String> patternedList = [];
    int i = 0;
    while (i < long.length || i < short.length) {
      if (i < long.length) patternedList.add(long[i]);
      if (i < short.length) patternedList.add(short[i]);
      i++;
    }

    // Update nilai requirements
    requirements.value = patternedList;
  }
}
