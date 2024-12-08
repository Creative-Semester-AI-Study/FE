import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_helper/model/subject/subject_model.dart';

class SubjectPreferences {
  static const String _key = 'subject_model';

  static Future<void> saveSubject(SubjectModel subject) async {
    final prefs = await SharedPreferences.getInstance();
    final String subjectJson = jsonEncode(subject.toJson());
    await prefs.setString(_key, subjectJson);
  }

  static Future<SubjectModel?> getSubject() async {
    final prefs = await SharedPreferences.getInstance();
    final String? subjectJson = prefs.getString(_key);
    if (subjectJson != null) {
      return SubjectModel.fromJson(jsonDecode(subjectJson));
    }
    return null;
  }

  static Future<void> removeSubject() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
