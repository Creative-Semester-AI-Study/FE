import 'package:dio/dio.dart';
import 'package:study_helper/api/api_consts.dart';
import 'package:study_helper/api/load/load_next_subject.dart';
import 'package:study_helper/api/service/auth_service.dart';
import 'package:study_helper/model/subject/next_subject_preferences.dart';
import 'package:study_helper/model/subject/subject_preferences.dart';

import '../../model/subject/subject_model.dart';

class SubjectService {
  final Dio _dio = Dio();

  Future<bool> deleteSubject(String token, int id) async {
    try {
      final response = await _dio.delete(
        '$url/study/subject/$id',
        options: Options(headers: {'Authorization': token}),
      );
      if (response.statusCode == 200) {
        await SubjectPreferences.removeSubject(id);
        await loadNextSubject(token);
        return true;
      } else {
        throw Exception('Failed to delete subject');
      }
    } catch (e) {
      print('Error deleting subject: $e');
      return false;
    }
  }

  Future<bool> addSubject(Map<String, dynamic> subjectData) async {
    try {
      String? token = await AuthService().getToken();

      final response = await _dio.post(
        '$url/study/subject/createSubject',
        options: Options(headers: {'Authorization': token}),
        data: subjectData,
      );
      if (response.statusCode == 200) {
        final newSubject = response.data;
        print(newSubject.toString());
        await SubjectPreferences.addSubject(SubjectModel.fromJson(newSubject));
        await loadNextSubject(token!);
        return true;
      } else {
        throw Exception('Failed to add subject');
      }
    } catch (e) {
      print('Error adding subject: $e');
      return false;
    }
  }
}
