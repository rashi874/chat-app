// import 'package:flutter/material.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
// import 'package:lottie/lottie.dart';
// import 'package:provider/provider.dart';
// import 'package:zchatapp/controller/ads_provider.dart';
// import 'package:zchatapp/view/chatscreen/chat_screen.dart';
// import 'package:zchatapp/view/home/widget/custom_drawer.dart';

// import '../../ads/ope_ads.dart';

// class HomeScreen extends StatelessWidget {
//   HomeScreen({super.key});

//   final GlobalKey<ScaffoldState> _globalKey = GlobalKey();

//   @override
//   Widget build(BuildContext context) {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       final prov = Provider.of<AdsProvider>(context, listen: false);
//       AdsProvider().inlineBannerAd1?.dispose();
//       prov.createInlineBannerAd(context);
//     });
//     return Scaffold(
//       key: _globalKey,
//       appBar: AppBar(
//         titleSpacing: 6,
//         title: const Text(
//           'Stranger Chat',
//           // style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//         ),
//         actions: [
//           // IconButton(
//           //     onPressed: () {
//           //       showAd();
//           //     },
//           //     icon: const Icon(
//           //       Icons.search,
//           //       // color: Colors.white,
//           //     )),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             children: [
//               Icon(
//                 Icons.circle,
//                 size: 12,
//                 color: Colors.green,
//               ),
//               SizedBox(
//                 width: 16,
//               ),
//               // Text('Online'),
//               // SizedBox(
//               //   width: 5,
//               // ),
//             ],
//           ),
//         ],
//       ),
//       // backgroundColor: const Color(0xFF171717),
//       body: Consumer<AdsProvider>(builder: (context, appservices, _) {
//         return Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text('Connect with Strangers'),
//             Lottie.asset('assets/images/94789-chat-animation.json'),
//             Lottie.asset('assets/images/121850-chat-shimmer.json'),
//             // Row(
//             //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             //   children: [
//             //     IconButton(
//             //         onPressed: () {
//             //           _globalKey.currentState!.openDrawer();
//             //         },
//             //         icon: const Icon(
//             //           Icons.menu,
//             //           // color: Colors.white,
//             //         )),
//             //   ],
//             // ),
//             // SizedBox(
//             //   height: 50,
//             //   child: ListView(
//             //     scrollDirection: Axis.horizontal,
//             //     children: [
//             //       TextButton(
//             //           onPressed: () {
//             //             showAd();
//             //           },
//             //           child: const Text(
//             //             "Messages",
//             //             // style: TextStyle(color: Colors.white, fontSize: 17),
//             //           )),
//             //       const SizedBox(
//             //         width: 22,
//             //       ),
//             //       TextButton(
//             //           onPressed: () {
//             //             showAd();
//             //           },
//             //           child: const Text(
//             //             "Online",
//             //             // style: TextStyle(color: Colors.grey, fontSize: 17),
//             //           )),
//             //       const SizedBox(
//             //         width: 22,
//             //       ),
//             //       TextButton(
//             //           onPressed: () {
//             //             showAd();
//             //           },
//             //           child: const Text(
//             //             "Groups",
//             //             // style: TextStyle(color: Colors.grey, fontSize: 17),
//             //           )),
//             //       const SizedBox(
//             //         width: 22,
//             //       ),
//             //       TextButton(
//             //           onPressed: () {
//             //             showAd();
//             //           },
//             //           child: const Text(
//             //             "More",
//             //             // style: TextStyle(color: Colors.grey, fontSize: 17),
//             //           )),
//             //       const SizedBox(
//             //         width: 22,
//             //       ),
//             //     ],
//             //   ),
//             // ),
//             // Column(
//             //   children: [
//             //     Padding(
//             //       padding: const EdgeInsets.symmetric(horizontal: 10.0),
//             //       child: Row(
//             //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             //         children: [
//             //           const Text(
//             //             "Favorite contacts",
//             //             // style: TextStyle(color: Colors.white),
//             //           ),
//             //           IconButton(
//             //               onPressed: () {},
//             //               icon: const Icon(
//             //                 Icons.more_horiz,
//             //                 // color: Colors.white,
//             //               )),
//             //         ],
//             //       ),
//             //     ),
//             //     SizedBox(
//             //       height: 110,
//             //       // width: double.infinity,
//             //       child: ListView(
//             //         scrollDirection: Axis.horizontal,
//             //         children: [
//             //           buildContactAvatar('Alla', 'img1.jpeg'),
//             //           buildContactAvatar('July', 'img2.jpeg'),
//             //           buildContactAvatar('Mikle', 'img3.jpeg'),
//             //           buildContactAvatar('Kler', 'img4.jpg'),
//             //           buildContactAvatar('Moane', 'img5.jpeg'),
//             //           buildContactAvatar('Julie', 'img6.jpeg'),
//             //           buildContactAvatar('Allen', 'img7.jpeg'),
//             //           buildContactAvatar('John', 'img8.jpg'),
//             //         ],
//             //       ),
//             //     )
//             //   ],
//             // ),
//             // appservices.isinlineBannerAdAdLoaded1
//             //     ? Material(
//             //         borderRadius: BorderRadius.circular(5),
//             //         child: Padding(
//             //           padding: const EdgeInsets.all(5.0),
//             //           child: SizedBox(
//             //             height:
//             //                 appservices.inlineBannerAd1?.size.height.toDouble(),
//             //             width:
//             //                 appservices.inlineBannerAd1?.size.width.toDouble(),
//             //             child: AdWidget(ad: appservices.inlineBannerAd1!),
//             //           ),
//             //         ),
//             //       )
//             //     : const SizedBox(
//             //         height: 1,
//             //       ),
//             // const Padding(
//             //   padding: EdgeInsets.all(10.0),
//             //   child: Row(
//             //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             //     children: [
//             //       Text(
//             //         "Conversations",
//             //         // style: TextStyle(color: Colors.white),
//             //       ),
//             //       Icon(Icons.history_toggle_off_outlined)
//             //     ],
//             //   ),
//             // ),
//             // ListView(
//             //   physics: const ScrollPhysics(),
//             //   shrinkWrap: true,
//             //   padding: const EdgeInsets.only(left: 5),
//             //   children: [
//             //     buildConversationRow(
//             //         'Laura', 'Hello, how are you', 'img1.jpeg', 0, context),
//             //     buildConversationRow(
//             //         'Kalya', 'Will you visit me', 'img2.jpeg', 2, context),
//             //     buildConversationRow(
//             //         'Mary', 'I ate your ...', 'img3.jpeg', 6, context),
//             //     buildConversationRow('Hellen', 'Are you with Kayla again',
//             //         'img5.jpeg', 0, context),
//             //     buildConversationRow(
//             //         'Louren', 'Barrow money please', 'img6.jpeg', 3, context),
//             //     buildConversationRow(
//             //         'Tom', 'Hey, whatsup', 'img7.jpeg', 0, context),
//             //     buildConversationRow(
//             //         'Laura', 'Helle, how are you', 'img1.jpeg', 0, context),
//             //     buildConversationRow(
//             //         'Laura', 'Helle, how are you', 'img1.jpeg', 0, context),
//             //   ],
//             // )
//           ],
//         );
//       }),
//       // floatingActionButtonLocation:
//       //     FloatingActionButtonLocation.miniCenterDocked,
//       floatingActionButton: SizedBox(
//         // height: 65,
//         width: 140,
//         child: FloatingActionButton(
//           // backgroundColor: Color.fromARGB(255, 113, 219, 197),
//           child: Padding(
//             padding: const EdgeInsets.only(left: 20.0, right: 10),
//             child: Row(
//               children: [
//                 Text(
//                   'Connect',
//                   style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
//                 ),
//                 SizedBox(
//                   width: 10,
//                 ),
//                 const Icon(
//                   Icons.connect_without_contact,
//                   size: 30,
//                 ),
//               ],
//             ),
//           ),
//           onPressed: () {
//             showAd();
//             Navigator.push(context,
//                 MaterialPageRoute(builder: (context) => const Newcontact()));
//           },
//         ),
//       ),
//       drawer: CustomDrawer(),
//     );
//   }

