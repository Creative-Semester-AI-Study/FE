import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:study_helper/theme/theme_colors.dart';

Widget buttonCompleted() {
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
              decoration: const BoxDecoration(
                color: colorLine,
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
          child: const Card(
            elevation: 1,
            color: colorBottomBarSelected,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    "알고리즘",
                    maxLines: 1,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Gap(2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "10:00 ~ 12:00",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
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
      )
    ],
  );
}
