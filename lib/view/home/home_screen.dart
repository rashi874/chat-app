import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zchatapp/controller/ads_provider.dart';
import 'package:zchatapp/util/themes.dart';
import 'package:zchatapp/view/const.dart';
import 'package:zchatapp/view/home/connect_screen.dart';
import 'package:zchatapp/view/home/widget/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    AdsProvider().inlineBannerAd1?.dispose();
    // double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final prov = Provider.of<AdsProvider>(context, listen: false);
      prov.createInlineBannerAd(context);
    });
    return Scaffold(
      key: _globalKey,
      drawer: const CustomDrawer(),
      drawerScrimColor: Colors.transparent,
      appBar: AppBar(
        // leading: CircleAvatar(),
        titleSpacing: 6,
        title: const Text(
          'Stranger Chat',
          // style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: const [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.circle,
                size: 9,
                color: Color.fromARGB(255, 31, 201, 99),
              ),
              SizedBox(
                width: 16,
              ),
            ],
          ),
        ],
      ),
      body: Consumer<AdsProvider>(builder: (context, appservices, _) {
        return ListView(
          children: [
            Container(
              height: height / 1.2,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  image: const DecorationImage(
                    fit: BoxFit.fitHeight,
                    filterQuality: FilterQuality.high,
                    colorFilter: ColorFilter.mode(
                        Color.fromARGB(108, 248, 248, 255), BlendMode.modulate),
                    image: AssetImage('assets/images/j.jpg'),
                    // image: NetworkImage(
                    //     'https://images.unsplash.com/photo-1635268144933-4d6f7a55e0b9?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1332&q=80'),
                    // image: NetworkImage(
                    //     'https://images.unsplash.com/photo-1601588759900-6215271553cd?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=387&q=80'),
                  ),
                  color: const Color.fromARGB(8, 203, 185, 86),
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Sizes.spacerh10,
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Connect\nwith Strangers',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: AppColors().kwhite.withOpacity(0.8),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      // Sizes.spacerh10,
                      // (appservices.isinlineBannerAdAdLoaded1 &&
                      //         appservices.bannerIsLoaded)
                      //     ? Center(
                      //         child: Material(
                      //           shape: RoundedRectangleBorder(
                      //               borderRadius: BorderRadius.circular(5)),
                      //           clipBehavior: Clip.antiAlias,
                      //           child: SizedBox(
                      //             height: appservices.inlineBannerAd1?.size.height
                      //                 .toDouble(),
                      //             width: appservices.inlineBannerAd1?.size.width
                      //                 .toDouble(),
                      //             child: AdWidget(ad: appservices.inlineBannerAd1!),
                      //           ),
                      //         ),
                      //       )
                      //     : const SizedBox(
                      //         height: 1,
                      //       ),
                      Sizes.spacerh30,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: SizedBox(
                          height: 50,
                          width: double.infinity,
                          child: ElevatedButton.icon(
                              style: ButtonStyle(
                                  surfaceTintColor: MaterialStatePropertyAll(
                                      AppColors().kprimary),
                                  side: const MaterialStatePropertyAll(
                                      BorderSide(
                                          color: Color.fromARGB(
                                              248, 198, 199, 199),
                                          width: 3)),
                                  backgroundColor: MaterialStatePropertyAll(
                                      AppColors().kwhite.withOpacity(0.2))),
                              label: const Padding(
                                padding: EdgeInsets.only(bottom: 3.5),
                                child: Text(
                                  'Connect',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 241, 241, 241),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                // showAd();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ConnectScreen()));
                              },
                              icon: const Icon(
                                Icons.all_inclusive,
                                color: Color.fromARGB(255, 250, 250, 250),
                                size: 22,
                              )),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: height / 3.5,
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                        color: AppColors().kprimary.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(20)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Stranger chat app which allows you to easily start chatting with new friends',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: AppColors().kwhite.withOpacity(0.7),
                          ),
                        ),
                        Sizes.spacerh10,
                        Text(
                          'Introducing the ultimate stranger chat app, where anonymity meets connection. With our innovative platform, you can dive into engaging conversations with fascinating people from around the world, all from the comfort of your device.',
                          style: TextStyle(
                            fontSize: 10,
                            color: AppColors().kwhite.withOpacity(0.6),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
