import 'dart:async';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:zchatapp/util/themes.dart';
import 'package:zchatapp/util/tost.dart';

class AppExceptions {
  static void errorHandler(Object e) {
    if (e is PlatformException) {
      AppToast.showToast('Platform Error Occured', AppColors().kblack);
    }
    if (e is SocketException) {
      AppToast.showToast('No Internet Connection', AppColors().kblack);
    } else if (e is TimeoutException) {
      AppToast.showToast('Connection Timedout', AppColors().kblack);
    } else if (e is MissingPluginException) {
      AppToast.showToast('Plugin error occured', AppColors().kblack);
    } else if (e is DioException) {
      if (e.response?.data['message'] != null) {
        AppToast.showToast(
            e.response!.data['message'].toString(), AppColors().kblack);
      } else if (e.error is SocketException) {
        AppToast.showToast('No Internet Connection', AppColors().kblack);
      }
    }
  }
}
