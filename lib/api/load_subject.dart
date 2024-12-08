import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:study_helper/api/api_consts.dart';
import 'package:study_helper/api/auth_service.dart';
import 'package:study_helper/api/token_manager.dart';
import 'package:study_helper/model/subject/subject_model.dart';
import 'package:study_helper/model/subject/subject_preferences.dart';
import 'package:study_helper/model/user/user_preferences.dart';
import 'package:study_helper/screen/login_screens/login_screen.dart';

Future<List<SubjectModel>> getSubjects(String token) async {
  // 먼저 로컬 저장소에서 과목 데이터를 가져옵니다.
  List<SubjectModel> subjects = await SubjectPreferences.getSubjects();

  // 로컬 저장소에 데이터가 없거나 유효하지 않으면 서버에 요청합니다.
  if (subjects.isEmpty || !(await SubjectPreferences.isDataValid())) {
    bool loadSuccess = await loadSubject(token);
    if (loadSuccess) {
      subjects = await SubjectPreferences.getSubjects();
    }
  }
  return subjects;
}

Future<bool> loadSubject(String token) async {
  Dio dio = Dio();
  try {
    final response = await dio.get(
      "$url/study/myPage/all",
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

      List<dynamic> subjectsData = response.data is List ? response.data : [];
      List<SubjectModel> subjects = subjectsData
          .map((subjectData) => SubjectModel.fromJson(subjectData))
          .toList();
      // 받아온 과목 데이터를 SubjectPreferences를 사용하여 저장
      await SubjectPreferences.saveSubjects(subjects);

      print("Loaded ${subjects.length} subjects");
      return true;
    } else if (response.statusCode == 500) {
      print("--ERROR OCCURRED--");
      print("TOKEN NOT AVAILABLE, LOGOUT");
      AuthService().logout();
    }
  } catch (e) {
    print("--ERROR OCCURRED--");
    print(e);
  }

  return false;
}
