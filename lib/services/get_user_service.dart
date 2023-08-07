import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:zchatapp/api/api_endpoints.dart';
import 'package:zchatapp/model/user_model.dart';
import 'package:zchatapp/util/dio_exceptions.dart';
import 'package:zchatapp/util/dio_interceptor.dart';

import '../api/base_rul.dart';

class UserService {
  Future<Usermodel?> getuser() async {
    final dios = await ApiInterceptor().getApiUser();
    try {
      final Response response = await dios.get(
        ApiBaseUrl().baseUrl + ApiEndpoints.user,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());
        final Usermodel model = Usermodel.fromJson(response.data);
        return model;
      }
    } on DioException catch (e) {
      AppExceptions.errorHandler(e);
      log(e.response!.data.toString());
      return null;
    }
    return null;
  }

  Future edituser(id, gender, String updatedname) async {
    log(id.toString());
    final dios = await ApiInterceptor().getApiUser();
    try {
      dios.put(ApiBaseUrl().baseUrl + ApiEndpoints.edituser, queryParameters: {
        "id": id
      }, data: {
        "name": updatedname,
        "gender": gender.toString().toLowerCase()
      });
    } on DioException catch (e) {
      AppExceptions.errorHandler(e);
      log(e.message.toString());
      log(e.response!.data.toString());
      return null;
    }
    return null;
  }
}
