import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:study_helper/api/api_consts.dart';
import 'package:study_helper/api/token_manager.dart';
import 'package:study_helper/model/user/user_model.dart';
import 'package:study_helper/model/user/user_preferences.dart';

Future<bool> auth(String id, String pw) async {
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
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.data);
      print("token : ${data['token']}");
      UserModel user = UserModel.fromJson(data);
      await UserPreferences.saveUser(user);
      await TokenManager().setToken(data['token']);
      return true;
    }
  } catch (e) {
    print("--ERROR OCCURED--");
    print(e);
  }

  return false;
}
