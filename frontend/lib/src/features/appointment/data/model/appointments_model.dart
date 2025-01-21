class AppointmentsModel {
  String? id;
  String pasienId;
  String koasId;
  String scheduleId;
  String timeslotId;
  String date; // Tetap string jika tidak ingin mengubah ke DateTime
  StatusAppointment? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  AppointmentsModel({
    this.id,
    required this.pasienId,
    required this.koasId,
    required this.scheduleId,
    required this.timeslotId,
    required this.date,
    this.status = StatusAppointment.Pending,
    this.createdAt,
    this.updatedAt,
  });

  factory AppointmentsModel.fromJson(Map<String, dynamic> json) {
    return AppointmentsModel(
      id: json['id'] ?? '',
      pasienId: json['pasienId'] ?? '',
      koasId: json['koasId'] ?? '',
      scheduleId: json['scheduleId'] ?? '',
      timeslotId: json['timeslotId'] ?? '',
      date: json['date'] ?? '',
      status: json['status'] != null
          ? StatusAppointment.values.firstWhere(
              (e) => e.toString().split('.').last == json['status'],
              orElse: () => StatusAppointment.Pending,
            )
          : StatusAppointment.Pending,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pasienId': pasienId,
      'koasId': koasId,
      'scheduleId': scheduleId,
      'timeslotId': timeslotId,
      'date': date,
      'status': status?.toString().split('.').last,
 
    };
  }

  static AppointmentsModel empty() {
    return AppointmentsModel(
      id: '',
      pasienId: '',
      koasId: '',
      scheduleId: '',
      timeslotId: '',
      date: DateTime.now().toIso8601String(),
      status: StatusAppointment.Pending,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }

  static List<AppointmentsModel> appointmentsFromJson(dynamic data) {
    if (data is Map<String, dynamic> && data.containsKey("appointments")) {
      final appointments = data["appointments"] as List;
      return appointments
          .map((item) => AppointmentsModel.fromJson(item))
          .toList();
    }
    throw Exception('Invalid data format for appointments');
  }
}

enum StatusAppointment { Pending, Confirmed, Canceled }
