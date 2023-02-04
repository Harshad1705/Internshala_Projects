import 'package:bwstory/home.dart';
import 'package:bwstory/login/phone.dart';
import 'package:bwstory/login/verify.dart';
import 'package:bwstory/video/formpage.dart';
import 'package:bwstory/video/showVideo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      initialRoute: 'phone',
      debugShowCheckedModeBanner: false,
      routes: {
        'phone': (context) => MyPhone(),
        'verify': (context) => MyVerify(),
        'home': (context) => HomePage(),
        'detail_page': (context) => RecordDetailPage(),
        'show_video': (context) => ShowVideo(),
      },
    ),
  );
}
