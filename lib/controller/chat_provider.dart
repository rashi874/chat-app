import 'package:flutter/material.dart';
import 'package:zchatapp/model/message_model.dart';
import 'dart:developer' as developer;

import 'package:zchatapp/services/chat_services.dart';

class ChatProviders with ChangeNotifier {
  TextEditingController messageController = TextEditingController();
  List<Messagemodel> messages = [];
  bool isLoading = false;

  Future<dynamic> sendMessage(String rid, String userId) async {
    isLoading = true;
    notifyListeners();

    try {
      final value = await ChatService().sendMessage(
        messageController.text,
        rid,
      );

      if (value != null) {
        developer.log(value.toString());
        setMessage({
          "messageId": value["messageId"],
          "text": messageController.text,
          "createdAt": value["createdAt"],
          "receiver": rid,
          "sender": userId,
        });
      } else {
        isLoading = false;
        notifyListeners();
        return null;
      }
    } catch (e) {
      developer.log(e.toString());
    }

    isLoading = false;
    messageController.clear();
    notifyListeners();
  }

  void setMessage(Map<String, dynamic> data) {
    developer.log(data.toString());
    messages.add(Messagemodel.fromJson(data));
    notifyListeners();
  }

  void clearStates() {
    messageController.clear();
    messages.clear();
    isLoading = false;
    // notifyListeners();
  }
}
