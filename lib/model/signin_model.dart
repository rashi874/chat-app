

class Signinmodel {
    String message;
    String accessToken;
    String refreshToken;

    Signinmodel({
        required this.message,
        required this.accessToken,
        required this.refreshToken,
    });

    factory Signinmodel.fromJson(Map<String, dynamic> json) => Signinmodel(
        message: json["message"],
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "accessToken": accessToken,
        "refreshToken": refreshToken,
    };
}
