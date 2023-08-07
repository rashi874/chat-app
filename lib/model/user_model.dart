class Usermodel {
  String id;
  String userId;
  String name;
  String gender;

  Usermodel({
    required this.id,
    required this.userId,
    required this.name,
    required this.gender,
  });

  factory Usermodel.fromJson(Map<String, dynamic> json) => Usermodel(
        id: json["_id"],
        userId: json["userId"],
        name: json["name"],
        gender: json["gender"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "userId": userId,
        "name": name,
        "gender": gender,
      };
}
