import 'dart:convert';

import 'package:flutter/material.dart';

import 'content.dart';

class HomePage extends StatefulWidget {
  final response;
  const HomePage({Key? key, this.response}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var detail;
  @override
  void initState() {
    detail = jsonDecode(widget.response.body);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff343541),
        appBar: AppBar(
          title: Center(child: Text("News Article")),
          backgroundColor: Color(0xff343541),
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: ListView.builder(
              itemCount: detail.length,
              itemBuilder: (context, index) {
                return buildContainer(index);
              }),
        ),
      ),
    );
  }

  Container buildContainer(int index) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff444654),
        borderRadius: BorderRadius.circular(5),
      ),
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.only(left: 10),
      height: MediaQuery.of(context).size.height * (8 / 100),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: Colors.white,
            child: Image.network(detail[index]["images"]["main"]),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * (3 / 100),
          ),
          Container(
            width: MediaQuery.of(context).size.width * (60 / 100),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  " ${detail[index]["name"]["first"]} ${detail[index]["name"]["middle"]} ${detail[index]["name"]["last"]} ",
                  style: TextStyle(
                    letterSpacing: 1.5,
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                  ),
                ),
                Text(
                  "${detail[index]["occupation"]}",
                  overflow: TextOverflow.clip,
                  maxLines: 2,
                  softWrap: true,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) =>
                      Content(detail: detail, index: index),
                ),
              );
            },
            icon: Icon(
              Icons.forward,
              size: 25,
            ),
          ),
        ],
      ),
    );
  }
}
