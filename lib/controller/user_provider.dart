import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:zchatapp/model/random_model.dart';
import 'package:zchatapp/model/user_model.dart';
import 'package:zchatapp/services/get_user_service.dart';
import 'package:zchatapp/services/random_connect_ser.dart';
import 'package:zchatapp/view/chatscreen/chat_screen.dart';

class UserProvider extends ChangeNotifier {
  bool isLoading = false;
  DateTime filterDate = DateTime.now();
  Usermodel? userdata;
  Randommodel? randomuserdata;
  CancelToken? randomcancelToken;
  bool pairleft = false;
  //  List<AlleventsModel> filteredList = allEventsList.where((item) => item['startDateTime'].isAtSameDayAs(filterDate)).toList();
  Future<void> getuser() async {
    isLoading = true;
    randomcancelToken = CancelToken();
    // notifyListeners();
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

  void setRandomUser(dynamic user) {
    randomuserdata = Randommodel.fromJson(user);

    notifyListeners();
  }

  Future<void> randomconnect(context) async {
    isLoading = true;
    // notifyListeners();
    await RandomuserService().getrandomuser(randomcancelToken).then((value) {
      if (value != null) {
        randomuserdata = value;
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => const ChatPage()));
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
    // notifyListeners();
  }

  void paireduserleft() {
    pairleft = true;
    notifyListeners();
  }
}
