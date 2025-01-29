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
      id: json['id'] ?? '',
      postId: json['postId'] ?? '',
      userId: json['userId'] ?? '',
      rating: json['rating'] ?? 0,
      comment: json['comment'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'postId': postId,
      'userId': userId,
      'rating': rating,
      'comment': comment,
      'createdAt': createdAt.toIso8601String(),
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
