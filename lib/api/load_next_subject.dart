import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:study_helper/api/api_consts.dart';
import 'package:study_helper/api/auth_service.dart';
import 'package:study_helper/main.dart';
import 'package:study_helper/model/subject/next_subject_preferences.dart';
import 'package:study_helper/model/subject/subject_model.dart';

Future<SubjectModel?> getNextSubject(String token) async {
  // 먼저 로컬 저장소에서 과목 데이터를 가져옵니다.
  SubjectModel? subjects = await NextSubjectPreferences.getSubject();

  if (!(await NextSubjectPreferences.isDataValid()) || subjects == null) {
    bool loadSuccess = await loadNextSubject(token);
    if (loadSuccess) {
      subjects = await NextSubjectPreferences.getSubject();
    }
  }
  return subjects;
}

Future<bool> loadNextSubject(String token) async {
  Dio dio = Dio();
  try {
    final response = await dio.get(
      "$url/study/subject/nextSubject",
      options: Options(
        headers: {
          'Authorization': token,
        },
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ),
    );
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.data.runtimeType);
      print(response.data.toString());

      SubjectModel subjectData = SubjectModel.fromJson(response.data);

      // 받아온 과목 데이터를 SubjectPreferences를 사용하여 저장
      await NextSubjectPreferences.saveSubject(subjectData);

      return true;
    } else if (response.statusCode == 500) {
      print("--ERROR OCCURRED--");
      print("TOKEN NOT AVAILABLE, LOGOUT");
      Get.snackbar(
        "과목 로드 중 토큰 오류가 발생했습니다",
        "다시 로그인해주세요.",
        snackPosition: SnackPosition.BOTTOM,
      );
      AuthService().logout();
    }
  } catch (e) {
    print("--ERROR OCCURRED--");
    print(e);
  }

  return false;
}
