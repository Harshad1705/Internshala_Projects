import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const HomePage());
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final String url = 'https://techcrunch.com/wp-json/wp/v2/posts?';
  var client = http.Client();
  dynamic data;
  bool isLoading = true;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  Future<void> fetchData() async {
    setState(() {
      isLoading = true;
    });
    http.Response response = await client.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        data = json.decode(response.body);
      });
    } else {
      throw ('error');
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
            backgroundColor: Colors.black,
            body: Stack(
              children: [
                !isLoading
                    ? Container(
                        margin: const EdgeInsets.only(top: 60),
                        child: ListView.builder(
                          itemCount: data?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            return _card(data: data[index], context: context);
                          },
                        ),
                      )
                    : const Center(
                        child: CircularProgressIndicator(),
                      ),
                Container(
                  height: 50,
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(30.0),
                      boxShadow: [
                        const BoxShadow(
                          offset: Offset(4, 4),
                          color: Colors.black,
                          blurRadius: 8.0,
                        ),
                        BoxShadow(
                          offset: const Offset(-4, -4),
                          color: Colors.grey.shade800,
                          blurRadius: 8.0,
                        )
                      ]),
                  child: const Center(
                    child: Text(
                      "Your Feed",
                      maxLines: 1,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.greenAccent,
                        fontSize: 20,
                      ),
                    ),
                  ),
                )
              ],
            )),
      ),
    );
  }

  _card({required data, required context}) {
    String completeName = data["parselyMeta"]["parsely-author"][0].toString();
    String userName = "@${completeName.toLowerCase().replaceAll(" ", "")}";

    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(32.0),
          boxShadow: [
            const BoxShadow(
              offset: Offset(4, 4),
              color: Colors.black,
              blurRadius: 8.0,
            ),
            BoxShadow(
              offset: const Offset(-4, -4),
              color: Colors.grey.shade800,
              blurRadius: 8.0,
            )
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // user details row.....
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      const BoxShadow(
                        offset: Offset(2, 2),
                        color: Colors.black,
                        blurRadius: 4,
                      ),
                      BoxShadow(
                        offset: const Offset(-2, -2),
                        color: Colors.grey.shade800,
                        blurRadius: 4,
                      )
                    ]),
                child: CircleAvatar(
                  minRadius: MediaQuery.of(context).size.width / 16,
                  foregroundColor: Colors.black,
                  backgroundColor: Colors.white60,
                  child: const Icon(Icons.account_circle_rounded),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                padding: const EdgeInsets.all(10),
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(30.0),
                    boxShadow: [
                      const BoxShadow(
                        offset: Offset(2, 2),
                        color: Colors.black,
                        blurRadius: 8.0,
                      ),
                      BoxShadow(
                        offset: const Offset(-2, -2),
                        color: Colors.grey.shade800,
                        blurRadius: 8.0,
                      )
                    ]),
                child: Column(
                  children: [
                    Text(
                      completeName,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width / 20,
                      ),
                    ),
                    Text(
                      userName,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: MediaQuery.of(context).size.width / 25,
                      ),
                    ),
                    getTime(data['date_gmt'], context)
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          // Image & Title column.....
          Container(
            margin: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        const BoxShadow(
                          offset: Offset(2, 2),
                          color: Colors.black,
                          blurRadius: 8.0,
                        ),
                        BoxShadow(
                          offset: const Offset(-2, -2),
                          color: Colors.grey.shade800,
                          blurRadius: 8.0,
                        )
                      ]),
                  child: Text(
                    data["parselyMeta"]["parsely-title"].toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: MediaQuery.of(context).size.width / 22,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        const BoxShadow(
                          offset: Offset(2, 2),
                          color: Colors.black,
                          blurRadius: 8.0,
                        ),
                        BoxShadow(
                          offset: const Offset(-2, -2),
                          color: Colors.grey.shade800,
                          blurRadius: 8.0,
                        )
                      ]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      data["parselyMeta"]["parsely-image-url"],
                      width: MediaQuery.of(context).size.width / 1.5,
                      height: MediaQuery.of(context).size.width / 2,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          // user action row(like, comment etc.).....
          Container(
            margin: const EdgeInsets.only(left: 30, right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          const BoxShadow(
                            offset: Offset(2, 2),
                            color: Colors.black,
                            blurRadius: 8.0,
                          ),
                          BoxShadow(
                            offset: const Offset(-2, -2),
                            color: Colors.grey.shade800,
                            blurRadius: 8.0,
                          )
                        ]),
                    child: const Icon(
                      Icons.comment_bank_outlined,
                      color: Colors.white,
                    )),
                Text(
                  "51",
                  maxLines: 1,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width / 18,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        const BoxShadow(
                          offset: Offset(2, 2),
                          color: Colors.black,
                          blurRadius: 8.0,
                        ),
                        BoxShadow(
                          offset: const Offset(-2, -2),
                          color: Colors.grey.shade800,
                          blurRadius: 8.0,
                        )
                      ]),
                  child: const Icon(
                    Icons.repeat_outlined,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "51",
                  maxLines: 1,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width / 18,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        const BoxShadow(
                          offset: Offset(2, 2),
                          color: Colors.black,
                          blurRadius: 8.0,
                        ),
                        BoxShadow(
                          offset: const Offset(-2, -2),
                          color: Colors.grey.shade800,
                          blurRadius: 8.0,
                        )
                      ]),
                  child: const Icon(
                    Icons.thumb_up_alt_outlined,
                    color: Colors.white,
                  ),
                ),
                Text(
                  "51",
                  maxLines: 1,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: MediaQuery.of(context).size.width / 18,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10.0),
                      boxShadow: [
                        const BoxShadow(
                          offset: Offset(2, 2),
                          color: Colors.black,
                          blurRadius: 8.0,
                        ),
                        BoxShadow(
                          offset: const Offset(-2, -2),
                          color: Colors.grey.shade800,
                          blurRadius: 8.0,
                        )
                      ]),
                  child: const Icon(
                    Icons.bar_chart_sharp,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }

  getTime(var apiDate, BuildContext context) {
    DateTime publishDate = DateTime.parse(apiDate.toString());
    return Center(
      child: Text(
        "${DateTime.now().difference(publishDate).inHours} hrs ago",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.greenAccent,
          fontSize: MediaQuery.of(context).size.width / 30,
        ),
      ),
    );
  }
}
