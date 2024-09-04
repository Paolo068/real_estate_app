import 'package:shared_preferences/shared_preferences.dart';

Future<String> getToken() async {
  final prefs = SharedPreferencesAsync();
  return await prefs.getString('token') ?? '';
}

Future<void> setToken(String token) async {
  final prefs = SharedPreferencesAsync();
  await prefs.setString('token', token);
}
