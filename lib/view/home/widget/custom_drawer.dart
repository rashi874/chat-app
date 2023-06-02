import 'package:flutter/material.dart';
import 'package:zchatapp/view/home/home_screen.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      // width: 275,
      // elevation: 30,
      surfaceTintColor: Color.fromARGB(255, 11, 11, 11),
      backgroundColor: Color.fromARGB(255, 14, 14, 14),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.horizontal(right: Radius.circular(30))),
      child: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.horizontal(right: Radius.circular(40)),
          // boxShadow: [
          //   BoxShadow(
          //       color: Color(0x3D000000), spreadRadius: 30, blurRadius: 20)
          // ]
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 50, 20, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
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
                            fontSize: 18),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      UserAvatar(filename: 'img3.jpeg'),
                      SizedBox(
                        width: 12,
                      ),
                      Text(
                        'Tom Brenan',
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  DrawerItem(
                    title: 'Account',
                    icon: Icons.key,
                  ),
                  DrawerItem(title: 'Chats', icon: Icons.chat_bubble),
                  DrawerItem(title: 'Notifications', icon: Icons.notifications),
                  DrawerItem(title: 'Data and Storage', icon: Icons.storage),
                  DrawerItem(title: 'Help', icon: Icons.help),
                  Divider(
                    height: 35,
                    // color: Colors.green,
                  ),
                  DrawerItem(
                      title: 'Invite a friend', icon: Icons.people_outline),
                ],
              ),
              DrawerItem(title: 'Log out', icon: Icons.logout)
            ],
          ),
        ),
      ),
    );
  }
}
