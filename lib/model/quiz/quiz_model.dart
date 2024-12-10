class Quiz {
  final int quizId;
  final String question;
  final List<String> options;
  final String chosenAnswer;
  final String correctAnswer;

  Quiz({
    required this.quizId,
    required this.question,
    required this.options,
    required this.chosenAnswer,
    required this.correctAnswer,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      quizId: json['quizId'],
      question: json['question'],
      options: List<String>.from(json['options']),
      chosenAnswer: json['chosenAnswer'],
      correctAnswer: json['correctAnswer'],
    );
  }
}
