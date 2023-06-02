// To parse this JSON data, do
//
//     final usermodel = usermodelFromJson(jsonString);

import 'dart:convert';

List<Usermodel> usermodelFromJson(String str) => List<Usermodel>.from(json.decode(str).map((x) => Usermodel.fromJson(x)));

String usermodelToJson(List<Usermodel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Usermodel {
    String userId;
    String socketId;

    Usermodel({
        required this.userId,
        required this.socketId,
    });

    factory Usermodel.fromJson(Map<String, dynamic> json) => Usermodel(
        userId: json["userId"],
        socketId: json["socketId"],
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "socketId": socketId,
    };
}
