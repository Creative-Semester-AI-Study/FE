import 'package:dio/dio.dart';
import 'package:study_helper/api/api_consts.dart';
import 'package:study_helper/model/subject/subject_preferences.dart';

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
        return true;
      } else {
        throw Exception('Failed to delete subject');
      }
    } catch (e) {
      print('Error deleting subject: $e');
      return false;
    }
  }
}
