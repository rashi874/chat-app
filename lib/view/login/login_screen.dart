import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:zchatapp/controller/ads_provider.dart';
import 'package:zchatapp/controller/global_provider.dart';
import 'package:zchatapp/util/themes.dart';
import 'package:zchatapp/view/const.dart';
import 'package:zchatapp/view/login/widgets.dart';

bool genderSelect = false;
final Shader linearGradient = const LinearGradient(
  colors: <Color>[
    Color.fromARGB(185, 255, 255, 255),
    Color.fromARGB(211, 252, 251, 169),
  ],
).createShader(const Rect.fromLTWH(0.0, 0.0, 300.0, 70.0));

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  AdsProvider? adsProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    adsProvider = Provider.of<AdsProvider>(context, listen: false);
    adsProvider?.bannerAd1?.dispose();
    adsProvider!.createInlineloginBanner(context);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<GblProviders, AdsProvider>(
      builder: (BuildContext context, value, appservices, _) {
        return Scaffold(
          extendBody: true,
          appBar: AppBar(
            title: Text(
              'S',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors().kwhite,
              ),
            ),
          ),
          body: SafeArea(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(18),
              children: [
                Sizes.spacerh40,
                Sizes.spacerh10,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'STRANGER CHATS',
                      style: TextStyle(
                        fontSize: 18,
                        letterSpacing: 3.2,
                        fontWeight: FontWeight.bold,
                        color: AppColors().kwhite.withOpacity(0.8),
                      ),
                    ),
                    Sizes.spacerh20,
                    Text(
                      'Build Connections & Enjoy\nUnlimited Conversations  ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 29,
                          wordSpacing: 2,
                          letterSpacing: -1.0,
                          fontWeight: FontWeight.w900,
                          foreground: Paint()..shader = linearGradient),
                    ),
                    Sizes.spacerh40,
                    Sizes.spacerh30,
                    Text(
                      'Choose Gender',
                      style: TextStyle(
                          fontSize: 17,
                          letterSpacing: -0.5,
                          fontWeight: FontWeight.bold,
                          color: AppColors().kwhite.withOpacity(0.7)),
                    ),
                    Sizes.spacerh20,
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color.fromARGB(66, 85, 85, 85),
                          Color.fromARGB(57, 231, 231, 231),
                          Color.fromARGB(33, 219, 219, 219),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(35)),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 25.0, vertical: 10),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Center(child: Icon(Icons.remove)),
                      Sizes.spacerh20,
                      GenderSelector(),
                      Sizes.spacerh10,
                    ],
                  ),
                ),
                Sizes.spacerh30,
                SizedBox(
                  height: 42,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStatePropertyAll(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(19),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        Color.fromARGB(194, 255, 251, 0),
                      ),
                      elevation: const MaterialStatePropertyAll(0),
                      surfaceTintColor: MaterialStateProperty.all(
                        AppColors().kblue,
                      ),
                    ),
                    onPressed: () {
                      log(genderSelect.toString());
                      if (genderSelect) {
                        value.signupUser(context);
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 3.0),
                      child: Text(
                        'Continue',
                        style: TextStyle(
                          color: AppColors().kblack,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Sizes.spacerh20,
                // appservices.bannerAd1 != null && appservices.isLoaded1 == true
                //     ? Center(
                //         child: Material(
                //             color: AppColors().kprimary,
                //             shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(8),
                //             ),
                //             clipBehavior: Clip.antiAlias,
                //             child: SizedBox(
                //               width: appservices.bannerAd1!.sizes[0].width
                //                   .toDouble(),
                //               height: appservices.bannerAd1!.sizes[0].height
                //                   .toDouble(),
                //               child: AdWidget(ad: appservices.bannerAd1!),
                //             )),
                //       )
                //     : Sizes.spacerh20,
              ],
            ),
          ),
        );
      },
    );
  }
}
