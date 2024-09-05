import 'package:shared_preferences/shared_preferences.dart';

Future<String> getToken() async {
  final prefs = SharedPreferencesAsync();
  return await prefs.getString('token') ?? '';
}

Future<void> setToken(String token) async {
  final prefs = SharedPreferencesAsync();
  await prefs.setString('token', token);
}

Future<void> setCurrentUser(String data) async {
  final prefs = SharedPreferencesAsync();
  await prefs.setString('currentUser', data);
}

Future<String> getCurrentUser() async {
  final prefs = SharedPreferencesAsync();
  return await prefs.getString('currentUser') ?? '';
}
