import 'package:dio/dio.dart';
import 'package:study_helper/api/api_consts.dart';
import 'package:study_helper/api/auth_service.dart';
import 'package:study_helper/model/review/review_model.dart';

Future<List<ReviewModel>> loadReviews(String token, int id) async {
  Dio dio = Dio();
  try {
    final response = await dio.get(
      "$url/study/myPage/transcripts/$id",
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

      List<dynamic> reviewsData = response.data is List ? response.data : [];
      List<ReviewModel> reviews = reviewsData
          .map((reviewData) => ReviewModel.fromJson(reviewData))
          .toList();

      print("Loaded ${reviews.length} reviews");
      return reviews;
    } else if (response.statusCode == 500) {
      print("--ERROR OCCURRED--");
      print("TOKEN NOT AVAILABLE, LOGOUT");
      AuthService().logout();
    }
  } catch (e) {
    print("--ERROR OCCURRED--");
    print(e);
  }

  return [];
}
