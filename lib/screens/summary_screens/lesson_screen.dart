import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:scrollable_text_indicator/scrollable_text_indicator.dart';
import 'package:study_helper/screens/summary_screens/quiz_screen.dart';
import 'package:study_helper/screens/summary_screens/summary_screen.dart';
import 'package:study_helper/theme/theme_colors.dart';

class LessonScreen extends StatefulWidget {
  const LessonScreen({
    super.key,
    required this.title,
  });
  final String title;
  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorDetailScreenAppbar,
        title: const Text(
          "수업 요약",
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            left: 15,
            right: 15,
            bottom: 30,
          ),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "1회차 운영체제 수업",
                      style: TextStyle(
                        fontSize: 20,
                        color: colorDefault,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "11월 11일",
                              style: TextStyle(
                                fontSize: 12,
                                color: colorDefault,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            Gap(30),
                            Text(
                              "12:00 ~ 14:00",
                              style: TextStyle(
                                fontSize: 12,
                                color: colorDefault,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          "요약완료",
                          style: TextStyle(
                            color: Colors.green,
                            fontSize: 16,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Gap(10),
              const Expanded(
                child: ScrollableTextIndicator(
                  text: Text(
                    'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam pulvinar risus sit amet augue viverra ultrices. Aliquam erat volutpat. Proin sagittis ultricies blandit. Donec diam velit, vestibulum commodo leo eu, suscipit condimentum ante. Aenean laoreet sapien mauris. Praesent maximus sagittis felis auctor facilisis. In ullamcorper velit id leo semper, pellentesque luctus risus efficitur. Aenean et tristique diam, vitae volutpat mi. Morbi bibendum ut nibh a ornare. Nulla nec dolor pellentesque, gravida neque ut, condimentum augue. Phasellus mollis metus ac tincidunt venenatis. Aenean at ullamcorper massa. Vestibulum volutpat nunc ut ultrices facilisis. Cras dui lorem, vehicula eu hendrerit non, sollicitudin quis libero. Morbi dapibus libero tincidunt lobortis efficitur. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nullam pulvinar risus sit amet augue viverra ultrices. Aliquam erat volutpat. Proin sagittis ultricies blandit. Donec diam velit, vestibulum commodo leo eu, suscipit condimentum ante. Aenean laoreet sapien mauris. Praesent maximus sagittis felis auctor facilisis. In ullamcorper velit id leo semper, pellentesque luctus risus efficitur. Aenean et tristique diam, vitae volutpat mi. Morbi bibendum ut nibh a ornare. Nulla nec dolor pellentesque, gravida neque ut, condimentum augue. Phasellus mollis metus ac tincidunt venenatis. Aenean at ullamcorper massa. Vestibulum volutpat nunc ut ultrices facilisis. Cras dui lorem, vehicula eu hendrerit non, sollicitudin quis libero. Morbi dapibus libero tincidunt lobortis efficitur.',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
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
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SummaryScreen(),
                                ),
                              );
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(20.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "요약내용 수정",
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
                                    "학습하기",
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
          )),
    );
  }
}
