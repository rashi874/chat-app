import 'dart:async';

import 'package:flutter/material.dart';
import 'package:zchatapp/model/message_model.dart';
import 'dart:developer' as developer;
import 'package:zchatapp/services/chat_services.dart';

class ChatProviders with ChangeNotifier {
  TextEditingController messageController = TextEditingController();
  List<Messagemodel> messages = [];
  bool isLoading = false;
  ScrollController scrollController = ScrollController();
  bool _isTyping = false;
  bool get isTyping => _isTyping;
  Timer? typingTimer;

  void setTypingStatus(bool value) {
    _isTyping = value;
    notifyListeners();
    return;
  }

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

  void scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients &&
          scrollController.positions.isNotEmpty) {
        double maxScrollExtent = scrollController.position.maxScrollExtent;

        scrollController.animateTo(
          maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void setMessage(Map<String, dynamic> data) {
    developer.log(data.toString());
    messages.add(Messagemodel.fromJson(data));
    scrollDown();
    notifyListeners();
  }

  void clearStates() {
    messageController.clear();
    messages.clear();
    isLoading = false;
  }

  void typingHandler(socket, user) {
    socket?.emit('typing', {"to": user.randomuserdata!.id, "isTyping": true});
    if (typingTimer != null) {
      typingTimer?.cancel();
    }
    typingTimer = Timer(const Duration(seconds: 2), () async {
      socket
          ?.emit('typing', {"to": user.randomuserdata!.id, "isTyping": false});
    });
  }
}
