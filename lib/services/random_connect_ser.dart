import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:zchatapp/api/api_endpoints.dart';
import 'package:zchatapp/model/random_model.dart';
import 'package:zchatapp/util/dio_interceptor.dart';
import '../api/base_rul.dart';

class RandomuserService {
  Future<Randommodel?> getrandomuser(randomcancelToken) async {
    final dios = await ApiInterceptor().getApiUser();
    try {
      final Response response = await dios.get(
        ApiBaseUrl().baseUrl + ApiEndpoints.random,
        cancelToken: randomcancelToken
        // queryParameters: {'id': "6450a11ff4d27c273ffc984b"}
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());
        final Randommodel model = Randommodel.fromJson(response.data);
        // log(response.data.toString());
        return model;
      }
    } on DioException catch (e) {
      log(e.toString());
    }
    return null;
  }
}
