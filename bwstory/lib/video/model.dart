import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

Users usersFromJson(String str) => Users.fromJson(json.decode(str));

String usersToJson(Users data) => json.encode(data.toJson());

class Users {
  Users({
    this.id = '',
    this.views = 0,
    this.like = false,
    this.dislike = false,
    required this.username,
    required this.datetime,
    required this.url,
    required this.title,
    required this.category,
    required this.description,
    required this.number,
    required this.address,
    required this.liked,
    required this.disliked,
  });
  String username;
  String url;
  String title;
  String category;
  String description;
  String number;
  String address;
  bool like;
  bool dislike;
  int liked;
  int disliked;
  String id;
  int views;
  DateTime datetime;

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        url: json["url"],
        title: json["title"],
        category: json["category"],
        description: json["description"],
        number: json["number"],
        address: json["address"],
        liked: json["liked"],
        disliked: json['disliked'],
        like: json['like'],
        dislike: json['dislike'],
        id: json['id'],
        views: json['views'],
        datetime: json['datetime'],
        username: json['username'],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "title": title,
        "category": category,
        "description": description,
        "number": number,
        "address": address,
        "liked": liked,
        "disliked": disliked,
        "like": like,
        "dislike": dislike,
        "id": id,
        "views": views,
        "datetime": datetime,
        "username": username,
      };
}
