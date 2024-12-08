import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:study_helper/api/api_consts.dart';

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
      Map<String, dynamic> data = jsonDecode(response.data);
      print(data.toString());
      return true;
    }
  } catch (e) {
    print("--ERROR OCCURED--");
    print(e);
  }

  return false;
}
