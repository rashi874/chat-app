import 'package:flutter/animation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:zchatapp/util/themes.dart';

class AppToast {
  static Future<void> showToast(
    String msg,
    Color color, [
    Toast toastLength = Toast.LENGTH_SHORT,
  ]) async {
    await Fluttertoast.cancel();
    await Fluttertoast.showToast(
      textColor: AppColors().kwhite,
      msg: msg,
      backgroundColor: color,
      toastLength: toastLength,
    );
  }
}
