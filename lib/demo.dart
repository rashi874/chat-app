import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:zchatapp/ads_provider.dart';
import 'package:zchatapp/chat_screen.dart';

import 'ope_ads.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

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
      appBar: AppBar(
        titleSpacing: 6,
        title: const Text(
          'Stranger Chat',
          style: TextStyle(
              color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
              onPressed: () {
                showAd();
              },
              icon: const Icon(
                Icons.search,
                // color: Colors.white,
              )),
        ],
      ),
      // backgroundColor: const Color(0xFF171717),
      body: Consumer<AdsProvider>(builder: (context, appservices, _) {
        return ListView(
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     // IconButton(
            //     //     onPressed: () {
            //     //       _globalKey.currentState!.openDrawer();
            //     //     },
            //     //     icon: const Icon(
            //     //       Icons.menu,
            //     //       // color: Colors.white,
            //     //     )),

            //   ],
            // ),
            SizedBox(
              height: 50,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  TextButton(
                      onPressed: () {
                        showAd();
                      },
                      child: const Text(
                        "Messages",
                        style: TextStyle(color: Colors.white, fontSize: 17),
                      )),
                  const SizedBox(
                    width: 22,
                  ),
                  TextButton(
                      onPressed: () {
                        showAd();
                      },
                      child: const Text(
                        "Online",
                        style: TextStyle(color: Colors.grey, fontSize: 17),
                      )),
                  const SizedBox(
                    width: 22,
                  ),
                  TextButton(
                      onPressed: () {
                        showAd();
                      },
                      child: const Text(
                        "Groups",
                        style: TextStyle(color: Colors.grey, fontSize: 17),
                      )),
                  const SizedBox(
                    width: 22,
                  ),
                  TextButton(
                      onPressed: () {
                        showAd();
                      },
                      child: const Text(
                        "More",
                        style: TextStyle(color: Colors.grey, fontSize: 17),
                      )),
                  const SizedBox(
                    width: 22,
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Favorite contacts",
                        style: TextStyle(color: Colors.white),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.more_horiz,
                            color: Colors.white,
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 110,
                  // width: double.infinity,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      buildContactAvatar('Alla', 'img1.jpeg'),
                      buildContactAvatar('July', 'img2.jpeg'),
                      buildContactAvatar('Mikle', 'img3.jpeg'),
                      buildContactAvatar('Kler', 'img4.jpg'),
                      buildContactAvatar('Moane', 'img5.jpeg'),
                      buildContactAvatar('Julie', 'img6.jpeg'),
                      buildContactAvatar('Allen', 'img7.jpeg'),
                      buildContactAvatar('John', 'img8.jpg'),
                    ],
                  ),
                )
              ],
            ),
            appservices.isinlineBannerAdAdLoaded1
                ? Material(
                    borderRadius: BorderRadius.circular(5),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SizedBox(
                        height:
                            appservices.inlineBannerAd1?.size.height.toDouble(),
                        width:
                            appservices.inlineBannerAd1?.size.width.toDouble(),
                        child: AdWidget(ad: appservices.inlineBannerAd1!),
                      ),
                    ),
                  )
                : const SizedBox(
                    height: 1,
                  ),
            const Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                "Conversations",
                style: TextStyle(color: Colors.white),
              ),
            ),
            ListView(
              physics: const ScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.only(left: 5),
              children: [
                buildConversationRow(
                    'Laura', 'Hello, how are you', 'img1.jpeg', 0, context),
                buildConversationRow(
                    'Kalya', 'Will you visit me', 'img2.jpeg', 2, context),
                buildConversationRow(
                    'Mary', 'I ate your ...', 'img3.jpeg', 6, context),
                buildConversationRow('Hellen', 'Are you with Kayla again',
                    'img5.jpeg', 0, context),
                buildConversationRow(
                    'Louren', 'Barrow money please', 'img6.jpeg', 3, context),
                buildConversationRow(
                    'Tom', 'Hey, whatsup', 'img7.jpeg', 0, context),
                buildConversationRow(
                    'Laura', 'Helle, how are you', 'img1.jpeg', 0, context),
                buildConversationRow(
                    'Laura', 'Helle, how are you', 'img1.jpeg', 0, context),
              ],
            )
          ],
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: SizedBox(
        height: 65,
        width: 65,
        child: FloatingActionButton(
          // backgroundColor: Color.fromARGB(255, 113, 219, 197),
          child: const Icon(
            Icons.person_add_alt,
            size: 30,
          ),
          onPressed: () {
            showAd();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const Newcontact()));
          },
        ),
      ),
      // drawer: Drawer(
      //   width: 275,
      //   elevation: 30,
      //   backgroundColor: Color(0xF3393838),
      //   shape: const RoundedRectangleBorder(
      //       borderRadius: BorderRadius.horizontal(right: Radius.circular(40))),
      //   child: Container(
      //     decoration: const BoxDecoration(
      //         borderRadius: BorderRadius.horizontal(right: Radius.circular(40)),
      //         boxShadow: [
      //           BoxShadow(
      //               color: Color(0x3D000000), spreadRadius: 30, blurRadius: 20)
      //         ]),
      //     child: Padding(
      //       padding: const EdgeInsets.fromLTRB(20, 50, 20, 20),
      //       child: Column(
      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //         children: [
      //           Column(
      //             children: [
      //               Row(
      //                 children: const [
      //                   Icon(
      //                     Icons.arrow_back_ios,
      //                     color: Colors.white,
      //                     size: 20,
      //                   ),
      //                   SizedBox(
      //                     width: 56,
      //                   ),
      //                   Text(
      //                     'Settings',
      //                     style: TextStyle(color: Colors.white, fontSize: 16),
      //                   ),
      //                 ],
      //               ),
      //               const SizedBox(
      //                 height: 30,
      //               ),
      //               Row(
      //                 children: const [
      //                   UserAvatar(filename: 'img3.jpeg'),
      //                   SizedBox(
      //                     width: 12,
      //                   ),
      //                   Text(
      //                     'Tom Brenan',
      //                     style: TextStyle(color: Colors.white),
      //                   )
      //                 ],
      //               ),
      //               const SizedBox(
      //                 height: 35,
      //               ),
      //               const DrawerItem(
      //                 title: 'Account',
      //                 icon: Icons.key,
      //               ),
      //               const DrawerItem(title: 'Chats', icon: Icons.chat_bubble),
      //               const DrawerItem(
      //                   title: 'Notifications', icon: Icons.notifications),
      //               const DrawerItem(
      //                   title: 'Data and Storage', icon: Icons.storage),
      //               const DrawerItem(title: 'Help', icon: Icons.help),
      //               const Divider(
      //                 height: 35,
      //                 color: Colors.green,
      //               ),
      //               const DrawerItem(
      //                   title: 'Invite a friend', icon: Icons.people_outline),
      //             ],
      //           ),
      //           const DrawerItem(title: 'Log out', icon: Icons.logout)
      //         ],
      //       ),
      //     ),
      //   ),
      // ),
    );
  }

  Column buildConversationRow(
      String name, String message, String filename, int msgCount, context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            showAd();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const ChatPage(username: 'username', room: '')));
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
                          style: const TextStyle(color: Colors.grey),
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
                          backgroundColor:
                              const Color.fromARGB(255, 193, 119, 39),
                          child: Text(
                            msgCount.toString(),
                            style: const TextStyle(
                                fontSize: 10, color: Colors.white),
                          ),
                        )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        // const Divider(
        //   indent: 70,
        //   height: 20,
        // )
      ],
    );
  }

  Padding buildContactAvatar(String name, String filename) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      child: Column(
        children: [
          UserAvatar(
            filename: filename,
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            name,
            style: const TextStyle(color: Colors.white, fontSize: 14),
          )
        ],
      ),
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
              color: Colors.white,
              size: 20,
            ),
            const SizedBox(
              width: 40,
            ),
            Text(
              title,
              style: const TextStyle(color: Colors.white, fontSize: 16),
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
      backgroundColor: const Color.fromARGB(255, 94, 91, 91),
      child: CircleAvatar(
        radius: 29,
        backgroundImage: Image.asset('assets/images/$filename').image,
      ),
    );
  }
}

