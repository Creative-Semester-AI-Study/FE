import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:study_helper/model/subject/subject_model.dart';
import 'package:study_helper/screen/summary_screens/quiz_screen.dart';
import 'package:study_helper/screen/summary_screens/summary_ongoing_screen.dart';
import 'package:study_helper/screen/summary_screens/summary_screen.dart';
import 'package:study_helper/theme/theme_colors.dart';
import 'package:study_helper/util/bottom_bar.dart';

class LessonScreen extends StatefulWidget {
  const LessonScreen({
    super.key,
    required this.subjectModel,
    required this.dateTime,
    required this.isValid,
  });
  final SubjectModel subjectModel;
  final DateTime dateTime;
  final bool isValid;

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  void _showSummaryRequiredDialog() {
    Get.snackbar('오류', '요약 내용을 먼저 작성해주세요',
        backgroundColor: Colors.redAccent, colorText: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.offAll(
              () => const BottomBar(index: 1),
              transition: Transition.leftToRight,
              duration: const Duration(milliseconds: 300),
            );
          },
        ),
        backgroundColor: Colors.white,
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
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.subjectModel.subjectName,
                    style: const TextStyle(
                      fontSize: 24,
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
                            '${DateFormat('MM월 dd일').format(widget.dateTime)} 수업',
                            style: const TextStyle(
                              fontSize: 16,
                              color: colorDefault,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        widget.isValid ? "요약완료" : "요약 미완료",
                        style: TextStyle(
                          color: widget.isValid ? Colors.green : Colors.red,
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
            Expanded(
              child: Card(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: widget.isValid
                      ? const Scrollbar(
                          thickness: 2, // 스크롤바의 두께
                          radius: Radius.circular(100), // 스크롤바 모서리의 둥근 정도
                          thumbVisibility: false,
                          child: Padding(
                              padding:
                                  EdgeInsets.only(top: 0, left: 30, right: 20),
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    Gap(30),
                                    Text(
                                      '',
                                      style: TextStyle(
                                        color: Colors.black,
                                        wordSpacing: 1.1,
                                        letterSpacing: 1.3,
                                        fontSize: 14.0,
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        )
                      : TextField(
                          controller: _textEditingController,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            focusColor: colorBottomBarDefault,
                          ),
                          expands: true,
                          maxLines: null,
                        ),
                ),
              ),
            ),
            Column(
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Card(
                        color: colorBottomBarDefault,
                        child: GestureDetector(
                          onTap: () {
                            if (_textEditingController.text == "") {
                              _showSummaryRequiredDialog();
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => widget.isValid
                                      ? const SummaryScreen()
                                      : SummaryOngoingScreen(
                                          dateTime: widget.dateTime,
                                          text: _textEditingController.text,
                                          subjectModel: widget.subjectModel,
                                        ),
                                ),
                              );
                            }
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.isValid ? "요약내용 수정" : "요약하기",
                                  style: const TextStyle(
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
                        color: widget.isValid
                            ? colorBottomBarDefault
                            : Colors.grey,
                        child: GestureDetector(
                          onTap: widget.isValid
                              ? () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const QuizScreen(),
                                    ),
                                  );
                                }
                              : _showSummaryRequiredDialog,
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
        ),
      ),
    );
  }
}
