class UniversityModel {
  final String id;
  final String name;
  final String alias;
  final String location;

  UniversityModel({
    required this.id,
    required this.name,
    required this.alias,
    required this.location,
  });

  static UniversityModel empty() {
    return UniversityModel(
      id: '',
      name: '',
      alias: '',
      location: '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'alias': alias,
      'location': location,
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
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'alias': alias,
      'location': location,
    };
  }
}
