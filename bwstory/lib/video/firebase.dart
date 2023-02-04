import 'dart:io';

import 'package:bwstory/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'model.dart';

import 'formpage.dart';

class FireBase extends StatefulWidget {
  @override
  State<FireBase> createState() => _FireBaseState();

  final users = FirebaseFirestore.instance.collection('users');

  Future<String> upload({required String title}) async {
    String urlDownload = "";
    try {
      print(RecordDetailPage.number);
      final path = '${RecordDetailPage.number}/${title}.mp4';
      final file = File(HomePage.videoFile!.path);
      final ref = FirebaseStorage.instance.ref().child(path);
      await ref.putFile(file);
      urlDownload = await ref.getDownloadURL();
      print("Download link : $urlDownload");
    } catch (e) {
      print(e);
    }
    return urlDownload;
  }

  Future<void> addUser(Users user) async {
    final docUser = FirebaseFirestore.instance.collection('users').doc();
    user.id = docUser.id;
    final json = user.toJson();
    await docUser.set(json);
  }
}

class _FireBaseState extends State<FireBase> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
