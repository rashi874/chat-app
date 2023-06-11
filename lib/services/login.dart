import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:zchatapp/api/api_endpoints.dart';
import 'package:zchatapp/api/base_rul.dart';
import 'package:zchatapp/model/signin_model.dart';

class LoginServices {
  Dio dio = Dio();
  Future<Signinmodel?> signinUser(id, gender) async {
    log(id.toString());
    try {
      Response response = await dio.post(
          ApiBaseUrl().baseUrl + ApiEndpoints.signIn,
          data: {"uniqueId": id, "gender": gender.toString().toLowerCase()});
      if (response.statusCode == 200 || response.statusCode == 201) {
        Signinmodel model = Signinmodel.fromJson(response.data);
        log(response.data.toString());
        return model;
      }
    } on DioException catch (e) {
      log(e.message.toString());
      log(e.response!.data.toString());
    
      return null;
      // DioException().dioError(e, context);
    }
    return null;
    // return null;
  }
}
