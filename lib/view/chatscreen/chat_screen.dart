import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:zchatapp/controller/ads_provider.dart';
import 'package:zchatapp/model/message_model.dart';
import 'package:zchatapp/util/themes.dart';
import 'package:zchatapp/model/user_model.dart';

import '../../ads/ope_ads.dart';

class ChatPage extends StatefulWidget {
  final String username;
  final String room;

  const ChatPage({super.key, required this.username, required this.room});

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late IO.Socket socket;
  TextEditingController messageController = TextEditingController();
  List<Messagemodel> messages = [];
  List<Usermodel> users = [];

  @override
  void initState() {
    super.initState();

    // Connect to Socket.io server
    socket = IO.io('http://192.168.1.13:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    // Join chat room
    socket.onConnect((_) {
      log('connect');
      socket.emit('addUser', socket.id);
      socket.emit('joinRoom', widget.room);
    });

    // Receive messages from server
    socket.on('getMessage', (data) {
      log(data.toString());
      setState(() {
        messages.add(Messagemodel(
            senderId: data['senderId'].toString(), text: data['text']));
        // messages.add(data['senderId'] + ": " + data['text']);
      });
    });
    socket.on('getUsers', (data) {
      setState(() {
        users = (data as List).map((e) => Usermodel.fromJson(e)).toList();
      });
    });

    socket.connect();
  }

  @override
  void dispose() {
    socket.disconnect();
    super.dispose();
  }

  void sendMessage() {
    String messageText = messageController.text.trim();
    if (messageText.isNotEmpty) {
      log(users.toString());
      List<Usermodel> ids =
          users.where((element) => element.socketId != socket.id).toList();
      socket.emit('sendMessage', {
        'senderId': socket.id,
        'reciverId': ids[0].userId.toString(),
        'text': messageText,
      });
      setState(() {
        messages.add(
            Messagemodel(senderId: socket.id.toString(), text: messageText));
      });
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final prov = Provider.of<AdsProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      AdsProvider().inlineBannerAd?.dispose();
      prov.createInlineBannerAd3(context);
    });
    return Consumer<AdsProvider>(builder: (context, appservices, _) {
      return Scaffold(
          appBar: AppBar(
            title: Text(widget.room),
            // elevation: 10,
            // surfaceTintColor: Colors.white,
          ),
          body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            // const Divider(),
            const Text(
              'This is Development mode .Full Features coming soon',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            Container(
              margin: const EdgeInsets.all(5),
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              decoration: const BoxDecoration(
                  // color: Color.fromARGB(255, 241, 245, 206),
                  borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              )),
              child: const Text(
                'Today',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
            ),

            appservices.isinlineBannerAdAdLoaded
                ? Material(
                    // color: AppColors().kblue.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(5),
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: SizedBox(
                        height:
                            appservices.inlineBannerAd?.size.height.toDouble(),
                        width:
                            appservices.inlineBannerAd?.size.width.toDouble(),
                        child: AdWidget(ad: appservices.inlineBannerAd!),
                      ),
                    ),
                  )
                : const SizedBox(
                    height: 1,
                    // child: Text(
                    //   'AD',
                    //   style: TextStyle(color: Colors.white),
                    // ),
                  ),

            Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      // return ListTile(
                      //   title: Text(messages[index]),
                      // );
                      return Column(
                        children: [
                          messages[index].senderId == socket.id
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
                                                bottomRight:
                                                    Radius.circular(15),
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
                                            color: Color.fromARGB(
                                                255, 245, 209, 206),
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
                      controller: messageController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        hintText: 'Type your message',
                        focusedBorder: InputBorder.none,
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
                      showAd();
                      return sendMessage();
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
