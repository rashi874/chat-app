import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:zchatapp/model/random_model.dart';
import 'package:zchatapp/model/user_model.dart';
import 'package:zchatapp/services/get_user_service.dart';
import 'package:zchatapp/services/random_connect_ser.dart';
import 'package:zchatapp/view/chatscreen/chat_screen.dart';
import 'package:zchatapp/view/home/widget/transition.dart';

class UserProvider extends ChangeNotifier {
  bool isLoading = false;
  DateTime filterDate = DateTime.now();
  Usermodel? userdata;
  Randommodel? randomuserdata;
  CancelToken? randomcancelToken;
  bool pairleft = false;
  String updatedname = 'Rashid Pk';
  Future<void> getuser() async {
    isLoading = true;
    randomcancelToken = CancelToken();
    await UserService().getuser().then((value) {
      if (value != null) {
        userdata = value;
        notifyListeners();
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
        return null;
      }
    });
  }

  Future<void> updateuser() async {
    isLoading = true;
    randomcancelToken = CancelToken();
    await UserService()
        .edituser(
      userdata?.id,
      userdata?.gender,
      updatedname,
    )
        .then((value) {
      if (value != null) {
        userdata = value;
        notifyListeners();
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
        return null;
      }
    });
  }

  //   Future<void> editUser(context) async {
  //   var id = await getDeviceDetails();
  //   log(id.toString());
  //   isLoading = true;
  //   notifyListeners();
  //   await LoginServices().edituser(id, gender).then(
  //     (value) {
  //       if (value != null) {
  //         storage.write(key: 'token', value: value.accessToken);
  //         storage.write(key: 'refreshToken', value: value.refreshToken);
  //         Provider.of<UserProvider>(context, listen: false).getuser();
  //         Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(
  //           builder: (context) {
  //             return const CustomDrawer();
  //           },
  //         ), (route) => false);
  //       }
  //     },
  //   );
  //   isLoading = false;
  //   notifyListeners();
  // }

  void setRandomUser(dynamic user) {
    randomuserdata = Randommodel.fromJson(user);
    notifyListeners();
  }

  Future<void> randomconnect(context) async {
    isLoading = true;
    await RandomuserService().getrandomuser(randomcancelToken).then((value) {
      if (value != null) {
        randomuserdata = value;
        Navigator.pushReplacement(
            context, SlideTransitionExample(page: const ChatPage()));
        notifyListeners();
        isLoading = false;
        notifyListeners();
      } else {
        isLoading = false;
        notifyListeners();
        return null;
      }
    });
  }

  void removeRandomUser() {
    randomuserdata = null;
    randomcancelToken?.cancel("UserProvider disposed"); // Cancel the token
    randomcancelToken = null;
    pairleft = false;
  }

  void paireduserleft() {
    pairleft = true;
    notifyListeners();
  }
}
