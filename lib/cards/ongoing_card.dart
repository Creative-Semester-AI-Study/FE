import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:study_helper/theme/theme_colors.dart';

Widget ongoingCard({
  required String subjectName,
  required String timeText,
  required bool isLast,
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
                color: colorBottomBarDefault,
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
              height: 125,
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
          child: Card(
            elevation: 1,
            color: colorBottomBarDefault,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        subjectName,
                        maxLines: 1,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Gap(2),
                      Text(
                        timeText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const Gap(30),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(""), //blank widget for space
                      Text(
                        "녹음 시작 >",
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
      )
    ],
  );
}
