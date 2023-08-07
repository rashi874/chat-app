import 'dart:async';
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:zchatapp/controller/user_provider.dart';
import 'package:zchatapp/view/home/home_screen.dart';
import 'package:zchatapp/view/home/widget/transition.dart';
import 'package:zchatapp/view/login/login_screen.dart';

class SplashProvider extends ChangeNotifier {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  String? onboardValue;
  String? signinCheck;

  void splashTimer(context) {
    Timer(
      const Duration(seconds: 2),
      () async {
        onboardValue = await storage.read(key: 'onboard');
        signinCheck = await storage.read(key: 'token');
        log(signinCheck.toString());
        if (signinCheck != null) {
          Provider.of<UserProvider>(context, listen: false).getuser();
          Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(
            builder: (context) {
              return const HomeScreen();
            },
          ), (route) => false);
        } else {
          Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(
            builder: (context) {
              return const LoginScreen();
            },
          ), (route) => false);
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

    Navigator.of(context).pushAndRemoveUntil(
      SlideTransitionExample(
        page: const LoginScreen(),
      ),
      (Route<dynamic> route) => false,
    );
    isLoading = false;
  }
}
