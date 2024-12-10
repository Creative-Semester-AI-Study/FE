import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:study_helper/screen/summary_screens/quiz_finish_screen.dart';
import 'package:study_helper/screen/summary_screens/summary_screen.dart';
import 'package:study_helper/theme/theme_colors.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "11월 18일 퀴즈",
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Padding(
        padding:
            const EdgeInsets.only(top: 20.0, left: 15, right: 15, bottom: 30),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Expanded(
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Q1",
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 32,
                            ),
                          ),
                          Gap(10),
                          Text(
                              "데드락에 대한 질문 데드락에 대한 질문 데드락에 대한 질문 데드락에 대한 질문 데드락에 대한 질문 데드락에 대한 질문 데드락에 대한 질문 데드락에 대한 질문 데드락에 대한 질문 데드락에 대한 질문 데드락에 대한 질문 데드락에 대한 질문 데드락에 대한 질문 데드락에 대한 질문 데드락에 대한 질문 데드락에 대한 질문 데드락에 대한 질문 데드락에 대한 질문 데드락에 대한 질문 데드락에 대한 질문 데드락에 대한 질문 데드락에 대한 질문"),
                        ],
                      ),
                      Gap(30),
                      Column(
                        children: [
                          Card(
                            color: Colors.grey,
                            child: Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Row(
                                children: [
                                  Text(
                                    "1. 데드락은 1번이다.",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Gap(5),
                          Card(
                            color: Colors.grey,
                            child: Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Row(
                                children: [
                                  Text(
                                    "1. 데드락은 1번이다.",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Gap(5),
                          Card(
                            color: Colors.green,
                            child: Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Row(
                                children: [
                                  Text(
                                    "1. 데드락은 1번이다.",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Gap(5),
                          Card(
                            color: Colors.redAccent,
                            child: Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Row(
                                children: [
                                  Text(
                                    "1. 데드락은 1번이다.",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Gap(5),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Gap(10),
            Column(
              children: [
                Row(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Flexible(
                      child: Card(
                        color: colorBottomBarDefault,
                        child: GestureDetector(
                          onTap: () {
                            //TODO
                            // // Navigator.push(
                            // //   context,
                            // //   MaterialPageRoute(
                            // //     builder: (context) => const SummaryScreen(),
                            // //   ),
                            // );
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "이전 문제",
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
                    ),
                    const Gap(4),
                    Flexible(
                      child: Card(
                        color: colorBottomBarDefault,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const QuizFinishScreen(),
                              ),
                            );
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "다음 문제",
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
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
