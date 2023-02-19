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
    required this.userType,
    required this.year,
    required this.clgName,
  });

  final String name;
  String id;
  final String email;
  final String number;
  final String password;
  final String userType;
  final String year ;
  final String clgName;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
    name: json["name"],
    id: json["id"],
    email: json["email"],
    number: json["number"],
    password: json["password"],
      userType : json["userType"],
    year : json["year"],
    clgName : json["clgName"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "id": id,
    "email": email,
    "number": number,
    "password": password,
    "userType" : userType,
    "year" : year,
    "clgName" : clgName,
  };
}