//   Column buildConversationRow(
//       String name, String message, String filename, int msgCount, context) {
//     return Column(
//       children: [
//         InkWell(
//           onTap: () {
//             showAd();
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) =>
//                         const ChatPage(username: 'username', room: '')));
//           },
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     UserAvatar(filename: filename),
//                     const SizedBox(
//                       width: 15,
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           name,
//                           // style: const TextStyle(color: Colors.grey),
//                         ),
//                         const SizedBox(
//                           height: 5,
//                         ),
//                         Text(
//                           message,
//                           // style: const TextStyle(color: Colors.black),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(right: 10, top: 5),
//                   child: Column(
//                     children: [
//                       const Text(
//                         '16:35',
//                         style: TextStyle(fontSize: 10),
//                       ),
//                       const SizedBox(
//                         height: 15,
//                       ),
//                       if (msgCount > 0)
//                         CircleAvatar(
//                           radius: 7,
//                           // backgroundColor:
//                           //     const Color.fromARGB(255, 193, 119, 39),
//                           child: Text(
//                             msgCount.toString(),
//                             style: const TextStyle(
//                               fontSize: 10,
//                               //  color: Colors.white
//                             ),
//                           ),
//                         )
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//         // const Divider(
//         //   indent: 70,
//         //   height: 20,
//         // )
//       ],
//     );
//   }

