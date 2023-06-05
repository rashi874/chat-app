import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:zchatapp/api/api_endpoints.dart';
import 'package:zchatapp/model/user_model.dart';
import 'package:zchatapp/util/dio_interceptor.dart';

import '../api/base_rul.dart';

class UserService {
  Future<Usermodel?> getuser() async {
    final dios = await ApiInterceptor().getApiUser();
    try {
      final Response response = await dios.get(
        ApiBaseUrl().baseUrl + ApiEndpoints.user,
        // queryParameters: {'id': "6450a11ff4d27c273ffc984b"}
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());
        final Usermodel model = Usermodel.fromJson(response.data);
        // log(response.data.toString());
        return model;
      }
    } on DioError catch (e) {
      log(e.response!.data.toString());
    }
    return null;
  }
}
