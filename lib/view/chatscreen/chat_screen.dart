import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:zchatapp/controller/ads_provider.dart';
import 'package:zchatapp/controller/chat_provider.dart';
import 'package:zchatapp/controller/global_provider.dart';
import 'package:zchatapp/controller/user_provider.dart';
import 'package:zchatapp/model/message_model.dart';
import 'package:zchatapp/util/themes.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // List<Messagemodel> message =
    final user = Provider.of<UserProvider>(context, listen: false);
    final prov = Provider.of<AdsProvider>(context, listen: false);
    final socket = Provider.of<GblProviders>(context, listen: false).socket;
    final messages =
        Provider.of<ChatProviders>(context, listen: false).messages;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (user.randomuserdata != null) {
        socket
            .emit("joinChat", {user.randomuserdata!.chatId, user.userdata!.id});
      }
      socket.on("getMessage", (data) {
        log(data.toString());
        messages.add(Messagemodel.fromJson(data));
      });
      AdsProvider().inlineBannerAd?.dispose();
      prov.createInlineBannerAd3(context);
    });
    return Consumer2<AdsProvider, ChatProviders>(
        builder: (context, appservices, value, _) {
      return Scaffold(
          // appBar: AppBar(
          //     // title: Text(widget.room),
          //     // elevation: 10,
          //     // surfaceTintColor: Colors.white,
          //     ),
          body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        // appservices.isinlineBannerAdAdLoaded
        //     ? Material(
        //         // color: AppColors().kblue.withOpacity(0.2),
        //         borderRadius: BorderRadius.circular(5),
        //         child: Padding(
        //           padding: const EdgeInsets.all(5.0),
        //           child: SizedBox(
        //             height: appservices.inlineBannerAd?.size.height
        //                 .toDouble(),
        //             width:
        //                 appservices.inlineBannerAd?.size.width.toDouble(),
        //             child: AdWidget(ad: appservices.inlineBannerAd!),
        //           ),
        //         ),
        //       )
        //     : const SizedBox(
        //         height: 1,
        //         // child: Text(
        //         //   'AD',
        //         //   style: TextStyle(color: Colors.white),
        //         // ),
        //       ),

        Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemCount: value.messages.length,
                itemBuilder: (context, index) {
                  // return ListTile(
                  //   title: Text(messages[index]),
                  // );
                  return Column(
                    children: [
                      index % 2 == 0
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                  Flexible(
                                    child: Container(
                                      margin: const EdgeInsets.all(5),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 5),
                                      decoration: const BoxDecoration(
                                          color: Color.fromARGB(
                                              255, 206, 225, 245),
                                          borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(15),
                                            bottomRight: Radius.circular(15),
                                            // topLeft: Radius.circular(10),
                                            topRight: Radius.circular(15),
                                          )),
                                      child: Text(
                                        messages[index].text,
                                        style: TextStyle(
                                            fontSize: 17,
                                            color: AppColors().kblack),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 80,
                                  ),
                                ])
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const SizedBox(
                                  width: 80,
                                ),
                                Flexible(
                                  child: Container(
                                    margin: const EdgeInsets.all(5),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5),
                                    decoration: const BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 245, 209, 206),
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(15),
                                          bottomRight: Radius.circular(15),
                                          topLeft: Radius.circular(15),
                                        )),
                                    child: Text(
                                      messages[index].text,
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: AppColors().kblack),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                    ],
                  );
                })),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          height: 70,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  expands: true,
                  controller: value.messageController,
                  decoration: InputDecoration(
                    fillColor: AppColors().kblack,
                    filled: true,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    hintText: 'Type your message',
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    border: OutlineInputBorder(
                      
                        borderSide: const BorderSide(
                          color: Color.fromARGB(0, 245, 209, 206),
                          
                        ),
                        borderRadius: BorderRadius.circular(10)),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                onPressed: () {
                  value.sendmessage(user.randomuserdata!.id);
                  // showAd();
                  // return ;
                },
                icon: const Icon(Icons.send_rounded),
                // child: const Text('Send'),
              ),
            ],
          ),
        ),
      ]));
    });
  }
}
