import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:suip_me/components.dart';
import 'package:suip_me/savedImages.dart';
import 'package:suip_me/search.dart';
import 'package:suip_me/sharedData.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static String api_key = "NuEyiK0Pp8qnKu6u_gT-nQsos86--trekkKN9lAo_KY";
  static List<String> list = [];
  static String img =
      'https://images.unsplash.com/photo-1677833766807-5598cc321858?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=Mnw0MTg3NDR8MHwxfHJhbmRvbXx8fHx8fHx8fDE2NzgwMzMzNzI&ixlib=rb-4.0.3&q=80&w=1080';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool search = false;

  Future fetchRandomImage() async {
    final response = await Dio().get(
        "https://api.unsplash.com/photos/random?client_id=${HomePage.api_key}");
    if (response.statusCode == 200) {
      var list = response.data;
      String res = (list['urls']['regular']);
      setState(() {
        HomePage.img = res;
      });
    } else {
      throw Exception('Failed to fetch random image');
    }
  }

  searchImages(String query) async {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const SearcheImage(),
      ),
    );
  }

  saveImage() {
    if (!HomePage.list.contains(HomePage.img)) {
      HomePage.list.add(HomePage.img);
      List<String> mg = Preferences.readData()==null ? [] : Preferences.readData();
      if ( !mg.contains(mg)) {
        mg.add(HomePage.img);
        Preferences.writeData(mg);
      }
    } else {
      SnackBar sb = SnackBar(content: Text("Image Already Saved"));
      ScaffoldMessenger.of(context).showSnackBar(sb);
    }
  }

  savedPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const SavedImages(),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fetchRandomImage();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff444654),
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Unspalsh Api"),
              IconButton(
                  onPressed: () {
                    searchImages("zebra");
                  },
                  icon: Icon(Icons.search)),
            ],
          ),
          backgroundColor: Color(0xff444654),
        ),
        body: Padding(
          padding: const EdgeInsets.only(top: 20.0, bottom: 50),
          child: Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              search
                  ? Center()
                  : Column(
                      children: [
                        Components.imgContainer(context,HomePage.img),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Components.buttons("Next", () {
                              fetchRandomImage();
                            }),
                            Components.buttons("Save", () {
                              saveImage();
                            }),
                          ],
                        ),
                      ],
                    ),
              Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Components.buttons("Saved Images", () {
                    savedPage();
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
