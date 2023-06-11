import 'dart:developer';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zchatapp/controller/global_provider.dart';
import 'package:zchatapp/controller/user_provider.dart';
import 'package:zchatapp/view/chatscreen/chat_screen.dart';
import 'package:zchatapp/view/const.dart';

class ConnectScreen extends StatefulWidget {
  const ConnectScreen({Key? key}) : super(key: key);

  @override
  ConnectScreenState createState() => ConnectScreenState();
}

class ConnectScreenState extends State<ConnectScreen> {
  late UserProvider userProvider;
  late GblProviders gblProviders;
  bool isFirstBuild = true;

  @override
  void initState() {
    super.initState();
    userProvider = Provider.of<UserProvider>(context, listen: false);
    gblProviders = Provider.of<GblProviders>(context, listen: false);
    final socket = gblProviders.socket;
    log("${userProvider.userdata!.id} connected");
    socket.emit('addUser', userProvider.userdata?.id);
    socket.on('connectionRequest', (data) {
      userProvider.randomcancelToken?.cancel();
      userProvider.setRandomUser(data);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const ChatPage()));
      log(data.toString());
      log("connectionRequest");
    });
    userProvider.randomconnect(context);
  }

  @override
  void dispose() {
    final socket = gblProviders.socket;
    socket.off('connectionRequest');
    super.dispose();
  }

  void didPopNext() {
    if (!isFirstBuild) {
      didChangeDependencies();
    }
  }

  @override
  Widget build(BuildContext context) {
    isFirstBuild = false;

    //   return Consumer<UserProvider>(
    //     builder: (context, value, _) {
    //       if (value.randomuserdata == null) {
    //         return buildConnectingScreen();
    //       } else {
    //         return ChatPage();
    //       }
    //     },
    //   );
    // }

    // Widget buildConnectingScreen() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('random user'),
        elevation: 0,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'Connecting',
                  textStyle: const TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w500,
                    color: Color.fromARGB(255, 224, 224, 224),
                  ),
                  speed: const Duration(milliseconds: 100),
                ),
              ],
              pause: const Duration(milliseconds: 1000),
              displayFullTextOnTap: true,
              stopPauseOnTap: true,
            ),
            Sizes.spacerh10,
            Container(
              height: 250,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                    Color.fromARGB(108, 47, 47, 47),
                    BlendMode.hardLight,
                  ),
                  image: AssetImage('assets/images/fl.gif'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
