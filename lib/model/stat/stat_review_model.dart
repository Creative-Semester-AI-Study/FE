class StatReviewModel {
  final int totalReviews;
  final int completedReviews;

  StatReviewModel({
    required this.totalReviews,
    required this.completedReviews,
  });

  factory StatReviewModel.fromJson(Map<String, dynamic> json) {
    return StatReviewModel(
      totalReviews: json['totalReviews'] as int,
      completedReviews: json['completedReviews'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalReviews': totalReviews,
      'completedReviews': completedReviews,
    };
  }
}
