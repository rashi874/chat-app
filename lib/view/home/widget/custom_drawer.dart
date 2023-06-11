import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zchatapp/controller/splash_provider.dart';
import 'package:zchatapp/controller/user_provider.dart';
import 'package:zchatapp/util/themes.dart';
import 'package:zchatapp/view/const.dart';
import 'package:zchatapp/view/login/login_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(builder: (context, value, _) {
      log(value.userdata.toString());
      return SafeArea(
        child: Align(
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 63,
              ),
              SizedBox(
                height: 230,
                child: Drawer(
                  elevation: 0,
                  backgroundColor: const Color.fromARGB(255, 15, 15, 15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Settings',
                          style: TextStyle(fontSize: 19),
                        ),
                        Sizes.spacerh20,
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.brown,
                              child: Text(
                                value.userdata?.name[0].toUpperCase() ?? '',
                                style: TextStyle(height: 2),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            // UserAvatar(filename: 'img3.jpeg'),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(
                              value.userdata?.name ?? '',
                              style: const TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                        Sizes.spacerh10,
                        Row(
                          children: [
                            // CircleAvatar(
                            //   child: Text('G'),
                            // ),
                            // UserAvatar(filename: 'img3.jpeg'),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              'Gender: ${value.userdata?.gender ?? ' '}',
                              style: const TextStyle(fontSize: 16),
                            )
                          ],
                        ),
                        Sizes.spacerh20,
                        Row(
                          children: [
                            ElevatedButton.icon(
                                style: ButtonStyle(
                                    side: MaterialStatePropertyAll(BorderSide(
                                        color: AppColors()
                                            .kwhite
                                            .withOpacity(0.8))),
                                    backgroundColor: MaterialStatePropertyAll(
                                        AppColors().kprimary)),
                                label: Padding(
                                  padding: const EdgeInsets.only(bottom: 3.5),
                                  child: Text(
                                    'Logout',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors()
                                            .kwhite
                                            .withOpacity(0.8)),
                                  ),
                                ),
                                onPressed: () {
                                  Provider.of<SplashProvider>(context,
                                          listen: false)
                                      .logOut(context);
                                  // showAd();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const LoginScreen()));
                                },
                                icon: Icon(
                                  Icons.lock_outline_rounded,
                                  color: AppColors().kwhite.withOpacity(0.8),
                                  size: 22,
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
