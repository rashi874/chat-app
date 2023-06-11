import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:zchatapp/controller/ads_provider.dart';
import 'package:zchatapp/controller/chat_provider.dart';
import 'package:zchatapp/controller/global_provider.dart';
import 'package:zchatapp/controller/user_provider.dart';
import 'package:zchatapp/util/themes.dart';
import 'package:zchatapp/view/home/connect_screen.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  ChatPageState createState() => ChatPageState();
}

class ChatPageState extends State<ChatPage> {
  late Socket? socket;
  late UserProvider? userProvider;
  late ChatProviders? chatProvider;

  bool? pairleft;
  @override
  void initState() {
    super.initState();

    userProvider = Provider.of<UserProvider>(context, listen: false);
    // final prov = Provider.of<AdsProvider>(context, listen: false);
    socket = Provider.of<GblProviders>(context, listen: false).socket;
    chatProvider = Provider.of<ChatProviders>(context, listen: false);
    final setMessage = chatProvider!.setMessage;

    if (userProvider!.randomuserdata != null) {
      socket?.emit(
        "joinChat",
        [
          userProvider!.randomuserdata!.chatId,
          userProvider!.userdata!.id,
        ],
      );
    }
    socket?.on("getMessage", (data) {
      setMessage(data);
    });
    socket?.on("onPairDisconnected", (data) {
      // user!.removeRandomUser();
      socket?.off('getMessage');
      if (userProvider?.userdata != null) {
        socket?.emit("leaveUser", userProvider?.userdata?.id);
      }
      userProvider?.paireduserleft();

      log("${data}Pair Disconnected${userProvider!.pairleft}");
    });
    // prov.createInlineBannerAd3(context);
  }

  @override
  void dispose() {
    AdsProvider().inlineBannerAd?.dispose();
    leavePage();
    super.dispose();
  }

  void leavePage() {
    socket?.emit(
      "leaveChat",
      [
        userProvider?.randomuserdata?.chatId,
        userProvider?.userdata?.id,
      ],
    );
    log('${userProvider?.randomuserdata?.chatId} ${userProvider?.userdata?.id} chat left');
    socket?.emit("leaveUser", userProvider?.userdata?.id);
    chatProvider!.clearStates();
    userProvider?.removeRandomUser();
    socket?.off('getMessage');
    socket?.off('onPairDisconnected');
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false);
    final messages =
        Provider.of<ChatProviders>(context, listen: false).messages;

