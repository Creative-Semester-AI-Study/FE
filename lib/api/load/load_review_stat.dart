import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:study_helper/api/api_consts.dart';
import 'package:study_helper/api/service/auth_service.dart';
import 'package:study_helper/model/review/review_model.dart';
import 'package:study_helper/model/stat/stat_review_model.dart';

Future<StatReviewModel> loadStatReview() async {
  Dio dio = Dio();
  String? token = await AuthService().getToken();
  try {
    final response = await dio.get(
      "$url/api/stats/today",
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
      print(response.data.toString());

      StatReviewModel reviewStatsData = StatReviewModel.fromJson(response.data);

      return reviewStatsData;
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

  return StatReviewModel(totalReviews: 0, completedReviews: 0);
}
