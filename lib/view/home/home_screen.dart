import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:zchatapp/controller/ads_provider.dart';
import 'package:zchatapp/controller/user_provider.dart';
import 'package:zchatapp/util/themes.dart';
import 'package:zchatapp/view/const.dart';
import 'package:zchatapp/view/home/connect_screen.dart';
import 'package:zchatapp/view/home/shimmer.dart';
import 'package:zchatapp/view/home/widget/custom_drawer.dart';
import 'package:zchatapp/view/home/widget/transition.dart';
import 'package:zchatapp/view/login/login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AdsProvider? adsProvider;

  @override
  void dispose() {
    adsProvider?.inlineBannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<UserProvider>(context, listen: false).getuser();
      adsProvider?.bannerAd1?.dispose();
      adsProvider?.inlineBannerAd?.dispose();
      adsProvider = Provider.of<AdsProvider>(context, listen: false);
      adsProvider?.homescreenInlineBannerAd(context);
    });

    return Scaffold(
      appBar: AppBar(
        // leadingWidth: 40,
        title: Text(
          'S',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors().kwhite,
          ),
        ),

        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 13),
            child: IconButton.outlined(
                color: AppColors().kwhite.withOpacity(0.6),
                highlightColor: AppColors().kwhite.withOpacity(0.6),
                onPressed: () {
                  Navigator.push(
                    context,
                    SlideTransitionExample(page: const CustomDrawer()),
                  );
                },
                icon: const Icon(
                  Icons.person,
                  size: 25,
                )),
          ),
        ],
      ),
      body: Consumer2<AdsProvider, UserProvider>(
        builder: (context, adsProvider, user, _) {
          return ListView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(18),
            children: [
              Sizes.spacerh10,
              // Container(
              //   height: 100,
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(18),
              //       image: const DecorationImage(
              //           image: NetworkImage(
              //               'https://dexatel.com/images/blog/39/cover/how-to-text-a-gif.webp'),
              //           fit: BoxFit.cover)),
              // ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Sizes.spacerh20,
                  const Text(
                    'Hello,',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  user.userdata?.name != null
                      ? Text(
                          user.userdata?.name ?? ' ',
                          style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              wordSpacing: 3,
                              foreground: Paint()..shader = linearGradient),
                        )
                      : Shimmer.fromColors(
                          baseColor: const Color.fromARGB(36, 51, 51, 51),
                          highlightColor:
                              const Color.fromARGB(119, 133, 133, 133),
                          direction: ShimmerDirection.ltr,
                          child: ShimmerContainer(
                              height: 20,
                              width: 120,
                              borderRadius: BorderRadius.circular(5),
                              margin: const EdgeInsets.symmetric(vertical: 5))),
                  Sizes.spacerh5,
                  const Text(
                    'Effortless Social Connections',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 13,
                    ),
                  ),
                  Sizes.spacerh40,
                  Sizes.spacerh40,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const Text(
                      'Statistics',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Sizes.spacerh10,
                ],
              ),

              Container(
                  height: 190,
                  padding: const EdgeInsets.all(25.0),
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'People',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Icon(Icons.align_vertical_bottom)
                        ],
                      ),
                      Sizes.spacerh20,
                      Row(
                        children: [
                          const Text(
                            '2456',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Sizes.spacerw10,
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                                color: Color.fromARGB(157, 255, 255, 255),
                                borderRadius: BorderRadius.circular(18)),
                            child: Text(
                              'New',
                              style: TextStyle(
                                color: AppColors().kblack,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Counts(
                            title: 'Male',
                            count: '1056',
                          ),
                          Counts(
                            title: 'Female',
                            count: '1026',
                          ),
                          Counts(
                            title: 'Other',
                            count: '194',
                          ),
                        ],
                      ),
                    ],
                  )),
              Sizes.spacerh20,
              SizedBox(
                height: 42,
                child: ElevatedButton(
                  style: ButtonStyle(
                    shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25))),
                    elevation: const MaterialStatePropertyAll(0),
                    backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(194, 255, 251, 0),
                    ),
                    foregroundColor: MaterialStateProperty.all(
                      AppColors().kblack,
                    ),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.only(bottom: 0.5),
                    child: Text(
                      'Connect ',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  onPressed: () {
                    // showAd();
                    Navigator.push(
                      context,
                      SlideTransitionExample(
                        page: const ConnectScreen(),
                      ),
                    );
                  },
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Sizes.spacerh20,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // if (adsProvider.inlineBannerAd != null &&
                      //     adsProvider.isLoaded2 == true)
                      //   Material(
                      //     color: AppColors().kprimary,
                      //     shape: RoundedRectangleBorder(
                      //       borderRadius: BorderRadius.circular(13),
                      //     ),
                      //     clipBehavior: Clip.antiAlias,
                      //     child: SizedBox(
                      //       width: adsProvider.inlineBannerAd!.size.width
                      //           .toDouble(),
                      //       height: adsProvider.inlineBannerAd!.size.height
                      //           .toDouble(),
                      //       child: AdWidget(ad: adsProvider.inlineBannerAd!),
                      //     ),
                      //   ),
                      Sizes.spacerh10,
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: const Text(
                          'Introducing Stranger chats, the ultimate chat app where anonymity meets genuine connections. ',
                          style: TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}

class Counts extends StatelessWidget {
  const Counts({
    super.key,
    required this.title,
    required this.count,
  });
  final String title;
  final String count;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          textAlign: TextAlign.start,
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
              color: AppColors().kwhite.withOpacity(0.5)),
        ),
        Sizes.spacerw10,
        Text(
          count,
          textAlign: TextAlign.start,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
