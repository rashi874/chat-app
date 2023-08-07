import 'dart:developer';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:zchatapp/controller/user_provider.dart';
import 'package:zchatapp/services/login.dart';
import 'package:zchatapp/view/home/home_screen.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
import 'package:zchatapp/view/home/widget/custom_drawer.dart';
import '../api/base_rul.dart';

class GblProviders with ChangeNotifier {
  FlutterSecureStorage storage = const FlutterSecureStorage();
  bool isLoading = false;
  String? gender;
  late io.Socket socket;

  void socketInitialize() {
    socket = io.io(ApiBaseUrl().baseUrl, <String, dynamic>{
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
        identifier = androidInfo.id; // UUID for Android
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
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
    await LoginServices().signinUser(id, gender).then(
      (value) {
        if (value != null) {
          storage.write(key: 'token', value: value.accessToken);
          storage.write(key: 'refreshToken', value: value.refreshToken);
          Provider.of<UserProvider>(context, listen: false).getuser();
          Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(
            builder: (context) {
              return const HomeScreen();
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
