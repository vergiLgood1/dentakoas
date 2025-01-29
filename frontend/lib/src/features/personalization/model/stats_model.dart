class Stats {
  final int totalReviews;
  final double averageRating;
  final int patientCount;

  Stats({
    required this.totalReviews,
    required this.averageRating,
    required this.patientCount,
  });

  factory Stats.fromJson(Map<String, dynamic> json) {
    return Stats(
      totalReviews: json['totalReviews'] ?? 0,
      averageRating: json['averageRating'] is int
          ? (json['averageRating'] as int).toDouble()
          : (json['averageRating'] ?? 0.0),
      patientCount: json['patientCount'] ?? 0,
    );
  }
}
