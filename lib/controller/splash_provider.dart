import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:zchatapp/view/home/home_screen.dart';

class SplashProvider extends ChangeNotifier {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  String? onboardValue;
  String? signinCheck;

  void splashTimer(context) {
    Timer(
      const Duration(seconds: 3),
      () async {
        onboardValue = await storage.read(key: 'onboard');
        signinCheck = await storage.read(key: 'token');
        log(signinCheck.toString());
        if (signinCheck != null) {
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
            builder: (context) {
              return HomeScreen();
            },
          ), (route) => false);
        } else {
          // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
          //   builder: (context) {
          //     return LoginScreen();
          //   },
          // ), (route) => false);
        }
      },
    );
  }

  bool isLoading = false;
  void logOut(context) async {
    isLoading = true;
    notifyListeners();
    await storage.delete(key: 'token');
    await storage.delete(key: 'refreshToken');
    await storage.delete(key: 'user');

    // Navigator.of(context).pushAndRemoveUntil(
    //   MaterialPageRoute(
    //     builder: (context) => LoginScreen(),
    //   ),
    //   (Route<dynamic> route) => false,
    // );

    notifyListeners();
    isLoading = false;
    notifyListeners();
  }
}
