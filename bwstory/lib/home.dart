import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static File? videoFile = null;

  static showDaysAgo(Timestamp users) {
    DateTime us = users.toDate();
    int value = DateTime.now().difference(us).inDays;
    return Text("$value days ago");
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _record() async {
    final ImagePicker _picker = ImagePicker();
    XFile? video = await _picker.pickVideo(source: ImageSource.camera);
    if (video != null) {
      Image.file(File(video.path));
      setState(() {
        HomePage.videoFile = File(video.path);
      });
      Navigator.pushNamed(context, 'detail_page');
    } else {
      HomePage.videoFile = null;
    }
  }

  final CollectionReference _products =
      FirebaseFirestore.instance.collection('users');

  Future<dynamic> update(DocumentSnapshot snapshot, bool flag) async {
    bool up = flag ? false : true;
    _products.doc(snapshot['id']).update({
      'liked': up,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Blackcoffer")),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue,
        onPressed: () async {
          await _record();
        },
        child: Center(
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 50,
          ),
        ),
      ),
      body: StreamBuilder(
          stream: _products.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return Text("Something went wrong!");
            } else if (snapshot.hasData) {
              final users = snapshot.data!;
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  final DocumentSnapshot documnetSnapshot =
                      snapshot.data!.docs[index];
                  return GestureDetector(
                    onTap: () {
                      final CollectionReference _products =
                          FirebaseFirestore.instance.collection('users');
                      int views = documnetSnapshot['views'];
                      _products.doc(documnetSnapshot['id']).update({
                        'views': views + 1,
                      });
                      Navigator.pushNamed(context, 'show_video',
                          arguments: {'documnetSnapshot': documnetSnapshot});
                    },
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0XFFF1F2F6),
                              borderRadius: BorderRadius.circular(32.0),
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(4, 4),
                                  color: Colors.grey,
                                  blurRadius: 5.0,
                                ),
                                BoxShadow(
                                  offset: const Offset(-4, -4),
                                  color: Colors.white,
                                  blurRadius: 5.0,
                                  spreadRadius: 1.0,
                                )
                              ]),
                          margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
                          height:
                              MediaQuery.of(context).size.height * (30 / 100),
                          width:
                              MediaQuery.of(context).size.height * (80 / 100),
                          child: documnetSnapshot['url'] == null
                              ? Center(
                                  child: Icon(
                                    Icons.videocam,
                                    color: Colors.red,
                                    size: 50.0,
                                  ),
                                )
                              : mounted
                                  ? Chewie(
                                      controller: ChewieController(
                                        videoPlayerController:
                                            VideoPlayerController.network(
                                                documnetSnapshot['url']),
                                        aspectRatio: 16 / 16,
                                        autoPlay: true,
                                        allowMuting: true,
                                      ),
                                    )
                                  : Container(),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              color: Color(0XFFF1F2F6),
                              borderRadius: BorderRadius.circular(12.0),
                              boxShadow: [
                                BoxShadow(
                                  offset: const Offset(4, 4),
                                  color: Colors.grey,
                                  blurRadius: 5.0,
                                ),
                                BoxShadow(
                                  offset: const Offset(-4, -4),
                                  color: Colors.white,
                                  blurRadius: 5.0,
                                  spreadRadius: 1.0,
                                )
                              ]),
                          // margin: EdgeInsets.fromLTRB(30, 5, 25, 10),
                          padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                          // height: MediaQuery.of(context).size.height * (8 / 100),
                          width: MediaQuery.of(context).size.width * (85 / 100),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    documnetSnapshot['title'],
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    documnetSnapshot['address'],
                                    style: TextStyle(
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 7,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(documnetSnapshot['username']),
                                  Text("Views:${documnetSnapshot['views']}"),
                                  HomePage.showDaysAgo(
                                      documnetSnapshot['datetime']),
                                  Text("${documnetSnapshot['category']}"),
                                ],
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          }),
    );
  }
}
