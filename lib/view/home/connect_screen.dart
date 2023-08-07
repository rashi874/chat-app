import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:provider/provider.dart';
import 'package:zchatapp/controller/ads_provider.dart';
import 'package:zchatapp/controller/global_provider.dart';
import 'package:zchatapp/controller/user_provider.dart';
import 'package:zchatapp/util/themes.dart';
import 'package:zchatapp/view/chatscreen/chat_screen.dart';
import 'package:zchatapp/view/const.dart';
import 'package:zchatapp/view/home/widget/transition.dart';

class ConnectScreen extends StatefulWidget {
  const ConnectScreen({Key? key}) : super(key: key);

  @override
  ConnectScreenState createState() => ConnectScreenState();
}

class ConnectScreenState extends State<ConnectScreen>
    with WidgetsBindingObserver {
  late UserProvider userProvider;
  late GblProviders gblProviders;
  AdsProvider? adsProvider;

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
        context,
        SlideTransitionExample(page: const ChatPage()),
      );
      log(data.toString());
      log("connectionRequest");
    });
    userProvider.randomconnect(context);
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    final socket = gblProviders.socket;
    adsProvider?.isLoaded2 = false;
    socket.off('connectionRequest');
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      final socket = gblProviders.socket;
      socket.emit('leaveUser', userProvider.userdata!.id);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    adsProvider = Provider.of<AdsProvider>(context, listen: false);
    adsProvider?.bannerAd2?.dispose();
    adsProvider!.createInlineBannerAd4(context);
    if (ModalRoute.of(context)?.isCurrent == true) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<GblProviders, AdsProvider>(
        builder: (BuildContext context, value, appservices, _) {
      return WillPopScope(
          onWillPop: () async {
            if (kDebugMode) {
              print('message' 'rashids');
            }
            bool willLeave = true;
            final socket = gblProviders.socket;
            socket.emit('leaveUser', userProvider.userdata!.id);
            Navigator.of(context).pop();
            return willLeave;
          },
          child: Scaffold(
            appBar: AppBar(
              title: const Text(
                'Connect People',
              ),
            ),
            body: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        appservices.bannerAd2 != null &&
                                appservices.isLoaded5 == true
                            ? Center(
                                child: Material(
                                    color: AppColors().kprimary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    child: SizedBox(
                                      width: appservices
                                          .bannerAd2!.sizes[0].width
                                          .toDouble(),
                                      height: appservices
                                          .bannerAd2!.sizes[0].height
                                          .toDouble(),
                                      child:
                                          AdWidget(ad: appservices.bannerAd2!),
                                    )),
                              )
                            : Sizes.spacerh20,
                        Container(
                          height: 250,
                          width: 250,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/Rectangle 12.png'),
                                  fit: BoxFit.contain)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 47,
                                width: 47,
                                decoration: BoxDecoration(
                                    color: AppColors().kgreen,
                                    borderRadius: BorderRadius.circular(100),
                                    image: const DecorationImage(
                                        image: AssetImage(
                                          'assets/images/sd.gif',
                                        ),
                                        fit: BoxFit.cover)),
                              ),
                              const Text(
                                'Connecting',
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                  // color: AppColors().kblue,
                                ),
                              ),
                              Container(
                                height: 49,
                                width: 49,
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: AppColors().kblue,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: CircularProgressIndicator(
                                  color: AppColors().kwhite,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'By connecting, growing, empathizing, combating loneliness, raising awareness, and developing personally, we can lead more fulfilling lives.',
                            style: TextStyle(
                              fontSize: 13.0,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ));
    });
  }
}
