class ReviewModel {
  String? id;
  String postId;
  String pasienId;
  String koasId;
  double rating; // Scale 1-5
  String? comment;
  DateTime? createdAt;

  ReviewModel({
    this.id,
    required this.postId,
    required this.pasienId,
    required this.koasId,
    this.rating = 0.0,
    this.comment,
    this.createdAt,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] ?? '',
      postId: json['postId'] ?? '',
      pasienId: json['pasienId'] ?? '',
      koasId: json['koasId'] ?? '',
      rating: json['rating'] is String
          ? double.parse(json['rating'])
          : json['rating'] ?? 0.0,
      comment: json['comment'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'postId': postId,
      'pasienId': pasienId,
      'koasId': koasId,
      'rating': rating,
      'comment': comment,
    };
  }

  static ReviewModel empty() {
    return ReviewModel(
      id: '',
      postId: '',
      pasienId: '',
      koasId: '',
      rating: 0,
      comment: null,
      createdAt: DateTime.now(),
    );
  }

static List<ReviewModel> reviewsFromJson(dynamic data) {
    // Pastikan data adalah Map dan memiliki key "treatments".
    if (data is Map<String, dynamic> && data.containsKey("reviews")) {
      final reviews = data["reviews"] as List;
      return reviews.map((item) => ReviewModel.fromJson(item)).toList();
    }
    throw Exception('Invalid data format for treatments');
  }
  
}
