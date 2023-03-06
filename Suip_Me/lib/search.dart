import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:suip_me/home.dart';

import 'components.dart';

class SearcheImage extends StatefulWidget {
  const SearcheImage({Key? key}) : super(key: key);

  @override
  State<SearcheImage> createState() => _SearcheImageState();
}

class _SearcheImageState extends State<SearcheImage> {
  TextEditingController value = TextEditingController();
  List images = [];

  Future getSearchedImage(String query) async {
    images.clear();
    final response = await Dio().get(
        'https://api.unsplash.com/search/photos?client_id=${HomePage.api_key}&query=$query');
    if (response.statusCode == 200) {
      var res = response.data;
      for (int i = 0; i < 10; i++) {
        images.add(res['results'][i]['urls']['regular']);
      }
      setState(() {});
      return res['results'];
    } else {

      throw Exception('Failed to search for images');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff444654),
        appBar: AppBar(
          title: Text("Image Search"),
          backgroundColor: Color(0xff444654),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.black38),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: TextFormField(
                        maxLength: 50,
                        controller: value,
                        obscureText: false,
                        cursorColor: Colors.white,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w500,
                        ),
                        decoration: InputDecoration(
                          counterText: "",
                          contentPadding: const EdgeInsets.all(18.0),
                          border: InputBorder.none,
                          hintText: "India",
                          hintStyle: TextStyle(
                            color: Colors.white24,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.search),
                      onPressed: () {
                        getSearchedImage(value.text);
                      },
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: images.length,
                      itemBuilder: (context, index) {
                        return Components.imgContainer(context, images[index]);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
