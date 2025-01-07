class Review {
  String id;
  String postId;
  String userId;
  int rating; // Scale 1-5
  String? comment;
  DateTime createdAt;

  Review({
    required this.id,
    required this.postId,
    required this.userId,
    this.rating = 0,
    this.comment,
    required this.createdAt,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      postId: json['post_id'],
      userId: json['user_id'],
      rating: json['rating'] ?? 0,
      comment: json['comment'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'post_id': postId,
      'user_id': userId,
      'rating': rating,
      'comment': comment,
      'created_at': createdAt.toIso8601String(),
    };
  }

  static Review empty() {
    return Review(
      id: '',
      postId: '',
      userId: '',
      rating: 0,
      comment: null,
      createdAt: DateTime.now(),
    );
  }
}
