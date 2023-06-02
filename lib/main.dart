import 'dart:developer';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:zchatapp/controller/ads_provider.dart';
import 'package:zchatapp/view/home/home_screen.dart';
import 'ads/ope_ads.dart';

Future<String?> getDeviceDetails() async {
  String? identifier = ''; // Initialized with an empty string
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  try {
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      // deviceName = androidInfo.model;
      // deviceVersion = androidInfo.version.toString();
      identifier = androidInfo.id; // UUID for Android
      log(androidInfo.id);
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
      // deviceName = iosInfo.name;
      // deviceVersion = iosInfo.systemVersion;
      identifier = iosInfo.identifierForVendor; // UUID for iOS
    }
  } catch (e) {
    print('Failed to get device details: $e');
  }

  return identifier;
}

//TP1A.221005.003

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await MobileAds.instance.initialize();

  await loadAd();
  await getDeviceDetails();

  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Color.fromARGB(251, 37, 35, 35)
        ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AdsProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Stranger Chat',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme:
              AppBarTheme(backgroundColor: Color.fromARGB(251, 37, 35, 35)),
          useMaterial3: true,
          scaffoldBackgroundColor: Color.fromARGB(251, 37, 35, 35),
          brightness: Brightness.dark,
        ),
        home: HomeScreen(),
      ),
    );
  }
}
