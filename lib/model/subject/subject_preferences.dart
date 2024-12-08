import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:study_helper/model/subject/subject_model.dart';

class SubjectPreferences {
  static const String _key = 'subject_list';
  static const String _timestampKey = 'subject_list_timestamp';
  static const int _cacheValidityDuration =
      24 * 60 * 60 * 1000; // 24 hours in milliseconds

  static Future<void> saveSubjects(List<SubjectModel> subjects) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> subjectJsonList =
        subjects.map((subject) => jsonEncode(subject.toJson())).toList();
    await prefs.setStringList(_key, subjectJsonList);
    await prefs.setInt(_timestampKey, DateTime.now().millisecondsSinceEpoch);
  }

  static Future<List<SubjectModel>> getSubjects() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? subjectJsonList = prefs.getStringList(_key);
    if (subjectJsonList != null) {
      return subjectJsonList
          .map((subjectJson) => SubjectModel.fromJson(jsonDecode(subjectJson)))
          .toList();
    }
    return [];
  }

  static Future<bool> isDataValid() async {
    final prefs = await SharedPreferences.getInstance();
    final int? timestamp = prefs.getInt(_timestampKey);
    if (timestamp == null) return false;

    final int currentTime = DateTime.now().millisecondsSinceEpoch;
    return (currentTime - timestamp) < _cacheValidityDuration;
  }

  static Future<void> removeAllSubjects() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
    await prefs.remove(_timestampKey);
  }

  static Future<void> addSubject(SubjectModel subject) async {
    final subjects = await getSubjects();
    subjects.add(subject);
    await saveSubjects(subjects);
  }

  static Future<void> removeSubject(int id) async {
    final subjects = await getSubjects();
    subjects.removeWhere((subject) => subject.id == id);
    await saveSubjects(subjects);
  }

  static Future<void> updateSubject(SubjectModel updatedSubject) async {
    final subjects = await getSubjects();
    final index =
        subjects.indexWhere((subject) => subject.id == updatedSubject.id);
    if (index != -1) {
      subjects[index] = updatedSubject;
      await saveSubjects(subjects);
    }
  }
}