//   Padding buildContactAvatar(String name, String filename) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
//       child: Column(
//         children: [
//           UserAvatar(
//             filename: filename,
//           ),
//           const SizedBox(
//             height: 5,
//           ),
//           Text(
//             name,
//             style: const TextStyle(
//                 // color: Colors.white,
//                 fontSize: 14),
//           )
//         ],
//       ),
//     );
//   }
// }

// class DrawerItem extends StatelessWidget {
//   final String title;
//   final IconData icon;
//   const DrawerItem({
//     super.key,
//     required this.title,
//     required this.icon,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {},
//       child: Padding(
//         padding: const EdgeInsets.only(bottom: 25),
//         child: Row(
//           children: [
//             Icon(
//               icon,
//               // color: Colors.white,
//               size: 20,
//             ),
//             const SizedBox(
//               width: 40,
//             ),
//             Text(
//               title,
//               style: const TextStyle(
//                   // color: Colors.white,
//                   fontSize: 16),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class UserAvatar extends StatelessWidget {
//   final String filename;
//   const UserAvatar({
//     super.key,
//     required this.filename,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return CircleAvatar(
//       radius: 32,
//       // backgroundColor: const Color.fromARGB(255, 94, 91, 91),
//       child: CircleAvatar(
//         radius: 29,
//         backgroundImage: Image.asset('assets/images/$filename').image,
//       ),
//     );
//   }
// }

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
//           title: const Text('New contacts'),
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
//             buildConversationRow(
//                 'Laura', 'Hello, how are you', 'img1.jpeg', 0, context),
//             buildConversationRow(
//                 'Kalya', 'Will you visit me', 'img2.jpeg', 2, context),
//             buildConversationRow(
//                 'Mary', 'I ate your ...', 'img3.jpeg', 6, context),
//             buildConversationRow(
//                 'Hellen', 'Are you with Kayla again', 'img5.jpeg', 0, context),
//             buildConversationRow(
//                 'Louren', 'Barrow money please', 'img6.jpeg', 3, context),
//             buildConversationRow(
//                 'Tom', 'Hey, whatsup', 'img7.jpeg', 0, context),
//             buildConversationRow(
//                 'Laura', 'Helle, how are you', 'img1.jpeg', 0, context),
//             buildConversationRow(
//                 'Laura', 'Helle, how are you', 'img1.jpeg', 0, context),
//           ],
//         ),
//       );
//     });
//   }

//   Column buildConversationRow(
//       String name, String message, String filename, int msgCount, context) {
//     return Column(
//       children: [
//         InkWell(
//           onTap: () {
//             showAd();
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (context) =>
//                         const ChatPage(username: 'username', room: '')));
//           },
//           child: Padding(
//             padding: const EdgeInsets.symmetric(vertical: 8.0),
//             child: Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     UserAvatar(filename: filename),
//                     const SizedBox(
//                       width: 15,
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           name,
//                           // style: const TextStyle(color: Colors.grey),
//                         ),
//                         const SizedBox(
//                           height: 5,
//                         ),
//                         Text(
//                           message,
//                           // style: const TextStyle(color: Colors.black),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(right: 25, top: 5),
//                   child: Column(
//                     children: [
//                       const Text(
//                         '16:35',
//                         style: TextStyle(fontSize: 10),
//                       ),
//                       const SizedBox(
//                         height: 15,
//                       ),
//                       if (msgCount > 0)
//                         CircleAvatar(
//                           radius: 7,
//                           // backgroundColor:
//                           // const Color.fromARGB(255, 193, 119, 39),
//                           child: Text(
//                             msgCount.toString(),
//                             style: const TextStyle(
//                               fontSize: 10,
//                               // color: Colors.white
//                             ),
//                           ),
//                         )
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//         const Divider(
//           indent: 70,
//           height: 20,
//         )
//       ],
//     );
//   }
// }
