import 'package:dio/dio.dart';
import 'package:real_estate_app/constants.dart';
import 'package:real_estate_app/loggers.dart';
import 'package:real_estate_app/utils.dart';

class ApiClient {
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;
  ApiClient._internal();

  final instance = Dio(BaseOptions(
    baseUrl: Constants.baseUrl,
  ))
    ..interceptors.add(CustomInterceptor());
}

class CustomInterceptor extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await getToken();
    if (options.path != Constants.login &&
        options.path != Constants.createAccount &&
        options.path != Constants.getRoles) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    logInfo(options.headers);
    handler.next(options);
  }

  // @override
  // void onResponse(Response response, ResponseInterceptorHandler handler) {
  // }
}
