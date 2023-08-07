import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:zchatapp/controller/ads_provider.dart';
import 'package:zchatapp/controller/chat_provider.dart';
import 'package:zchatapp/controller/global_provider.dart';
import 'package:zchatapp/controller/user_provider.dart';
import 'package:zchatapp/util/themes.dart';
import 'package:zchatapp/view/const.dart';
import 'package:zchatapp/view/home/connect_screen.dart';
import 'package:zchatapp/view/home/home_screen.dart';
import 'package:zchatapp/view/home/widget/transition.dart';


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
    final prov = Provider.of<AdsProvider>(context, listen: false);
    socket = Provider.of<GblProviders>(context, listen: false).socket;
    chatProvider = Provider.of<ChatProviders>(context, listen: false);
    final setMessage = chatProvider!.setMessage;
    // userProvider?.vibrateDevice();

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
      socket?.off('getMessage');
      if (userProvider?.userdata != null) {
        socket?.emit("leaveUser", userProvider?.userdata?.id);
      }
      userProvider?.paireduserleft();
      log("${data}Pair Disconnected${userProvider!.pairleft}");
    });
    socket?.on("typing", (data) {
      log('${data}notw');
      chattype(data);
    });

    prov.chatscreeninlineBannerAd(context);
    // prov.loadRewardedAd();
  }

  void chattype(data) {
    chatProvider!.setTypingStatus(data['isTyping']);
  }

  void newchat() {
    leavePage();
    Navigator.pushReplacement(
        context, SlideTransitionExample(page: const ConnectScreen()));
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
                surfaceTintColor: AppColors().kprimary,
                titleTextStyle:
                    TextStyle(fontSize: 17, color: AppColors().kwhite),
                title: const Text('Are you sure you want to leave?'),
                actions: [
                  ElevatedButton(
                    style: ButtonStyle(
                        elevation: const MaterialStatePropertyAll(0),
                        backgroundColor:
                            MaterialStatePropertyAll(AppColors().kgreen)),
                    onPressed: () {
                      willLeave = true;
                      final prov =
                          Provider.of<AdsProvider>(context, listen: false);
                      prov.bannerAd4?.dispose();
                      prov.inlineBannerAd?.dispose();
                      prov.homescreenInlineBannerAd(context);
                      appservices.rewardedAd?.show(
                        onUserEarnedReward: (_, reward) {},
                      );
                      FocusScope.of(context).unfocus();
                      leavePage();
                      Navigator.pop(context,
                          SlideTransitionExample(page: const HomeScreen()));
                    },
                    child: Text(
                      'Yes',
                      style: TextStyle(color: AppColors().kblack),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'No',
                      style: TextStyle(color: AppColors().kwhite),
                    ),
                  )
                ],
              ),
            );
            return willLeave;
          },
          child: Scaffold(
            appBar: AppBar(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.randomuserdata?.name ?? 'Stranger Chats',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'SFProDisplay',
                    ),
                  ),
                  value.isTyping
                      ? const Text(
                          'typing...',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      : uservalue.pairleft == false
                          ? const Text(
                              'online',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            )
                          : const Text(
                              'offline',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                ],
              ),
              actions: [
                ElevatedButton(
                  style: ButtonStyle(
                      elevation: const MaterialStatePropertyAll(0),
                      foregroundColor:
                          MaterialStatePropertyAll(AppColors().kwhite),
                      backgroundColor:
                          MaterialStatePropertyAll(AppColors().kgrey)),
                  onPressed: () {
                    leavePage();
                    newchat();
                    final prov =
                        Provider.of<AdsProvider>(context, listen: false);
                    prov.bannerAd4?.dispose();
                    FocusScope.of(context).unfocus();
                    // showAd();
                  },
                  child: const Text(
                    'New chat',
                    style: TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ),
                Sizes.spacerw5,
              ],
            ),
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  appservices.bannerAd4 != null
                      ? Center(
                          child: Material(
                              color: AppColors().kprimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: SizedBox(
                                width: appservices.bannerAd4!.sizes[0].width
                                    .toDouble(),
                                height: appservices.bannerAd4!.sizes[0].height
                                    .toDouble(),
                                child: AdWidget(ad: appservices.bannerAd4!),
                              )),
                        )
                      : Container(),
                  const SizedBox(
                    height: 1,
                  ),
                  Expanded(
                    child: ListView.builder(
                      controller: chatProvider?.scrollController,
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
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
                                  Sizes.spacerw5,
                                  Padding(
                                    padding: const EdgeInsets.only(top: 6.0),
                                    child: CircleAvatar(
                                      backgroundColor: AppColors().kgrey,
                                      child: Text(
                                        user.randomuserdata!.name[0],
                                        style: TextStyle(
                                            color: AppColors().kwhite,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Flexible(
                                    child: Container(
                                      margin: const EdgeInsets.all(5),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 5,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors().kgrey,
                                        borderRadius: const BorderRadius.only(
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
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors()
                                                  .kwhite
                                                  .withOpacity(0.8),
                                            ),
                                          ),
                                          Text(
                                            DateFormat.jm().format(
                                              messages[index]
                                                  .createdAt
                                                  .toLocal(),
                                            ),
                                            style: TextStyle(
                                              fontSize: 10,
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
                                      decoration: BoxDecoration(
                                        color: AppColors().kwhite,
                                        borderRadius: const BorderRadius.only(
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
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: AppColors()
                                                  .kblack
                                                  .withOpacity(0.8),
                                            ),
                                          ),
                                          Text(
                                            DateFormat.jm().format(
                                              messages[index]
                                                  .createdAt
                                                  .toLocal(),
                                            ),
                                            style: TextStyle(
                                              fontSize: 10,
                                              color: AppColors().kblack,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 6.0),
                                    child: CircleAvatar(
                                      backgroundColor: AppColors().kwhite,
                                      child: Text(
                                        user.userdata!.name[0],
                                        style: TextStyle(
                                            color: AppColors()
                                                .kblack
                                                .withOpacity(0.8),
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Sizes.spacerw5,
                                ],
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0, top: 4),
                    child: Row(
                      children: [
                        Sizes.spacerw5,
                        Expanded(
                          child: uservalue.pairleft == true
                              ? Card(
                                  elevation: 0,
                                  color: AppColors().kgrey,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(25),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0,
                                      vertical: 10,
                                    ),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Icon(
                                            Icons.cancel_schedule_send_rounded,
                                            color: AppColors().kwhite,
                                          ),
                                        ),
                                        Sizes.spacerw10,
                                        Text(
                                          '${user.randomuserdata!.name} left this chat',
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        keyboardType: TextInputType.text,
                                        minLines: 1,
                                        maxLines: 5,
                                        onChanged: (text) {
                                          if (text.isNotEmpty) {
                                            value.typingHandler(socket, user);
                                          }
                                        },
                                        controller: value.messageController,
                                        decoration: InputDecoration(
                                          isCollapsed: true,
                                          hintStyle: TextStyle(
                                              color: AppColors()
                                                  .kwhite
                                                  .withOpacity(0.6)),
                                          fillColor: AppColors().kgrey,
                                          filled: true,
                                          contentPadding: const EdgeInsets.only(
                                              right: 15,
                                              left: 15,
                                              top: 8,
                                              bottom: 12),
                                          hintText: ' Message',
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                        ),
                                      ),
                                    ),
                                    !value.isLoading == true
                                        ? Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0, vertical: 8),
                                            child: CircleAvatar(
                                              backgroundColor:
                                                  AppColors().kblue,
                                              child: IconButton(
                                                onPressed: () async {
                                                  if (value.messageController
                                                      .text.isNotEmpty) {
                                                    await value.sendMessage(
                                                      user.randomuserdata!.id,
                                                      user.userdata!.id,
                                                    );
                                                  }
                                                },
                                                icon: Icon(
                                                  Icons.send_rounded,
                                                  size: 18,
                                                  color: AppColors().kwhite,
                                                ),
                                              ),
                                            ),
                                          )
                                        : SizedBox(
                                            height: 56,
                                            width: 56,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: CircularProgressIndicator(
                                                color: AppColors().kgreen,
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                        ),
                        Sizes.spacerw10,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
