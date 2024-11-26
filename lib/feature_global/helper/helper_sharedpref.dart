import 'package:shared_preferences/shared_preferences.dart';

class HelperSharedPref {
  static late SharedPreferences _prefs;

  static Future<void> setInstance() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static Future<void> setUsername(String username) async {
    await _prefs.setString("username", username);
  }

  static String? getUsername() {
    return _prefs.getString("username");
  }

  static Future<void> setEmail(String email) async {
    await _prefs.setString("email", email);
  }

  static String? getEmail() {
    return _prefs.getString("email");
  }

  static Future<void> setPassword(String password) async {
    await _prefs.setString("password", password);
  }

  static String? getPassword() {
    return _prefs.getString("password");
  }

  static Future<void> setIsSignedUp(bool signedUp) async {
    await _prefs.setBool("isSignedUp", signedUp);
  }

  static bool isSignedUp() {
    return _prefs.getBool("isSignedUp") ?? false;
  }
}
