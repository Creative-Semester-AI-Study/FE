import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:study_helper/api/api_consts.dart';
import 'package:study_helper/api/service/auth_service.dart';
import 'package:study_helper/theme/theme_colors.dart';
import 'package:dio/dio.dart';
import 'package:study_helper/util/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:study_helper/api/api_consts.dart';
import 'package:study_helper/api/service/auth_service.dart';
import 'package:study_helper/theme/theme_colors.dart';
import 'package:dio/dio.dart';
import 'package:study_helper/util/bottom_bar.dart';

class Quiz {
  final int quizId;
  final String question;
  final List<String> options;
  String? selectedAnswer;
  String? correctAnswer;
  bool? isCorrect;

  Quiz({
    required this.quizId,
    required this.question,
    required this.options,
    this.selectedAnswer,
    this.correctAnswer,
    this.isCorrect,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      quizId: json['quizId'],
      question: json['question'],
      options: List<String>.from(json['options']),
    );
  }
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final Dio _dio = Dio();
  List<Quiz> quizzes = [];
  int currentQuizIndex = 0;
  bool isLoading = true;
  bool isSubmitted = false;
  bool isGrading = false;
  bool isReviewing = false;
  int summaryId = 11;

  int correctAnswersCount = 0;

  void _startReview() {
    setState(() {
      currentQuizIndex = 0;
      isReviewing = true;
    });
  }

  bool _allQuestionsAnswered() {
    return quizzes.every((quiz) => quiz.selectedAnswer != null);
  }

  Color _getOptionColor(Quiz quiz, String option) {
    if (!isReviewing) {
      return quiz.selectedAnswer == option
          ? colorBottomBarSelected
          : Colors.grey;
    }
    if (option == quiz.correctAnswer) return Colors.green;
    if (option == quiz.selectedAnswer && option != quiz.correctAnswer)
      return Colors.red;
    return Colors.grey;
  }

  @override
  void initState() {
    super.initState();
    _fetchQuizzes();
  }

