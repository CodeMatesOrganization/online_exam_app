import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart'
    show SharedPreferences;

@singleton
class SharedPreferencesHelper {

  Future saveToken(String? token) async {
    if (token == null) return;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("token", token);

  }

  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("token");
  }

  Future saveSubjectId(String? subjectId) async {
    if (subjectId == null) return;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("subjectId", subjectId);
  }

  Future<String?> getSubjectId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("subjectId");
  }
}