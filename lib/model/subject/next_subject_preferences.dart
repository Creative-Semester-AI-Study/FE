import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_helper/model/subject/subject_model.dart';

class NextSubjectPreferences {
  static const String _key = 'next_subject';
  static const String _timestampKey = 'subject_timestamp';
  static const int _cacheValidityDuration =
      24 * 60 * 60 * 1000; // 24 hours in milliseconds

  static Future<bool> isDataValid() async {
    final prefs = await SharedPreferences.getInstance();
    final int? timestamp = prefs.getInt(_timestampKey);
    if (timestamp == null) return false;

    final int currentTime = DateTime.now().millisecondsSinceEpoch;
    return (currentTime - timestamp) < _cacheValidityDuration;
  }

  static Future<void> removeSubject() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
    await prefs.remove(_timestampKey);
  }

  static Future<void> saveSubject(SubjectModel subject) async {
    final prefs = await SharedPreferences.getInstance();
    final String subjectJson = jsonEncode(subject.toJson());
    await prefs.setString(_key, subjectJson);
    await prefs.setInt(_timestampKey, DateTime.now().millisecondsSinceEpoch);
  }

  static Future<SubjectModel?> getSubject() async {
    final prefs = await SharedPreferences.getInstance();
    final String? subjectJson = prefs.getString(_key);
    if (subjectJson == null) return null;
    return SubjectModel.fromJson(jsonDecode(subjectJson));
  }

  static Future<void> updateSubject(SubjectModel updatedSubject) async {
    await saveSubject(updatedSubject);
  }
}
