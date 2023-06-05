import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:zchatapp/api/api_endpoints.dart';
import 'package:zchatapp/model/message_model.dart';
import 'package:zchatapp/model/user_model.dart';
import 'package:zchatapp/util/dio_interceptor.dart';

import '../api/base_rul.dart';

class ChatService {
  Future<bool?> sendmessage(text, rid) async {
    final dios = await ApiInterceptor().getApiUser();
    try {
      final Response response = await dios.post(
          ApiBaseUrl().baseUrl + ApiEndpoints.sendmessages,
          data: {"reciever": rid, "text": text});
      if (response.statusCode == 200 || response.statusCode == 201) {
        log(response.data.toString());
        // final Messagemodel model = Messagemodel.fromJson(response.data);
        // log(response.data.toString());
        return true;
      }
    } on DioError catch (e) {
      log(e.response!.data.toString());
    }
    return null;
  }
}
