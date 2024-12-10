import 'package:card_swiper/card_swiper.dart';
import 'package:circle_chart/circle_chart.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:study_helper/model/quiz/study_session.dart';
import 'package:study_helper/theme/theme_colors.dart';

class StudySessionsWidget extends StatelessWidget {
  final List<StudySession> studySessions;

  const StudySessionsWidget({super.key, required this.studySessions});

  @override
  Widget build(BuildContext context) {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        StudySession session = studySessions[index];
        return Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "${session.subjectName} ${session.round}회차",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const Gap(4),
                Text(
                  "학습일 : ${session.date}",
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: CircleChart(
                        progressColor: colorBottomBarSelected,
                        showRate: true,
                        progressNumber:
                            session.correctAnswers / session.totalQuiz,
                        maxNumber: session.totalQuiz,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            width: 60,
                            height: 60,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                            child: const Icon(
                              Icons.do_disturb_outlined,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          const Gap(10),
                          const Text(
                            "오답 복습 미완료",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      itemCount: studySessions.length,
      viewportFraction: 0.9,
      loop: false,
    );
  }
}