    return Consumer3<AdsProvider, ChatProviders, UserProvider>(
      builder: (context, appservices, value, uservalue, _) {
        return WillPopScope(
          onWillPop: () async {
            bool willLeave = false;
            await showDialog(
              context: context,
              builder: (_) => AlertDialog(
                backgroundColor: AppColors().kprimary,
                titleTextStyle: const TextStyle(fontSize: 18),
                title: const Text('Are you sure you want to leave?'),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      // final socket =
                      //     Provider.of<GblProviders>(context, listen: false)
                      //         .socket;
                      // socket.emit(
                      //   "leaveChat",
                      //   [
                      //     user.randomuserdata!.chatId,
                      //     user.userdata!.id,
                      //   ],
                      // );
                      // socket.emit("leaveUser", user.userdata!.id);
                      willLeave = true;
                      // value.clearStates();
                      // user.removeRandomUser();
                      // socket.off('getMessage');
                      // socket.off('onPairDisconnected');
                      leavePage();
                      Navigator.of(context).pop();
                    },
                    child: const Text('Yes'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: const Text('No'),
                  )
                ],
              ),
            );
            return willLeave;
          },
          child: Scaffold(
            appBar: AppBar(
              title: Text(user.randomuserdata!.name),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // appservices.isinlineBannerAdAdLoaded
                //     ? Material(
                //         borderRadius: BorderRadius.circular(50),
                //         child: SizedBox(
                //           height: appservices.inlineBannerAd?.size.height
                //               .toDouble(),
                //           width:
                //               appservices.inlineBannerAd?.size.width.toDouble(),
                //           child: AdWidget(ad: appservices.inlineBannerAd!),
                //         ),
                //       )
                //     : const SizedBox(
                //         height: 1,
                //       ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: value.messages.length,
                    itemBuilder: (context, index) {
                      final message = value.messages[index];
                      return Column(
                        children: [
                          if (message.sender != user.userdata!.id)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(top: 6.0),
                                  child: CircleAvatar(
                                    backgroundColor:
                                        const Color.fromARGB(251, 75, 102, 79),
                                    child: Text(user.userdata!.name[0]),
                                  ),
                                ),
                                Flexible(
                                  child: Container(
                                    margin: const EdgeInsets.all(5),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 5,
                                    ),
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(251, 75, 102, 79),
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(13),
                                        bottomRight: Radius.circular(13),
                                        topLeft: Radius.circular(13),
                                        topRight: Radius.circular(13),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          messages[index].text,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: AppColors().kwhite,
                                          ),
                                        ),
                                        Text(
                                          DateFormat.jm().format(
                                            messages[index].createdAt.toLocal(),
                                          ),
                                          style: TextStyle(
                                            fontSize: 9,
                                            color: AppColors().kwhite,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 80),
                              ],
                            )
                          else
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(width: 80),
                                Flexible(
                                  child: Container(
                                    margin: const EdgeInsets.all(5),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 15,
                                      vertical: 5,
                                    ),
                                    decoration: const BoxDecoration(
                                      color: Color.fromARGB(249, 74, 63, 96),
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(13),
                                        bottomRight: Radius.circular(13),
                                        topLeft: Radius.circular(13),
                                        topRight: Radius.circular(13),
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          messages[index].text,
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: AppColors().kwhite,
                                          ),
                                        ),
                                        Text(
                                          DateFormat.jm().format(
                                            messages[index].createdAt.toLocal(),
                                          ),
                                          style: TextStyle(
                                            fontSize: 9,
                                            color: AppColors().kwhite,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 6.0),
                                  child: CircleAvatar(
                                    backgroundColor:
                                        const Color.fromARGB(249, 74, 63, 96),
                                    child: Text(user.randomuserdata!.name[0]),
                                  ),
                                )
                              ],
                            ),
                        ],
                      );
                    },
                  ),
                ),
                // const SizedBox(),

                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0, top: 2),
                  child: Row(
                    children: [
                      const SizedBox(width: 10),
                      CircleAvatar(
                        // backgroundColor: Color.fromARGB(172, 56, 9, 132),
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ConnectScreen()));
                          },
                          icon: const Icon(Icons.bolt),
                        ),
                      ),
                      const SizedBox(width: 10),
                      uservalue.pairleft == true
                          ? Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25)),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 20.0, vertical: 8),
                                        child: Text(
                                            '${user.randomuserdata!.name} left to this chat'),
                                      )),
                                  // ElevatedButton(
                                  //     onPressed: () {},
                                  //     child: const Text('Connect new Stranger'))
                                ],
                              ),
                            )
                          : Expanded(
                              child: TextField(
                                keyboardType: TextInputType.text,
                                minLines: 1,
                                maxLines: 5,
                                controller: value.messageController,
                                decoration: InputDecoration(
                                  isCollapsed: true,
                                  alignLabelWithHint: true,
                                  suffixIcon: !value.isLoading
                                      ? Padding(
                                          padding: const EdgeInsets.only(
                                              right: 7.0, top: 7, bottom: 7.0),
                                          child: CircleAvatar(
                                            child: IconButton(
                                              onPressed: () {
                                                if (value.messageController.text
                                                    .isNotEmpty) {
                                                  value.sendMessage(
                                                    user.randomuserdata!.id,
                                                    user.userdata!.id,
                                                  );
                                                }
                                              },
                                              icon: const Icon(
                                                Icons.send_rounded,
                                                size: 20,
                                              ),
                                            ),
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.only(
                                              right: 7.0, top: 7, bottom: 7.0),
                                          child: SizedBox(
                                            height: 40,
                                          ),
                                        ),
                                  // prefixIcon:
                                  //     value.messageController.text.isEmpty
                                  //         ? null
                                  //         : const Icon(Icons.keyboard),
                                  hintStyle: const TextStyle(),
                                  fillColor:
                                      const Color.fromARGB(255, 24, 24, 24),
                                  filled: true,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 18,
                                    vertical: 12,
                                  ),
                                  hintText: 'Type your message',
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                ),
                              ),
                            ),
                      const SizedBox(width: 10),
                      //   !value.isLoading
                      //       ? CircleAvatar(
                      //           child: IconButton(
                      //             onPressed: () {
                      //               if (value.messageController.text.isNotEmpty) {
                      //                 value.sendMessage(
                      //                   user.randomuserdata!.id,
                      //                   user.userdata!.id,
                      //                 );
                      //               }
                      //             },
                      //             icon: const Icon(Icons.send_rounded),
                      //           ),
                      //         )
                      //       : const CircularProgressIndicator(),
                      //   const SizedBox(width: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