class Newcontact extends StatelessWidget {
  const Newcontact({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final prov = Provider.of<AdsProvider>(context, listen: false);
      AdsProvider().inlineBannerAd4?.dispose();
      prov.createInlineBannerAd4(context);
    });
    return Consumer<AdsProvider>(builder: (context, appservices, _) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('New contacts'),
        ),
        body: ListView(
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 5),
          children: [
            appservices.isinlineBannerAdAdLoaded4
                ? Material(
                    borderRadius: BorderRadius.circular(5),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SizedBox(
                        height:
                            appservices.inlineBannerAd4?.size.height.toDouble(),
                        width:
                            appservices.inlineBannerAd4?.size.width.toDouble(),
                        child: AdWidget(ad: appservices.inlineBannerAd4!),
                      ),
                    ),
                  )
                : const SizedBox(
                    height: 1,
                  ),
            buildConversationRow(
                'Laura', 'Hello, how are you', 'img1.jpeg', 0, context),
            buildConversationRow(
                'Kalya', 'Will you visit me', 'img2.jpeg', 2, context),
            buildConversationRow(
                'Mary', 'I ate your ...', 'img3.jpeg', 6, context),
            buildConversationRow(
                'Hellen', 'Are you with Kayla again', 'img5.jpeg', 0, context),
            buildConversationRow(
                'Louren', 'Barrow money please', 'img6.jpeg', 3, context),
            buildConversationRow(
                'Tom', 'Hey, whatsup', 'img7.jpeg', 0, context),
            buildConversationRow(
                'Laura', 'Helle, how are you', 'img1.jpeg', 0, context),
            buildConversationRow(
                'Laura', 'Helle, how are you', 'img1.jpeg', 0, context),
          ],
        ),
      );
    });
  }

  Column buildConversationRow(
      String name, String message, String filename, int msgCount, context) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            showAd();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const ChatPage(username: 'username', room: '')));
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
                          style: const TextStyle(color: Colors.grey),
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
                          backgroundColor:
                              const Color.fromARGB(255, 193, 119, 39),
                          child: Text(
                            msgCount.toString(),
                            style: const TextStyle(
                                fontSize: 10, color: Colors.white),
                          ),
                        )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        // const Divider(
        //   indent: 70,
        //   height: 20,
        // )
      ],
    );
  }
}
