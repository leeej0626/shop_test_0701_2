import 'package:shared_preferences/shared_preferences.dart';

String key_login_user = "user";

Future<bool> set_user(String user) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(key_login_user, user);
  return true;
}

Future<String> get_login_user() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(key_login_user) ?? "";
}