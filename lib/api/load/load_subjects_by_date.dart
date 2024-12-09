import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:study_helper/api/api_consts.dart';
import 'package:study_helper/api/service/auth_service.dart';
import 'package:study_helper/model/subject/subject_model.dart';

Future<List<SubjectModel>> loadSubjectByDate(String date, bool isStudy) async {
  Dio dio = Dio();

  try {
    String? token = await AuthService().getToken();
    final response = await dio.get(
      isStudy ? "$url/study/subject/check/$date" : "$url/api/reviews/$date",
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

      print("Loaded ${subjects.length} subjects");
      return subjects;
    } else if (response.statusCode == 500) {
      // print("--ERROR OCCURRED--");
      // print("TOKEN NOT AVAILABLE, LOGOUT");
      // Get.snackbar(
      //   "과목 로드 중 토큰 오류가 발생했습니다",
      //   "다시 로그인해주세요.",
      //   snackPosition: SnackPosition.BOTTOM,
      // );
      // AuthService().logout();
    }
  } catch (e) {
    print("--ERROR OCCURRED--");
    print(e);
  }

  return [];
}
