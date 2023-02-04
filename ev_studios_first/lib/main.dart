import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'home.dart';

void main() async {
  var url = Uri.parse('https://api.sampleapis.com/futurama/characters');
  var response = await http.Client().get(url);

  runApp(MyApp(response: response));
}

class MyApp extends StatelessWidget {
  final response;
  const MyApp({super.key, this.response});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(response: response),
    );
  }
}
