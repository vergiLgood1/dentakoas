class LikesModel {
  String? id;
  String? postId;
  String userId;
  DateTime? createdAt;

  LikesModel({
    this.id,
    this.postId,
    required this.userId,
    this.createdAt,
  });

  factory LikesModel.fromJson(Map<String, dynamic> json) {
    return LikesModel(
      id: json['id'] ?? '',
      postId: json['postId'] ?? '',
      userId: json['userId'] ?? '',
      createdAt:
          json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,  
    };
  }

  static LikesModel empty() {
    return LikesModel(
      id: '',
      postId: '',
      userId: '',
      createdAt: DateTime.now(),
    );
  }
}
