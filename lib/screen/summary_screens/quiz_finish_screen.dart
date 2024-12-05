import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:study_helper/screen/summary_screens/quiz_screen.dart';
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
      body: Padding(
        padding:
            const EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 30),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                "11월 18일 운영체제",
                style: TextStyle(
                  fontSize: 32,
                  color: colorBottomBarDefault,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Text(
                "퀴즈결과",
                style: TextStyle(
                  fontSize: 32,
                  color: colorBottomBarDefault,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const Gap(40),
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.green, shape: BoxShape.circle),
                    width: 170,
                    height: 170,
                  ),
                  const Text(
                    "5/6",
                    style: TextStyle(
                      fontSize: 64,
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              const Gap(40),
              Card(
                color: colorBottomBarDefault,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const QuizScreen(),
                      ),
                    );
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "퀴즈 다시풀기",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Card(
                color: colorBottomBarDefault,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "돌아가기",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
