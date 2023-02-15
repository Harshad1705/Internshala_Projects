import 'dart:convert';

Users welcomeFromJson(String str) => Users.fromJson(json.decode(str));

String welcomeToJson(Users data) => json.encode(data.toJson());

class Users {
  Users({
    required this.name,
    this.id = '',
    required this.email,
    required this.number,
    required this.password,
  });

  final String name;
  String id;
  final String email;
  final String number;
  final String password;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        name: json["name"],
        id: json["id"],
        email: json["email"],
        number: json["number"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "id": id,
        "email": email,
        "number": number,
        "password": password,
      };
}
