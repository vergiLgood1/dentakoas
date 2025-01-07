class TreatmentModel {
  final String? id;
  final String? name;
  final String? alias;

  TreatmentModel({
    this.id,
    this.name,
    this.alias,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'alias': alias,
    };
  }

  factory TreatmentModel.fromJson(Map<String, dynamic> json) {
    return TreatmentModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      alias: json['alias'] ?? '',
    );
  }

  factory TreatmentModel.fromMap(Map<String, dynamic> map) {
    return TreatmentModel(
      name: map['name'] ?? '',
      alias: map['alias'] ?? '',
    );
  }

  TreatmentModel copyWith({
    String? name,
    String? alias,
  }) {
    return TreatmentModel(
      name: name ?? this.name,
      alias: alias ?? this.alias,
    );
  }

  static TreatmentModel empty() {
    return TreatmentModel(
      name: '',
      alias: '',
    );
  }

  static List<TreatmentModel> treatmentsFromJson(dynamic data) {
    // Pastikan data adalah Map dan memiliki key "treatments".
    if (data is Map<String, dynamic> && data.containsKey("treatments")) {
      final treatments = data["treatments"] as List;
      return treatments.map((item) => TreatmentModel.fromJson(item)).toList();
    }
    throw Exception('Invalid data format for treatments');
  }
}
