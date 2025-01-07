import 'package:denta_koas/src/features/personalization/model/user_model.dart';

enum StatusNotification { Unread, Read }

class NotificationsModel {
  final String? id;
  final String title;
  final String message;
  final Object status;
  final String? userId;
  final String? senderId;
  final String? koasId;
  final UserModel? sender;
  final UserModel? recipient;
  final DateTime? createdAt;
  final DateTime? updateAt;

  NotificationsModel({
    this.id,
    required this.title,
    required this.message,
    required this.status,
    this.userId,
    this.senderId,
    this.koasId,
    this.sender,
    this.recipient,
    this.createdAt,
    this.updateAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'status': status,
      'userId': userId,
      'senderId': senderId,
      'koasId': koasId,
    };
  }

  factory NotificationsModel.fromJson(Map<String, dynamic> json) {
    return NotificationsModel(
        id: json['id'] ?? '',
        title: json['title'] ?? '',
        message: json['message'] ?? '',
        status: json['status'] ?? '',
        userId: json['userId'],
        senderId: json['senderId'],
        koasId: json['koasId'],
        sender: json['sender'] != null
            ? UserModel.fromJson(json['sender'])
            : UserModel.empty(),
        recipient: json['recipient'] != null
            ? UserModel.fromJson(json['recipient'])
            : UserModel.empty(),
        createdAt: json['createdAt'] != null
            ? DateTime.tryParse(json['createdAt']) ?? DateTime.now()
            : DateTime.now(),
        updateAt: json['updateAt'] != null
            ? DateTime.tryParse(json['updateAt']) ?? DateTime.now()
            : DateTime.now());
  }

  factory NotificationsModel.fromMap(Map<String, dynamic> map) {
    return NotificationsModel(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      message: map['message'] ?? '',
      status: map['status'] ?? '',
      userId: map['userId'],
      senderId: map['senderId'],
      koasId: map['koasId'],
      createdAt: map['createdAt'] != null
          ? DateTime.tryParse(map['createdAt']) ?? DateTime.now()
          : DateTime.now(),
      updateAt: map['updateAt'] != null
          ? DateTime.tryParse(map['updateAt']) ?? DateTime.now()
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'message': message,
      'status': status,
      'userId': userId,
      'senderId': senderId,
      'koasId': koasId,
    };
  }

  static NotificationsModel empty() {
    return NotificationsModel(
      id: '',
      title: '',
      message: '',
      status: StatusNotification.Unread,
      userId: '',
      senderId: '',
      koasId: '',
      createdAt: DateTime.now(),
      updateAt: DateTime.now(),
    );
  }

  static List<NotificationsModel> notificationsFromJson(dynamic data) {
    if (data is Map<String, dynamic> && data.containsKey("notifications")) {
      final notifications = data["notifications"] as List;
      return notifications
          .map((item) => NotificationsModel.fromJson(item))
          .toList();
    }
    throw Exception('Invalid data format for notifications');
  }
}
