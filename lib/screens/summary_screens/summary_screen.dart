import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:study_helper/theme/theme_colors.dart';

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({
    super.key,
    required this.title,
  });
  final String title;
  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
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
                          "요약 미완료",
                          style: TextStyle(
                            color: Colors.red,
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
                  clipBehavior: Clip.hardEdge,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            const Text(
                              "요약하기",
                              style: TextStyle(
                                color: colorBottomBarDefault,
                                fontSize: 32,
                                fontWeight: FontWeight.w900,
                              ),
                            ),
                            Transform.translate(
                              offset: const Offset(40, 60),
                              child: SvgPicture.asset(
                                'assets/images/buttons/pen-tool-plus.svg',
                                height: 200,
                                // clipBehavior: Clip.antiAlias,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Card(
                  clipBehavior: Clip.hardEdge,
                  color: Colors.grey,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                const Text(
                                  "학습하기",
                                  style: TextStyle(
                                    color: Colors.black45,
                                    fontSize: 32,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                                Transform.translate(
                                  offset: const Offset(50, 50),
                                  child: SvgPicture.asset(
                                    colorFilter: const ColorFilter.mode(
                                        Colors.black45, BlendMode.srcIn),
                                    'assets/images/buttons/book-open-01.svg',
                                    height: 200,
                                    // clipBehavior: Clip.antiAlias,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        Container(
                          width: double.infinity,
                          color: colorBottomBarDefault,
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              textAlign: TextAlign.center,
                              "요약을 먼저 완료해주세요",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
