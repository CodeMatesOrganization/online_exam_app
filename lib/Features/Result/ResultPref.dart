import 'dart:convert';

import 'package:online_exam/Features/Result/model/ExamResultModel.dart';
import 'package:shared_preferences/shared_preferences.dart' show SharedPreferences;

class ResultStorageService {
  static const String key = "exam_results";

  static Future<void> saveExamResult(ExamResultModel model) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> stored = prefs.getStringList(key) ?? [];

    stored.add(jsonEncode(model.toJson()));

    await prefs.setStringList(key, stored);
  }

  static Future<List<ExamResultModel>> loadExamResults() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> stored = prefs.getStringList(key) ?? [];

    return stored.map((e) {
      return ExamResultModel.fromJson(jsonDecode(e));
    }).toList();
  }
}
