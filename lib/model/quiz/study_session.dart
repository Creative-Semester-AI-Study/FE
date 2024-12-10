import 'package:study_helper/model/quiz/quiz_model.dart';

class StudySession {
  final int userId;
  final String subjectName;
  final int round;
  final String date;
  final List<Quiz> quizzes;
  final int totalQuiz;
  final int correctAnswers;

  StudySession({
    required this.userId,
    required this.subjectName,
    required this.round,
    required this.date,
    required this.quizzes,
    required this.totalQuiz,
    required this.correctAnswers,
  });

  factory StudySession.fromJson(Map<String, dynamic> json) {
    return StudySession(
      userId: json['userId'],
      subjectName: json['subjectName'],
      round: json['round'],
      date: json['date'],
      quizzes: (json['quizzes'] as List).map((q) => Quiz.fromJson(q)).toList(),
      totalQuiz: json['totalQuiz'],
      correctAnswers: json['correctAnswers'],
    );
  }
}
