import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:study_helper/api/api_consts.dart';
import 'package:study_helper/api/service/auth_service.dart';
import 'package:study_helper/model/subject/subject_model.dart';
import 'package:study_helper/screen/summary_screens/lesson_screen.dart';
import 'package:study_helper/theme/theme_colors.dart';

class SummaryOngoingScreen extends StatefulWidget {
  const SummaryOngoingScreen({
    super.key,
    required this.text,
    required this.subjectModel,
    required this.dateTime,
  });

  final String text;
  final SubjectModel subjectModel;
  final DateTime dateTime;

  @override
  State<SummaryOngoingScreen> createState() => _SummaryOngoingScreenState();
}

class _SummaryOngoingScreenState extends State<SummaryOngoingScreen> {
  double _progress = 0.0;
  double _thirdApiProgress = 0.0;
  double _firstApiProgress = 0.0;
  double _secondApiProgress = 0.0;
  String _statusText = '요약 준비 중...';
  final Dio _dio = Dio();
  late final String summaryText;
  late final int summaryId;
  @override
  void initState() {
    super.initState();
    _startAPICalls();
  }

  void _updateTotalProgress() {
    _progress = _firstApiProgress + _secondApiProgress + _thirdApiProgress;
    _progress = _progress.clamp(0.0, 1.0); // 0과 1 사이의 값으로 제한
  }

  Future<void> _startAPICalls() async {
    await _callFirstAPI();
    sleep(Durations.medium1);
    await _callSecondAPI();
  }

  Future<void> _callFirstAPI() async {
    setState(() {
      _statusText = '요약 진행 중...';
    });

    try {
      String? token = await AuthService().getToken();
      final response = await _dio.post(
        "$url/api/summaries/self/create",
        onSendProgress: (count, total) {
          if (total != 0) {
            setState(() {
              _firstApiProgress = (count / total) * 0.5;
              _updateTotalProgress();
            });
          }
        },
        data: {
          'summary': widget.text,
          'subjectId': widget.subjectModel.id,
          'createdDate': widget.dateTime.toIso8601String(),
        },
        options: Options(
          headers: {
            'Authorization': token,
          },
          validateStatus: (_) => true,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        print(data.toString());
        summaryText = data['summaryText'];
        summaryId = data['id'] as int;
      } else {
        Get.snackbar("오류", "요약 API 호출 실패: ${response.statusCode}",
            backgroundColor: Colors.redAccent, colorText: Colors.white);
        Get.back();
      }
    } catch (e) {
      Get.snackbar("오류", "요약 API 호출 중 오류 발생: $e",
          backgroundColor: Colors.redAccent, colorText: Colors.white);
      Get.back();
    }
  }

  Future<void> _callSecondAPI() async {
    setState(() {
      _statusText = '퀴즈 생성 진행 중... 예상 소요시간 : 3분';
    });

    try {
      String? token = await AuthService().getToken();
      final response = await _dio.post(
        "$url/quiz/create",
        onSendProgress: (count, total) {
          if (total != 0) {
            setState(() {
              _secondApiProgress = (count / total) * 0.25;
              _updateTotalProgress();
            });
          }
        },
        onReceiveProgress: (count, total) {
          if (total != 0) {
            setState(() {
              _thirdApiProgress = (count / total) * 0.25;
              _updateTotalProgress();
            });
          }
        },
        data: {
          'lectureText': summaryText,
          'summaryId': summaryId,
        },
        options: Options(
          headers: {
            'Authorization': token,
          },
          validateStatus: (_) => true,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
      );

      if (response.statusCode == 200) {
        // 퀴즈 생성 성공
        setState(() {
          _progress = 1.0;
          _statusText = '요약 완료!';
          sleep(Durations.medium1);
          Get.offUntil(
            MaterialPageRoute(
              builder: (context) => LessonScreen(
                subjectModel: widget.subjectModel,
                dateTime: widget.dateTime,
                isValid: true,
              ),
            ),
            (route) => route.settings.name == '/bottomBar',
          );
        });
      } else {
        Get.snackbar("오류", "퀴즈 생성 API 호출 실패: ${response.statusCode}",
            backgroundColor: Colors.redAccent, colorText: Colors.white);
        Get.back();
      }
    } catch (e) {
      Get.snackbar("오류", "퀴즈 생성 API 호출 중 오류 발생: $e",
          backgroundColor: Colors.redAccent, colorText: Colors.white);
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Gap(100),
                    const SizedBox(
                      height: 40,
                      width: 40,
                      child: CircularProgressIndicator(
                        color: colorBottomBarSelected,
                      ),
                    ),
                    const Gap(20),
                    Text(
                      _statusText,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    const Gap(300),
                    LinearPercentIndicator(
                      // width: MediaQuery.of(context).size.width - 50, // 좌우 패딩 고려
                      lineHeight: 20.0,
                      percent: _progress,
                      center: Text(
                        '${(_progress * 100).toStringAsFixed(0)}%',
                        style: const TextStyle(
                            fontSize: 12.0, color: Colors.white),
                      ),
                      progressColor: colorBottomBarSelected,

                      backgroundColor: Colors.grey[300],
                      barRadius: const Radius.circular(10),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
