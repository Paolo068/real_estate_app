import 'package:dio/dio.dart';
import 'package:real_estate_app/api_client.dart';
import 'package:real_estate_app/constants.dart';
import 'package:real_estate_app/loggers.dart';
import 'package:real_estate_app/utils.dart';

class AuthRepository {
  final ApiClient _client;
  AuthRepository(ApiClient client) : _client = client;

  createAccount({
    required String name,
    required String role,
    required String phone,
    required String email,
    required String password,
  }) async {
    final postData = {
      'first_name': name,
      'phone_number': phone,
      'email': email,
      'password': password,
      'role': role,
    };
    logInfo('POST DATA: $postData');
    try {
      final res = await _client.instance.post(
        Constants.createAccount,
        data: postData,
      );
      logInfo('RESULT OF CREATE ACCOUNT : $res');
    } on DioException catch (e) {
      logErr('DIO EXCEPTION : ${e.response?.data}');
      rethrow;
    } catch (e) {
      logErr(e);
      rethrow;
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    final postData = {
      'email': email,
      'password': password,
    };
    logInfo('POST DATA: $postData');
    try {
      final res = await _client.instance.post(
        Constants.login,
        data: postData,
      );
      logInfo('RESULT OF USER LOGIN : $res');
      await setToken(res.data['data']['access_token']);
      await getCurrentUser();
    } on DioException catch (e) {
      logErr('DIO EXCEPTION : ${e.response?.data}');
    } catch (e) {
      logErr(e);
    }
  }

  Future<String> getCurrentUser() async {
    try {
      final res = await _client.instance.get(
        Constants.getCurrentUser,
      );
      logInfo('GET CURRENT USER : $res');
      final role = res.data['data']['role'] as String;
      await setCurrentUser(role);
      return role;
    } on DioException catch (e) {
      logErr('DIO EXCEPTION : ${e.response?.data}');
      rethrow;
    } catch (e) {
      logErr(e);
      rethrow;
    }
  }
}
