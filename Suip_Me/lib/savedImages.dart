import 'package:flutter/material.dart';
import 'package:suip_me/sharedData.dart';

class SavedImages extends StatefulWidget {
  const SavedImages({Key? key}) : super(key: key);

  @override
  State<SavedImages> createState() => _SavedImagesState();
}

class _SavedImagesState extends State<SavedImages> {

  List<String> read = [];

  @override
  void initState() {
    super.initState();
    read = Preferences.readData();
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xff444654),
      appBar: AppBar(
        title: Text("Saved Images"),
        backgroundColor: Color(0xff444654),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: read.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: MediaQuery.of(context).size.width * 0.15),
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: MediaQuery.of(context).size.width * 0.7,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xff444654),
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(read[index]),
                    ),
                  ),
                  // child: Image.network(),
                );
              },
            ),
          ),
        ],
      ),
    ));
  }
}
