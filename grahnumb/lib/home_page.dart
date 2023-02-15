import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String url = 'https://techcrunch.com/wp-json/wp/v2/posts?';
  var client = http.Client();
  var users;
  int len = 0;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    http.Response response = await client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        users = json.decode(response.body);
        len = users.length;
      });
      print(users.length);
    } else {
      throw ('error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: len,
          itemBuilder: (BuildContext context, int index) {
            return _card(data: users[index]);
          },
        ),
      ),
    );
  }

  _card({required data}) {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage:
              NetworkImage(data["parselyMeta"]["parsely-image-url"]),
        ),
        Column(
          children: [
            Row(
              children: const [
                Expanded(
                  child: Text(
                    'It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout.',
                    style: TextStyle(fontSize: 58),
                    softWrap: false,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis, // new
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }

  _getTime({required time}) {
    DateTime dt = DateTime.parse(time);

    return Expanded(
      child: Text(
        DateTime.now().difference(dt).inMinutes.toString() + "min",
        overflow: TextOverflow.fade,
        style: Theme.of(context).textTheme.bodySmall,
        maxLines: 1,
        softWrap: false,
      ),
    );
  }
}
