import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:zchatapp/model/random_model.dart';
import 'package:zchatapp/model/user_model.dart';
import 'package:zchatapp/services/get_user_service.dart';
import 'package:zchatapp/services/random_connect_ser.dart';

class UserProvider extends ChangeNotifier {
  bool isLoading = false;
  DateTime filterDate = DateTime.now();
  Usermodel? userdata;
  Randommodel? randomuserdata;
  CancelToken randomcancelToken = CancelToken();
  //  List<AlleventsModel> filteredList = allEventsList.where((item) => item['startDateTime'].isAtSameDayAs(filterDate)).toList();
  Future<void> getuser() async {
    isLoading = true;
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

  Future<void> randomconnect() async {
    isLoading = true;
    // notifyListeners();
    await RandomuserService().getrandomuser(randomcancelToken).then((value) {
      if (value != null) {
        randomuserdata = value;
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
}
