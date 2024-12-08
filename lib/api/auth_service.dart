import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:study_helper/api/api_consts.dart';
import 'package:study_helper/api/token_manager.dart';
import 'package:study_helper/model/user/user_model.dart';
import 'package:study_helper/model/user/user_preferences.dart';
import 'package:study_helper/model/subject/subject_preferences.dart';
import 'package:study_helper/screen/login_screens/login_screen.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();
  final Dio _dio = Dio();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();
  final TokenManager _tokenManager = TokenManager();

  Future<bool> login(String id, String pw) async {
    try {
      final response = await _dio.post(
        "$url/study/login",
        data: {'id': id, 'pw': pw},
        options: Options(
          validateStatus: (_) => true,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
        ),
      );

      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.data);
        print("token : ${data['token']}");
        UserModel user = UserModel.fromJson(data);
        await UserPreferences.saveUser(user);
        await _tokenManager.setToken(data['token']);
        await _secureStorage.write(key: 'isLoggedIn', value: 'true');
        return true;
      }
    } catch (e) {
      print("--ERROR OCCURRED--");
      print(e);
    }
    return false;
  }

  Future<void> logout() async {
    try {
      await _secureStorage.delete(key: 'isLoggedIn');
      await UserPreferences.removeUser();
      await SubjectPreferences.removeAllSubjects();
      await _tokenManager.deleteToken();
    } catch (e) {
      print('Logout error: $e');
      // 에러 처리 로직
    } finally {
      Get.offAll(() => const LoginScreen());
    }
  }

  Future<bool> isLoggedIn() async {
    String? isLoggedIn = await _secureStorage.read(key: 'isLoggedIn');
    return isLoggedIn == 'true';
  }

  Future<String?> getToken() async {
    return await _tokenManager.getToken();
  }

  factory AuthService() {
    return _instance;
  }

  AuthService._internal();
}
