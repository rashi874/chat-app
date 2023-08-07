import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zchatapp/controller/ads_provider.dart';
import 'package:zchatapp/controller/global_provider.dart';
import 'package:zchatapp/controller/splash_provider.dart';
import 'package:zchatapp/controller/user_provider.dart';
import 'package:zchatapp/util/themes.dart';
import 'package:zchatapp/view/const.dart';
import 'package:zchatapp/view/home/shimmer.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  late AdsProvider adsProvider;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    adsProvider = Provider.of<AdsProvider>(context, listen: false);

    // adsProvider.inlineBannerAd?.dispose();
    adsProvider.bannerAd3?.dispose();
    adsProvider.createInlineBannerAd5(context);
  }

  @override
  Widget build(BuildContext context) {
    final gbProvider = Provider.of<UserProvider>(context, listen: false);
    return Consumer2<UserProvider, AdsProvider>(
      builder: (context, value, ads, _) {
        log(value.userdata.toString());
        return Scaffold(
          appBar: AppBar(
            title: const Text(
              'Profile',
              style: TextStyle(
                fontSize: 20,
                // fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Sizes.spacerh30,
                      Container(
                        height: 140,
                        padding: const EdgeInsets.only(
                            top: 5.0, left: 15, right: 15, bottom: 10),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topRight,
                            end: Alignment.bottomLeft,
                            colors: [
                              Color.fromARGB(66, 85, 85, 85),
                              Color.fromARGB(57, 130, 128, 128),
                              Color.fromARGB(33, 219, 219, 219),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                value.userdata?.name != null
                                    ? Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Sizes.spacerh10,
                                          Row(
                                            children: [
                                              // if (value.userdata?.gender !=
                                              //     'male')
                                              //   Image.asset(
                                              //     'assets/images/e.png',
                                              //     height: 40,
                                              //   )
                                              // else
                                              //   CircleAvatar(
                                              //     radius: 28,
                                              //     backgroundColor:
                                              //         AppColors().kwhite,
                                              //     child: Padding(
                                              //       padding:
                                              //           const EdgeInsets.all(
                                              //               8.0),
                                              //       child: Image.asset(
                                              //           'assets/images/m.png'),
                                              //     ),
                                              //   ),

                                              CircleAvatar(
                                                child: Text(
                                                    value.userdata?.name[0] ??
                                                        ''),
                                              ),
                                              Sizes.spacerw10,
                                              Text(
                                                value.userdata?.name ?? '',
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Sizes.spacerw5,
                                            ],
                                          ),
                                          Sizes.spacerh10,
                                          Row(children: [
                                            value.userdata?.gender != null
                                                ? Card(
                                                    color: AppColors().kwhite,
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 10.0,
                                                          vertical: 2),
                                                      child: Text(
                                                        value.userdata!
                                                                .gender[0]
                                                                .toUpperCase() +
                                                            value.userdata!
                                                                .gender
                                                                .substring(1),
                                                        style: TextStyle(
                                                          fontSize: 14,
                                                          color: AppColors()
                                                              .kblack,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                : Shimmer.fromColors(
                                                    baseColor:
                                                        const Color.fromARGB(
                                                            36, 51, 51, 51),
                                                    highlightColor:
                                                        const Color.fromARGB(
                                                            119, 133, 133, 133),
                                                    direction:
                                                        ShimmerDirection.ltr,
                                                    child: ShimmerContainer(
                                                        height: 20,
                                                        width: 70,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        margin: const EdgeInsets
                                                                .symmetric(
                                                            vertical: 5))),
                                            Card(
                                              color: AppColors().kwhite,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10.0,
                                                        vertical: 2),
                                                child: Text(
                                                  'Standard',
                                                  style: TextStyle(
                                                    fontSize: 14,
                                                    color: AppColors().kblack,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ]),
                                        ],
                                      )
                                    : Shimmer.fromColors(
                                        baseColor: const Color.fromARGB(
                                            36, 51, 51, 51),
                                        highlightColor: const Color.fromARGB(
                                            119, 133, 133, 133),
                                        direction: ShimmerDirection.ltr,
                                        child: ShimmerContainer(
                                            height: 20,
                                            width: 120,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 5))),
                                IconButton(
                                    onPressed: () {
                                      gbProvider.updateuser();
                                      gbProvider.getuser();
                                    },
                                    icon: const Icon(Icons.edit)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Sizes.spacerh20,
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ButtonStyle(
                            elevation: MaterialStateProperty.all<double>(0),
                            backgroundColor: MaterialStateProperty.all<Color>(
                              const Color.fromARGB(194, 255, 251, 0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 3.5),
                            child: Text(
                              'Logout',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: AppColors().kblack,
                              ),
                            ),
                          ),
                          onPressed: () {
                            adsProvider.bannerAd1?.dispose();
                            adsProvider.createInlineloginBanner(context);
                            Provider.of<SplashProvider>(context, listen: false)
                                .logOut(context);
                            // showAd();
                          },
                        ),
                      ),
                    ],
                  ),
                  ads.bannerAd3 != null && ads.isLoaded3 == true
                      ? Center(
                          child: Material(
                              color: AppColors().kprimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(23),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: SizedBox(
                                width: ads.bannerAd3!.sizes[0].width.toDouble(),
                                height:
                                    ads.bannerAd3!.sizes[0].height.toDouble(),
                                child: AdWidget(ad: ads.bannerAd3!),
                              )),
                        )
                      : Sizes.spacerh20,
                  Sizes.spacerh20,
                  const Center(child: Text('Version 1.0.0.5')),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
