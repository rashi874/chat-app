import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:zchatapp/controller/ads_provider.dart';
import 'package:zchatapp/controller/chat_provider.dart';
import 'package:zchatapp/controller/global_provider.dart';
import 'package:zchatapp/controller/splash_provider.dart';
import 'package:zchatapp/controller/user_provider.dart';
import 'package:zchatapp/util/socket_manager.dart';
import 'package:zchatapp/view/login/login_screen.dart';
import 'ads/ope_ads.dart';

//TP1A.221005.003
//UPP1.230113.010

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  await loadAd();
  // await GblProviders().initialfunctions();
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Color.fromARGB(255, 36, 36, 36)),
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
        ChangeNotifierProvider(
          create: (context) => GblProviders(),
        ),
        ChangeNotifierProvider(
          create: (context) => SplashProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ChatProviders(),
        ),
      ],
      child: MaterialApp(
        title: 'Stranger Chat',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Color.fromARGB(61, 37, 35, 35),
          ),
          useMaterial3: true,
          fontFamily: 'PlusJakartaSans',
          scaffoldBackgroundColor: const Color.fromARGB(251, 37, 35, 35),
          brightness: Brightness.dark,
        ),
        home: Builder(builder: (context) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Provider.of<GblProviders>(context, listen: false)
                .socketInitialize();
          });
          return LoginScreen();
        }),
      ),
    );
  }
}
