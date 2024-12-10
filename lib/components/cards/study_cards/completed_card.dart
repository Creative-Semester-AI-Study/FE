import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:study_helper/model/subject/subject_model.dart';
import 'package:study_helper/screen/summary_screens/lesson_screen.dart';
import 'package:study_helper/theme/theme_colors.dart';

Widget completedCard({
  required BuildContext context,
  required SubjectModel subjectModel,
  required bool isLast,
  required DateTime dateTime,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      Flexible(
        flex: 1,
        child: Column(
          children: [
            const Gap(10),
            Container(
              decoration: const BoxDecoration(
                color: colorFinishedCircle,
                borderRadius: BorderRadius.all(
                  Radius.circular(100),
                ),
              ),
              height: 10,
              width: 10,
            ),
            const Gap(10),
            Container(
              decoration: BoxDecoration(
                color: isLast ? Colors.transparent : colorLine,
              ),
              height: 75,
              width: 1,
            )
          ],
        ),
      ),
      const Gap(5),
      Flexible(
        flex: 10,
        child: Transform.translate(
          offset: const Offset(0, 0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LessonScreen(
                    // dateTime: dateTime,
                    dateTime: DateTime.now(),
                    subjectModel: subjectModel,
                    isValid: true,
                  ),
                ),
              );
            },
            child: Card(
              elevation: 1,
              color: colorBottomBarSelected,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      subjectModel.subjectName,
                      maxLines: 1,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Gap(2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${subjectModel.startTimeCoverted()}~${subjectModel.endTimeCoverted()}',
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Text(
                          "요약 보기 >",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      )
    ],
  );
}
