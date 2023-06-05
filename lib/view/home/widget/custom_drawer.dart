import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zchatapp/controller/ads_provider.dart';
import 'package:zchatapp/controller/user_provider.dart';
import 'package:zchatapp/view/const.dart';
import 'package:zchatapp/view/home/home_screen.dart';

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
            children: [
              Sizes.spacerh40,
              Sizes.spacerh20,
              SizedBox(
                height: 230,
                child: Drawer(
                  shadowColor: const Color.fromARGB(0, 0, 0, 0),
                  // width: 275,
                  elevation: 0,
                  surfaceTintColor: Color.fromARGB(255, 251, 107, 107),
                  // backgroundColor: const Color.fromARGB(255, 37, 35, 35),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            // Icon(
                            //   Icons.arrow_back_ios,
                            //   // color: Colors.white,
                            //   size: 20,
                            // ),
                            // SizedBox(
                            //   width: 56,
                            // ),
                            Text(
                              'Settings',
                              style: TextStyle(
                                  // color: Colors.white,
                                  fontSize: 19),
                            ),
                          ],
                        ),
                        Sizes.spacerh20,
                        Row(
                          children: [
                            CircleAvatar(
                              child: Text(value.userdata?.name[0] ?? ''),
                            ),
                            // UserAvatar(filename: 'img3.jpeg'),
                            const SizedBox(
                              width: 12,
                            ),
                            Text(
                              value.userdata?.name ?? '',
                              style: const TextStyle(fontSize: 18),
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
                              'Gender : ' + '${value.userdata?.gender}' ?? '',
                              style: const TextStyle(fontSize: 18),
                            )
                          ],
                        ),
                        Sizes.spacerh10,
                        Row(
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                'Logout',
                                style: const TextStyle(
                                    fontSize: 17, color: Colors.white),
                              ),
                            )
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
