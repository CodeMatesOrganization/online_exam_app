import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class PrefsHelper {
  static late SharedPreferences? prefs;

  static Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> SaveToken(String token) {
    return prefs!.setString("token", token);
  }

  static String? getToken() {
    return prefs!.getString("token");
  }

  static cleartoken() {
    prefs!.remove("token");
  }
}
