import 'dart:convert';

List<Messagemodel> messagemodelFromJson(String str) => List<Messagemodel>.from(
    json.decode(str).map((x) => Messagemodel.fromJson(x)));
String messagemodelToJson(List<Messagemodel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Messagemodel {
  String senderId;
  String text;

  Messagemodel({
    required this.senderId,
    required this.text,
  });

  factory Messagemodel.fromJson(Map<String, dynamic> json) => Messagemodel(
        senderId: json["senderId"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "senderId": senderId,
        "text": text,
      };
}