  Future<void> _fetchQuizzes() async {
    try {
      String? token = await AuthService().getToken();
      print("loading fin!!");
      final response = await _dio.post(
        '$url/quiz/get',
        options: Options(
          headers: {'Authorization': token},
          validateStatus: (_) => true,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
        data: {"summaryId": 11, "dayInterval": 0},
        onReceiveProgress: (count, total) {
          print('$count $total');
        },
      );

      if (response.statusCode == 200) {
        setState(() {
          quizzes = (response.data as List)
              .map((quiz) => Quiz.fromJson(quiz))
              .toList();
          isLoading = false;
          print("loading fin!!");
        });
      }
    } catch (e) {
      print('Error fetching quizzes: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  void _selectAnswer(String answer) {
    setState(() {
      quizzes[currentQuizIndex].selectedAnswer = answer;
    });
  }

  void _nextQuestion() {
    if (currentQuizIndex < quizzes.length - 1) {
      setState(() {
        currentQuizIndex++;
      });
    } else {
      _showSubmitConfirmation();
    }
  }

  void _previousQuestion() {
    if (currentQuizIndex > 0) {
      setState(() {
        currentQuizIndex--;
      });
    }
  }

  void _showSubmitConfirmation() {
    if (!_allQuestionsAnswered()) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('퀴즈 미완료'),
            content: const Text('모든 문제에 답변해주세요.'),
            actions: <Widget>[
              TextButton(
                child: const Text('확인'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('퀴즈 제출'),
            content: const Text('모든 문제를 풀었습니다. 제출하시겠습니까?'),
            actions: <Widget>[
              TextButton(
                child: const Text('취소'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('제출'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _submitQuiz();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _submitQuiz() async {
    setState(() {
      isGrading = true;
    });

    for (int i = 0; i < quizzes.length; i++) {
      await _submitQuizAnswer(
          quizzes[i].quizId, quizzes[i].selectedAnswer ?? "");
      setState(() {
        correctAnswersCount = quizzes.where((q) => q.isCorrect == true).length;
      });
      await Future.delayed(const Duration(milliseconds: 500)); // 각 문제 채점 사이의 지연
    }

    setState(() {
      isGrading = false;
      isSubmitted = true;
    });
  }

  Future<void> _submitQuizAnswer(int quizId, String answer) async {
    String? token = await AuthService().getToken();
    try {
      final response = await _dio.post(
        '$url/quiz/submit',
        options: Options(
          headers: {'Authorization': token},
          validateStatus: (_) => true,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
        data: {"summaryId": summaryId, "quizId": quizId, "answer": answer},
      );

      if (response.statusCode == 200) {
        var result = response.data;
        setState(() {
          Quiz quiz = quizzes.firstWhere((q) => q.quizId == quizId);
          quiz.correctAnswer = result['correctAnswers'];
          quiz.isCorrect = result['correct'];
        });
      } else {
        print('Failed to submit quiz answer: ${response.statusCode}');
      }
    } catch (e) {
      print('Error submitting quiz answer: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (isGrading) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircularProgressIndicator(),
              const SizedBox(height: 20),
              Text('채점 중... $correctAnswersCount/${quizzes.length}'),
            ],
          ),
        ),
      );
    }

    if (isSubmitted && !isReviewing) {
      return QuizFinishScreen(
        correctAnswers: correctAnswersCount,
        totalQuestions: quizzes.length,
        onReview: () {
          setState(() {
            currentQuizIndex = 0;
            isSubmitted = false;
            isReviewing = true; // 여기에 추가
          });
        },
      );
    }

    Quiz currentQuiz = quizzes[currentQuizIndex];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          isReviewing
              ? "검토 ${currentQuizIndex + 1}/${quizzes.length}"
              : "퀴즈 ${currentQuizIndex + 1}/${quizzes.length}",
          style: const TextStyle(fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Expanded(
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Q${currentQuizIndex + 1}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 32,
                            ),
                          ),
                          const Gap(10),
                          Text(currentQuiz.question),
                          const Gap(30),
                        ],
                      ),
                      Column(
                        children: [
                          ...currentQuiz.options.map((option) => Padding(
                                padding: const EdgeInsets.only(bottom: 5),
                                child: Card(
                                  color: _getOptionColor(currentQuiz, option),
                                  child: ListTile(
                                    title: Text(
                                      option,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    onTap: isReviewing
                                        ? null
                                        : () => _selectAnswer(option),
                                  ),
                                ),
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            const Gap(10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: ElevatedButton(
                    onPressed: currentQuizIndex > 0 ? _previousQuestion : null,
                    child: const Text("이전 문제"),
                  ),
                ),
                const Gap(4),
                Flexible(
                  child: ElevatedButton(
                    onPressed:
                        isReviewing && currentQuizIndex == quizzes.length - 1
                            ? () => Get.offAll(const BottomBar(index: 0))
                            : currentQuizIndex < quizzes.length - 1
                                ? _nextQuestion
                                : _showSubmitConfirmation,
                    child: Text(
                      isReviewing && currentQuizIndex == quizzes.length - 1
                          ? "마무리하기"
                          : currentQuizIndex < quizzes.length - 1
                              ? "다음 문제"
                              : "제출",
                    ),
                  ),
                ),
              ],
            ),
            const Gap(50),
          ],
        ),
      ),
    );
  }
}

class QuizFinishScreen extends StatelessWidget {
  final int correctAnswers;
  final int totalQuestions;
  final VoidCallback onReview;

  const QuizFinishScreen({
    super.key,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.onReview,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('퀴즈 결과')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$correctAnswers / $totalQuestions 정답'),
            ElevatedButton(
              onPressed: onReview,
              child: const Text('검토하기'),
            ),
            ElevatedButton(
              onPressed: () {
                Get.offAll(const BottomBar(index: 1));
              },
              child: const Text('마무리하기'),
            ),
          ],
        ),
      ),
    );
  }
}
