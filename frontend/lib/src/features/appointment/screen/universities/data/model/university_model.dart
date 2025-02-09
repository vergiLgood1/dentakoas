

class UniversityModel {
  final String id;
  final String name;
  final String alias;
  final String location;
  final String? image;
  final int koasCount;
  final String? createdAt;
  final String? updatedAt;

  UniversityModel({
    required this.id,
    required this.name,
    required this.alias,
    required this.location,
    this.image,
    this.koasCount = 0,
    this.createdAt,
    this.updatedAt,
  });

  static UniversityModel empty() {
    return UniversityModel(
      id: '',
      name: '',
      alias: '',
      location: '',
      image: '',
      koasCount: 0,
      createdAt: '',
      updatedAt: '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'alias': alias,
      'location': location,
      'image': image,
      'koasCount': koasCount,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }

  factory UniversityModel.fromJson(Map<String, dynamic> json) {
    final universityJson =
        json; // Langsung gunakan `json` karena setiap universitas adalah objek JSON.

    if (universityJson.isEmpty) {
      throw ArgumentError(
          'University data is missing'); // Error handling jika data kosong
    }

    return UniversityModel(
      id: universityJson['id'] ?? '',
      name: universityJson['name'] ?? '',
      alias: universityJson['alias'] ?? '',
      location: universityJson['location'] ?? '',
      image: universityJson['image'] ?? '',
      koasCount: universityJson['koasCount'] ?? 0,
      createdAt: universityJson['createdAt'] ?? '',
      updatedAt: universityJson['updatedAt'] ?? '',
    );
  }

  static List<UniversityModel> universitiesFromJson(dynamic data) {
    // Pastikan data adalah Map dan memiliki key "treatments".
    if (data is Map<String, dynamic> && data.containsKey("universities")) {
      final universities = data["universities"] as List;
      return universities
          .map((item) => UniversityModel.fromJson(item))
          .toList();
    }
    throw Exception('Invalid data format for treatments');
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'alias': alias,
      'location': location,
      'image': image,
      
    };
  }
}
