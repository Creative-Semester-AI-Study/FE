import 'package:flutter/material.dart';
import 'package:study_helper/theme/theme_colors.dart';

class QuizFinishScreen extends StatefulWidget {
  const QuizFinishScreen({super.key});

  @override
  State<QuizFinishScreen> createState() => _QuizFinishScreenState();
}

class _QuizFinishScreenState extends State<QuizFinishScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorDetailScreenAppbar,
        title: const Text(
          "퀴즈 완료",
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 30),
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
