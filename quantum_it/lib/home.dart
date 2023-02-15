import 'dart:convert';
import 'dart:io';

import 'package:easy_search_bar/easy_search_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'Modal/modal.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var client = http.Client();
  List<Article> articles = [];

  Future<dynamic> get({required String searchValue}) async {
    bool network = await InternetConnectionChecker().hasConnection;
    if (network) {
      String date = DateTime.now().toString().split(' ')[0];
      String baseUrl =
          "https://newsapi.org/v2/everything?q=${searchValue}&from=${date}&sortBy=publishedAt&apiKey=7d67a42c3f104b4caa9a35a072457d22";
      var url = Uri.parse(baseUrl);
      var response = await client.get(url);
      if (response.statusCode == 200) {
        var res = response.body.toString();
        News news = newsFromJson(res);
        setState(() {
          articles = news.articles!;
        });
      }
    } else {
      SnackBar sb = SnackBar(content: Text("No Internet"));
      ScaffoldMessenger.of(context).showSnackBar(sb);
    }
  }

  @override
  void initState() {
    get(searchValue: "India");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: EasySearchBar(
          leading: IconButton(
            color: Colors.blueAccent,
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              SnackBar sb = SnackBar(content: Text("LogOut Successfull"));
              ScaffoldMessenger.of(context).showSnackBar(sb);
              Navigator.pushReplacementNamed(context, '/account');
            },
            icon: Icon(Icons.logout),
          ),
          backgroundColor: Colors.white,
          title: Center(
            child: Text(
              'Search for Feed',
              style: TextStyle(color: Colors.blueAccent),
            ),
          ),
          iconTheme: IconThemeData(color: Colors.blueAccent),
          onSearch: (value) async {
            await get(searchValue: value);
          },
        ),
        body: ListView.builder(
            itemCount: articles.length,
            itemBuilder: (context, index) {
              return _articleBox(articles[index]);
            }),
      ),
    );
  }

  _articleBox(Article article) {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 20, right: 20),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            offset: Offset(1, 3),
            color: Colors.black26,
          ),
          BoxShadow(
            blurRadius: 5,
            color: Colors.black26,
            offset: Offset(-1, -1),
          ),
        ],
      ),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 6,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  _getTime(
                      article.publishedAt
                          .toString()
                          .replaceAll('Z', '')
                          .replaceAll('.000', ''),
                      context),
                  SizedBox(
                    width: 2,
                  ),
                  Container(
                    child: Text(
                      "${article.source!.name}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  )
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width / 1.8,
                height: MediaQuery.of(context).size.height / 17,
                child: Text(
                  "${article.title}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.blue.shade600,
                    fontSize: 20,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 25,
                width: MediaQuery.of(context).size.width / 1.8,
                child: Text(
                  "${article.description}",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          article.urlToImage != null
              ? Image.network(
                  article.urlToImage.toString(),
                  height: MediaQuery.of(context).size.height / 10,
                  width: MediaQuery.of(context).size.height / 10,
                )
              : Center(),
        ],
      ),
    );
  }

  _getTime(String apiDate, BuildContext context) {
    DateTime publishDate = DateTime.parse(apiDate);
    return Container(
      child: Text(
        "${DateTime.now().difference(publishDate).inHours} hrs ago",
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: Colors.grey,
          fontSize: 12,
        ),
      ),
    );
  }
}
