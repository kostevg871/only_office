import 'dart:convert';

User userFromMap(String str) => User.fromMap(json.decode(str));

String userToMap(User data) => json.encode(data.toMap());

class User {
  User({
    this.expires,
    this.token,
  });

  String expires;
  String token;

  factory User.fromMap(Map<String, dynamic> json) => User(
        expires: json["expires"],
        token: json["token"],
      );

  Map<String, dynamic> toMap() => {
        "expires": expires,
        "token": token,
      };
}
