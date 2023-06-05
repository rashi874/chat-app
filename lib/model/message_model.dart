// To parse this JSON data, do
//
//     final messagemodel = messagemodelFromJson(jsonString);

import 'dart:convert';

Messagemodel messagemodelFromJson(String str) => Messagemodel.fromJson(json.decode(str));

String messagemodelToJson(Messagemodel data) => json.encode(data.toJson());

class Messagemodel {
    String reciever;
    String sender;
    String messageId;
    String text;
    DateTime createdAt;

    Messagemodel({
        required this.reciever,
        required this.sender,
        required this.messageId,
        required this.text,
        required this.createdAt,
    });

    factory Messagemodel.fromJson(Map<String, dynamic> json) => Messagemodel(
        reciever: json["reciever"],
        sender: json["sender"],
        messageId: json["messageId"],
        text: json["text"],
        createdAt: DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "reciever": reciever,
        "sender": sender,
        "messageId": messageId,
        "text": text,
        "createdAt": createdAt.toIso8601String(),
    };
}
