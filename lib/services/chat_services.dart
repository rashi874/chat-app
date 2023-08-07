import 'dart:developer';
import 'package:zchatapp/api/api_endpoints.dart';
import 'package:zchatapp/api/base_rul.dart';
import 'package:zchatapp/util/dio_exceptions.dart';
import 'package:zchatapp/util/dio_interceptor.dart';

class ChatService {
  Future<dynamic> sendMessage(String text, String receiverId) async {
    try {
      final dio = await ApiInterceptor().getApiUser();
      final response = await dio.post(
        ApiBaseUrl().baseUrl + ApiEndpoints.sendmessages,
        data: {
          "receiver": receiverId,
          "text": text,
        },
      );
      log(response.statusCode.toString());

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data["error"] != null) {
          return null;
        }
        final messageId = response.data["messageId"].toString();
        log(messageId);
        return response.data;
      }
    } catch (e) {
      AppExceptions.errorHandler(e);
      log(e.toString());
    }

    return null;
  }
}
