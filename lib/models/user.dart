import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
    String usName;
    String usEmail;
    String usPassword;
    String usGender;
    String usImage;

    User({
        required this.usName,
        required this.usEmail,
        required this.usPassword,
        required this.usGender,
        required this.usImage,
    });

    factory User.fromJson(Map<dynamic, dynamic> json) => User(
        usName: json["us_name"],
        usEmail: json["us_email"],
        usPassword: json["us_password"],
        usGender: json["us_gender"],
        usImage: json["us_image"],
    );

    Map<dynamic, dynamic> toJson() => {
        "us_name": usName,
        "us_email": usEmail,
        "us_password": usPassword,
        "us_gender": usGender,
        "us_image": usImage,
    };
}
