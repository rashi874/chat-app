import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:zchatapp/controller/ads_provider.dart';
import 'package:zchatapp/controller/chat_provider.dart';
import 'package:zchatapp/controller/global_provider.dart';
import 'package:zchatapp/controller/splash_provider.dart';
import 'package:zchatapp/controller/user_provider.dart';
import 'package:zchatapp/util/themes.dart';
import 'package:zchatapp/view/SplashScreen/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  runApp(const MyApp());
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      systemNavigationBarContrastEnforced: false,
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: AppColors().kprimary,
      statusBarIconBrightness: Brightness.light));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AdsProvider>(
          create: (context) => AdsProvider(),
        ),
        ChangeNotifierProvider<GblProviders>(
          create: (context) => GblProviders(),
        ),
        ChangeNotifierProvider<SplashProvider>(
          create: (context) => SplashProvider(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider<ChatProviders>(
          create: (context) => ChatProviders(),
        ),
        Provider<RouteObserver<Route<dynamic>>>(
          create: (context) => RouteObserver<Route<dynamic>>(),
        ),
      ],
      child: MaterialApp(
        title: 'Stranger Chat',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: AppColors().kwhite,
          appBarTheme: AppBarTheme(
              titleTextStyle: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                fontFamily: 'SFProDisplay',
              ),
              backgroundColor: AppColors().kprimary,
              surfaceTintColor: AppColors().kprimary,
              foregroundColor: AppColors().kwhite),
          useMaterial3: true,
          fontFamily: 'SFProDisplay',
          scaffoldBackgroundColor: AppColors().kprimary,
          brightness: Brightness.dark,
        ),
        home: Builder(builder: (context) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            Provider.of<GblProviders>(context, listen: false)
                .socketInitialize();
          });
          return const SplashScreen();
        }),
      ),
    );
  }
}
