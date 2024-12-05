import 'package:dio/dio.dart';
import 'package:study_helper/api/api_consts.dart';
import 'package:study_helper/api/token_manager.dart';

Future<bool> loginStatus(String id, String pw) async {
  Dio dio = Dio();
  try {
    final response = await dio.post(
      "$url/study/login",
      data: {
        'id': id,
        'pw': pw,
      },
      options: Options(
        validateStatus: (_) => true,
        contentType: Headers.jsonContentType,
        responseType: ResponseType.json,
      ),
    );
    print(response.statusCode);
    if (response.statusCode == 401) {
      return false;
    } else if (response.statusCode == 200) {
      print(response.data.toString());
      // TokenManager().setToken(response.data[])
      return true;
    }
  } catch (e) {
    print(e);
  }

  return false;
}
