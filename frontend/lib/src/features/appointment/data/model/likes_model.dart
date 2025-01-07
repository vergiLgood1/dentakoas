class Like {
  String id;
  String postId;
  String userId;
  DateTime createdAt;

  Like({
    required this.id,
    required this.postId,
    required this.userId,
    required this.createdAt,
  });

  factory Like.fromJson(Map<String, dynamic> json) {
    return Like(
      id: json['id'],
      postId: json['post_id'],
      userId: json['user_id'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'post_id': postId,
      'user_id': userId,
      'created_at': createdAt.toIso8601String(),
    };
  }

  static Like empty() {
    return Like(
      id: '',
      postId: '',
      userId: '',
      createdAt: DateTime.now(),
    );
  }
}
