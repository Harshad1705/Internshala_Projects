import 'package:flutter/material.dart';

class Content extends StatefulWidget {
  final int index;
  final detail;
  const Content({Key? key, required this.index, this.detail}) : super(key: key);

  @override
  State<Content> createState() => _ContentState();
}

class _ContentState extends State<Content> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff343541),
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Color(0xff343541),
          title: Center(
            child: Text(
                " ${widget.detail[widget.index]["name"]["first"]} ${widget.detail[widget.index]["name"]["middle"]} ${widget.detail[widget.index]["name"]["last"]}"),
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(left: 10, right: 10, top: 25, bottom: 25),
          padding: EdgeInsets.only(top: 15, left: 10, right: 10, bottom: 15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Color(0xff444654),
          ),
          child: ListView.builder(
            itemCount: widget.detail[widget.index]["sayings"].length,
            itemBuilder: (context, index) {
              return Text(
                "${widget.detail[widget.index]["sayings"][index]}" + "\n",
                style: TextStyle(
                  wordSpacing: 2,
                  letterSpacing: 2,
                  color: Colors.white,
                  fontSize: 16,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
