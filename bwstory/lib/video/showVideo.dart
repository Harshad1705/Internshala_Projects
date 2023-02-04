import 'package:bwstory/home.dart';
import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class ShowVideo extends StatefulWidget {
  ShowVideo({Key? key}) : super(key: key);

  @override
  State<ShowVideo> createState() => _ShowVideoState();
}

class _ShowVideoState extends State<ShowVideo> {
  final CollectionReference _products =
      FirebaseFirestore.instance.collection('users');

  bool likeIcon = false;
  bool dislikeIcon = false;

  @override
  Widget build(BuildContext context) {
    final ds = ModalRoute.of(context)!.settings.arguments as Map;
    return Scaffold(
      appBar: AppBar(
        title: Text("${ds['documnetSnapshot']['username']}"),
      ),
      body: Column(
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
            height: MediaQuery.of(context).size.height * (30 / 100),
            width: MediaQuery.of(context).size.height * (80 / 100),
            child: ds['documnetSnapshot']['url'] == null
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
                          videoPlayerController: VideoPlayerController.network(
                              ds['documnetSnapshot']['url']),
                          aspectRatio: 16 / 16,
                          autoPlay: true,
                          looping: true,
                        ),
                      )
                    : Container(),
          ),
          _designBox(
            ds: ds,
            child: Center(
              child: Text(
                ds['documnetSnapshot']['title'],
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          _designBox(
            ds: ds,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    bool like = ds['documnetSnapshot']['like'];
                    int liked = ds['documnetSnapshot']['liked'];
                    bool dislike = ds['documnetSnapshot']['dislike'];
                    int disliked = ds['documnetSnapshot']['disliked'];
                    if (like) {
                      _products.doc(ds['documnetSnapshot']['id']).update({
                        'like': false,
                        'liked': liked - 1,
                      });
                      setState(() {
                        likeIcon = false;
                      });
                    } else {
                      if (dislike) {
                        _products.doc(ds['documnetSnapshot']['id']).update({
                          'dislike': false,
                          'disliked': disliked - 1,
                        });
                      }
                      _products.doc(ds['documnetSnapshot']['id']).update({
                        'like': true,
                        'liked': liked + 1,
                      });
                      setState(() {
                        likeIcon = true;
                        dislikeIcon = false;
                      });
                    }
                  },
                  child: Icon(
                    Icons.thumb_up_outlined,
                    color: likeIcon ? Colors.blueAccent : Colors.grey,
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      bool like = ds['documnetSnapshot']['like'];
                      int liked = ds['documnetSnapshot']['liked'];
                      bool dislike = ds['documnetSnapshot']['dislike'];
                      int disliked = ds['documnetSnapshot']['disliked'];

                      if (dislike) {
                        _products.doc(ds['documnetSnapshot']['id']).update({
                          'dislike': false,
                          'disliked': disliked - 1,
                        });
                        setState(() {
                          dislikeIcon = false;
                        });
                      } else {
                        if (like) {
                          _products.doc(ds['documnetSnapshot']['id']).update({
                            'like': false,
                            'liked': liked - 1,
                          });
                        }
                        _products.doc(ds['documnetSnapshot']['id']).update({
                          'dislike': true,
                          'disliked': disliked + 1,
                        });
                        setState(() {
                          dislikeIcon = true;
                          likeIcon = false;
                        });
                      }
                    },
                    child: Icon(
                      Icons.thumb_down_alt_outlined,
                      color: dislikeIcon ? Colors.blueAccent : Colors.grey,
                    )),
                GestureDetector(
                  child: Icon(Icons.share),
                ),
              ],
            ),
          ),
          _designBox(
            ds: ds,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Views:${ds['documnetSnapshot']['views'].toString()}"),
                HomePage.showDaysAgo(ds['documnetSnapshot']['datetime']),
                Text("Category:${ds['documnetSnapshot']['category']}"),
              ],
            ),
          ),
        ],
      ),
    );
  }

// true->like;
//   false->dislike;
  Future<dynamic> update(DocumentSnapshot snapshot, bool flag) async {
    bool up = flag ? false : true;
    _products.doc(snapshot['id']).update({
      'liked': up,
    });
  }

  _designBox({required Map ds, required Widget child}) {
    return Container(
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
        margin: EdgeInsets.fromLTRB(30, 5, 25, 10),
        padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
        // height: MediaQuery.of(context).size.height * (8 / 100),
        width: MediaQuery.of(context).size.width * (85 / 100),
        child: child);
  }
}
