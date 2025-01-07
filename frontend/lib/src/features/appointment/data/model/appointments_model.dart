class Appointment {
  String id;
  String pasienId;
  String koasId;
  String scheduleId;
  String timeslotId;
  DateTime date;
  StatusAppointment status;
  DateTime createdAt;
  DateTime updatedAt;

  Appointment({
    required this.id,
    required this.pasienId,
    required this.koasId,
    required this.scheduleId,
    required this.timeslotId,
    required this.date,
    this.status = StatusAppointment.Pending,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'],
      pasienId: json['pasien_id'],
      koasId: json['koas_id'],
      scheduleId: json['schedule_id'],
      timeslotId: json['timeslot_id'],
      date: DateTime.parse(json['date']),
      status: StatusAppointment.values.firstWhere((e) => e.toString() == 'StatusAppointment.' + json['status']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'pasien_id': pasienId,
      'koas_id': koasId,
      'schedule_id': scheduleId,
      'timeslot_id': timeslotId,
      'date': date.toIso8601String(),
      'status': status.toString().split('.').last,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  static Appointment empty() {
    return Appointment(
      id: '',
      pasienId: '',
      koasId: '',
      scheduleId: '',
      timeslotId: '',
      date: DateTime.now(),
      status: StatusAppointment.Pending,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );
  }
}

enum StatusAppointment { Pending, Confirmed, Canceled }
