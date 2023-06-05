import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:zchatapp/controller/ads_provider.dart';
import 'package:zchatapp/util/socket_manager.dart';
import 'package:zchatapp/view/chatscreen/chat_screen.dart';
import 'package:zchatapp/view/const.dart';
import 'package:zchatapp/view/home/connect_screen.dart';
import 'package:zchatapp/view/home/widget/custom_drawer.dart';

import '../../ads/ope_ads.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final prov = Provider.of<AdsProvider>(context, listen: false);
      AdsProvider().inlineBannerAd1?.dispose();
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
                size: 10,
                color: Colors.green,
              ),
              SizedBox(
                width: 16,
              ),
            ],
          ),
        ],
      ),
      body: Consumer<AdsProvider>(builder: (context, appservices, _) {
        return Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              padding: const EdgeInsets.all(8),
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: const DecorationImage(
                      image: AssetImage(
                        'assets/images/i.gif',
                      ),
                      fit: BoxFit.cover)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Sizes.spacerh20,
                  // appservices.isinlineBannerAdAdLoaded1
                  //     ? Material(
                  //         borderRadius: BorderRadius.circular(10),
                  //         child: Padding(
                  //           padding: const EdgeInsets.all(5.0),
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
                  Text(
                    'Strangers Are Friends You Just Have Not yet Met',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 29, 29, 29),
                    ),
                  ),
                  Sizes.spacerh10,
                  Text(
                    'There is a saying that strangers are friends you just not yet have met. To chat with strangers on the Internet is a great way to find new friends. Maybe you have a dilemma and no one to discuss it with. A stranger, who you can chat completely honest with, can sometimes be the best person to chat with for advice.',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(255, 31, 31, 31),
                    ),
                  ),
                ],
              ),
            ),
            // Container(
            //   margin: const EdgeInsets.all(8),
            //   padding: const EdgeInsets.all(18),
            //   decoration: BoxDecoration(
            //       color: Color.fromARGB(249, 75, 84, 51),
            //       borderRadius: BorderRadius.circular(20)),
            //   child: const Column(
            //     children: [
            //       Text(
            //         'Strangers Are Friends You Just Have Not yet Met',
            //         style: TextStyle(
            //           fontSize: 20,
            //           fontWeight: FontWeight.bold,
            //           color: Color.fromARGB(255, 233, 233, 233),
            //         ),
            //       ),
            //       Sizes.spacerh10,
            //       Text(
            //         'There is a saying that strangers are friends you just not yet have met. To chat with strangers on the Internet is a great way to find new friends. Maybe you have a dilemma and no one to discuss it with. A stranger, who you can chat completely honest with, can sometimes be the best person to chat with for advice.',
            //         style: TextStyle(
            //           fontSize: 12,
            //           fontWeight: FontWeight.w500,
            //           color: Color.fromARGB(255, 229, 227, 227),
            //         ),
            //       ),
            //       Sizes.spacerh10,
            //     ],
            //   ),
            // ),
            // Container(
            //   margin: const EdgeInsets.all(8),
            //   padding: const EdgeInsets.all(18),
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(20),
            //       image: DecorationImage(
            //           image: NetworkImage(
            //               'https://blog.intercomassets.com/blog/wp-content/uploads/2023/01/Live-chat-support-2.jpg.optimal.jpg'),
            //           fit: BoxFit.cover)),
            //   child: const Column(
            //     children: [
            //       Text(
            //         'Strangers Are Friends You Just Have Not yet Met',
            //         style: TextStyle(
            //           fontSize: 20,
            //           fontWeight: FontWeight.bold,
            //           color: Color.fromARGB(255, 233, 233, 233),
            //         ),
            //       ),
            //       Sizes.spacerh10,
            //       Text(
            //         'There is a saying that strangers are friends you just not yet have met. To chat with strangers on the Internet is a great way to find new friends. Maybe you have a dilemma and no one to discuss it with. A stranger, who you can chat completely honest with, can sometimes be the best person to chat with for advice.',
            //         style: TextStyle(
            //           fontSize: 12,
            //           fontWeight: FontWeight.w500,
            //           color: Color.fromARGB(255, 229, 227, 227),
            //         ),
            //       ),
            //       Sizes.spacerh10,
            //     ],
            //   ),
            // ),
            // Spacer(),
            Container(
              height: 200,
              width: double.infinity,
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://mir-s3-cdn-cf.behance.net/project_modules/hd/8af13a133820975.61c6d7982927e.jpg'),
                      fit: BoxFit.cover)),
              child: Container(
                child: const Text(
                  'Connect with Strangers',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 33, 33, 33),
                  ),
                ),
              ),
            )
          ],
        );
      }),
      floatingActionButton: ElevatedButton.icon(
          label: Padding(
            padding: const EdgeInsets.only(bottom: 3.5),
            child: const Text(
              'Connect',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          onPressed: () {
            // showAd();

            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ConnectScreen()));
          },
          icon: const Icon(
            Icons.multiple_stop_sharp,
            color: Colors.white,
            size: 22,
          )),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String title;
  final IconData icon;
  const DrawerItem({
    super.key,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(bottom: 25),
        child: Row(
          children: [
            Icon(
              icon,
              // color: Colors.white,
              size: 20,
            ),
            const SizedBox(
              width: 40,
            ),
            Text(
              title,
              style: const TextStyle(
                  // color: Colors.white,
                  fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

class UserAvatar extends StatelessWidget {
  final String filename;
  const UserAvatar({
    super.key,
    required this.filename,
  });

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 32,
      // backgroundColor: const Color.fromARGB(255, 94, 91, 91),
      child: CircleAvatar(
        radius: 29,
        backgroundImage: Image.asset('assets/images/$filename').image,
      ),
    );
  }
}

// class Newcontact extends StatelessWidget {
//   const Newcontact({super.key});

//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       final prov = Provider.of<AdsProvider>(context, listen: false);
//       AdsProvider().inlineBannerAd4?.dispose();
//       prov.createInlineBannerAd4(context);
//     });
//     return Consumer<AdsProvider>(builder: (context, appservices, _) {
//       return Scaffold(
//         appBar: AppBar(
//           title: const Text('Chat'),
//         ),
//         body: ListView(
//           physics: const ScrollPhysics(),
//           shrinkWrap: true,
//           padding: const EdgeInsets.only(left: 5),
//           children: [
//             appservices.isinlineBannerAdAdLoaded4
//                 ? Material(
//                     borderRadius: BorderRadius.circular(5),
//                     child: Padding(
//                       padding: const EdgeInsets.all(5.0),
//                       child: SizedBox(
//                         height:
//                             appservices.inlineBannerAd4?.size.height.toDouble(),
//                         width:
//                             appservices.inlineBannerAd4?.size.width.toDouble(),
//                         child: AdWidget(ad: appservices.inlineBannerAd4!),
//                       ),
//                     ),
//                   )
//                 : const SizedBox(
//                     height: 1,
//                   ),
//             // Lottie.asset('assets/images/141560-loader-v25.json'),
//           ],
//         ),
//       );
//     });
//   }

Column buildConversationRow(
    String name, String message, String filename, int msgCount, context) {
  return Column(
    children: [
      InkWell(
        onTap: () {
          showAd();
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ChatPage()));
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  UserAvatar(filename: filename),
                  const SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        // style: const TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        message,
                        // style: const TextStyle(color: Colors.black),
                      ),
                    ],
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 25, top: 5),
                child: Column(
                  children: [
                    const Text(
                      '16:35',
                      style: TextStyle(fontSize: 10),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    if (msgCount > 0)
                      CircleAvatar(
                        radius: 7,
                        // backgroundColor:
                        // const Color.fromARGB(255, 193, 119, 39),
                        child: Text(
                          msgCount.toString(),
                          style: const TextStyle(
                            fontSize: 10,
                            // color: Colors.white
                          ),
                        ),
                      )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      const Divider(
        indent: 70,
        height: 20,
      )
    ],
  );
}
