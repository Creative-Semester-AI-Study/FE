class ReviewModel {
  final int id;
  final int subjectId;
  final String audioFileName;
  final String transcriptText;
  final DateTime createdAt;
  final int quizId;
  final int summaryId;
  final int userId;

  ReviewModel({
    required this.id,
    required this.subjectId,
    required this.audioFileName,
    required this.transcriptText,
    required this.createdAt,
    required this.quizId,
    required this.summaryId,
    required this.userId,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['id'] as int,
      subjectId: json['subjectId'] as int,
      audioFileName: json['audioFileName'] as String,
      transcriptText: json['transcriptText'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      quizId: json['quizId'] as int,
      summaryId: json['summaryId'] as int,
      userId: json['userId'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subjectId': subjectId,
      'audioFileName': audioFileName,
      'transcriptText': transcriptText,
      'createdAt': createdAt.toIso8601String(),
      'quizId': quizId,
      'summaryId': summaryId,
      'userId': userId,
    };
  }
}
