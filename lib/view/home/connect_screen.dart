import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zchatapp/controller/global_provider.dart';
import 'package:zchatapp/controller/user_provider.dart';
import 'package:zchatapp/model/random_model.dart';
import 'package:zchatapp/view/chatscreen/chat_screen.dart';

class ConnectScreen extends StatelessWidget {
  const ConnectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context, listen: false);
    final socket = Provider.of<GblProviders>(context, listen: false).socket;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      socket.emit('addUser', user.userdata?.id);
      socket.on('connectionRequest', (data) {
        user.randomcancelToken.cancel();
        user.setRandomUser(data);
        log(data.toString());
        log("connectionRequest");
      });

      user.randomconnect();
    });
    return Consumer<UserProvider>(builder: (context, value, _) {
      return Scaffold(
          appBar: AppBar(),
          body: value.randomuserdata == null
              ? const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Text('finding friends'),
                    ),
                  ],
                )
              : ChatPage());
    });
  }
}
