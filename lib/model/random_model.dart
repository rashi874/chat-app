class Randommodel {
  String id;
  String userId;
  String name;
  String gender;
  String socketId;
  String chatId;

  Randommodel({
    required this.id,
    required this.userId,
    required this.name,
    required this.gender,
    required this.socketId,
    required this.chatId,
  });

  factory Randommodel.fromJson(Map<String, dynamic> json) => Randommodel(
        id: json["_id"],
        userId: json["userId"],
        name: json["name"],
        gender: json["gender"],
        socketId: json["socketId"],
        chatId: json["chatId"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "name": name,
        "gender": gender,
        "socketId": socketId,
        "chatId": chatId,
      };
}
