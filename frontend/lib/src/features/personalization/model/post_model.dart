class PostModel {
  String? title;
  String? desc;
  String? patientRequirement;
  int? requiredParticipant;
  String? status;
  bool published;
  String? treatmentId;
  String? userId;
  String? koasId;

  PostModel({
    this.title,
    this.desc,
    this.patientRequirement,
    this.requiredParticipant,
    this.status = "Draft",
    this.published = false,
    this.treatmentId,
    this.userId,
    this.koasId,
  });
}

class ScheduleModel {
  DateTime? dateStart;
  DateTime? dateEnd;
  List<TimeSlot> timeSlots;

  ScheduleModel({
    this.dateStart,
    this.dateEnd,
    this.timeSlots = const [],
  });
}

class TimeSlot {
  String? startTime;
  String? endTime;
  int? maxParticipants;

  TimeSlot({this.startTime, this.endTime, this.maxParticipants = 0});
}
