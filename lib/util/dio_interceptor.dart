import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:zchatapp/api/api_endpoints.dart';
import 'package:zchatapp/api/base_rul.dart';
import 'package:zchatapp/view/login/login_screen.dart';

class ApiInterceptor {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  Dio dio = Dio();

  Future<Dio> getApiUser([context]) async {
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await storage.read(key: 'token');
          dio.interceptors.clear();
          options.headers.addAll({"Authorization": "Bearer $token"});
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) async {
          if (e.response != null) {
            if (e.response?.statusCode == 401 &&
                e.response?.data['error'] == 'Access token expired') {
              log('token expired');
              if (context != null) {
                Navigator.pushAndRemoveUntil(
                    context,
                    CupertinoPageRoute(builder: (ctx) => const LoginScreen()),
                    (route) => false);
              }

              RequestOptions requestOptions = e.requestOptions;
              try {
                await regenerateToken();

                // ignore: empty_catches
              } catch (e) {}
              try {
                final token = await storage.read(key: 'token');
                final opts = Options(method: requestOptions.method);
                dio.options.headers["Authorization"] = "Bearer $token";
                final response = await dio.request(
                  requestOptions.path,
                  options: opts,
                  cancelToken: requestOptions.cancelToken,
                  onReceiveProgress: requestOptions.onReceiveProgress,
                  data: requestOptions.data,
                  queryParameters: requestOptions.queryParameters,
                );
                return handler.resolve(response);
                // ignore: empty_catches
              } catch (e) {}
            }
          } else {
            handler.next(e);
          }
        },
      ),
    );
    return dio;
  }

  static regenerateToken() async {
    Response response;
    FlutterSecureStorage storage = const FlutterSecureStorage();
    var dio = Dio();
    final Uri apiUrl = Uri.parse(
      ApiBaseUrl().baseUrl + ApiEndpoints.refreshToken,
    );
    var refreshToken = await storage.read(key: 'refreshToken');
    log(refreshToken.toString());
    try {
      response =
          await dio.postUri(apiUrl, data: {'refreshToken': refreshToken});
      if (response.statusCode == 200) {
        storage.write(key: 'token', value: response.data["accessToken"]);
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
