import 'dart:developer';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:zchatapp/controller/user_provider.dart';
import 'package:zchatapp/services/login.dart';
import 'package:zchatapp/view/home/home_screen.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../api/base_rul.dart';

class GblProviders with ChangeNotifier {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  // Future<String?> id = Future.value(null); // Initialize with null

  bool isLoading = false;
  String? gender;
  late IO.Socket socket;

  void socketInitialize() {
    socket = IO.io(ApiBaseUrl().baseUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.onConnect((_) {
      log('Socket connected: ${socket.id}');
    });

    socket.onDisconnect((_) {
      log('Socket disconnected');
    });
    socket.connect();
    notifyListeners();
  }

  Future<String> getDeviceDetails() async {
    String? identifier = ''; // Initialized with an empty string
    final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
        // deviceName = androidInfo.model;
        // deviceVersion = androidInfo.version.toString();

        identifier = androidInfo.id; // UUID for Android
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
        // deviceName = iosInfo.name;
        // deviceVersion = iosInfo.systemVersion;
        identifier = iosInfo.identifierForVendor; // UUID for iOS
      }
    } catch (e) {
      log('Failed to get device details: $e');
    }

    notifyListeners();
    return identifier!;
  }

  Future<void> signupUser(context) async {
    var id = await getDeviceDetails();
    log(id.toString());
    isLoading = true;
    notifyListeners();
    // log(id);

    await LoginServices().signinUser(id, gender).then(
      (value) {
        if (value != null) {
          storage.write(key: 'token', value: value.accessToken);
          storage.write(key: 'refreshToken', value: value.refreshToken);
          Provider.of<UserProvider>(context, listen: false).getuser();
          Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
            builder: (context) {
              return HomeScreen();
            },
          ), (route) => false);
        }
      },
    );
    isLoading = false;
    notifyListeners();
  }

  Future initialfunctions() async {
    var acces = await storage.read(key: 'token');

    if (acces != null) {
      await UserProvider().getuser();
    } else {}
  }
}
