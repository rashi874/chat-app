import 'package:flutter/material.dart';
import 'package:zchatapp/model/message_model.dart';
import 'package:zchatapp/services/chat_services.dart';

class ChatProviders with ChangeNotifier {
  TextEditingController messageController = TextEditingController();
  List<Messagemodel> messages = [];
  bool isLoading = false;

  Future<void> sendmessage(rid) async {
    isLoading = true;
    // notifyListeners();
    await ChatService().sendmessage(messageController.text, rid).then((value) {
      if (value != null) {
        // messages = value;
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
