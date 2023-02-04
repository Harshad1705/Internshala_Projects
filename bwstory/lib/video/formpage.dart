import 'dart:io';

import 'package:bwstory/home.dart';
import 'package:chewie/chewie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:video_player/video_player.dart';

import 'firebase.dart';
import 'model.dart';

class RecordDetailPage extends StatefulWidget {
  const RecordDetailPage({Key? key}) : super(key: key);
  static String? number = "";
  @override
  State<RecordDetailPage> createState() => _RecordDetailPageState();
}

class _RecordDetailPageState extends State<RecordDetailPage> {
  final VideoPlayerController controller =
      VideoPlayerController.file(HomePage.videoFile as File);
  final TextEditingController controllerUsername = TextEditingController();
  final TextEditingController controllerTitle = TextEditingController();
  final TextEditingController controllerCategory = TextEditingController();
  final TextEditingController controllerDesc = TextEditingController();

  double high = 7.0;
  String Address = 'search';
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    var user = _auth.currentUser;
    RecordDetailPage.number = user?.phoneNumber;
    print(
        "This is the number  :::::::::::::::::::::::::::::::::::::::::::::${RecordDetailPage.number}");
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  _form({
    required String hint,
    required int length,
    required TextEditingController controller,
  }) {
    double height = 7.0;
    return Container(
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
      padding: EdgeInsets.fromLTRB(20, 10, 10, 0),
      margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
      height: MediaQuery.of(context).size.height * (height / 100),
      width: MediaQuery.of(context).size.height * (80 / 100),
      child: TextField(
        expands: true,
        controller: controller,
        maxLines: null,
        maxLength: length,
        onChanged: (value) {
          setState(() {
            height = (value.length / 28.0);
            height = height * 7.0;
            print(height);
          });
        },
        style: TextStyle(
          letterSpacing: 2,
          fontSize: 18,
        ),
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          counterText: "",
        ),
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    Address = '${place.locality},${place.country}';
    // '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
  }

  _submit() {
    return GestureDetector(
      onTap: () async {
        String username = controllerUsername.text;
        String title = controllerTitle.text;
        String category = controllerCategory.text;
        String desc = controllerDesc.text;
        if (username.length >= 1 &&
            title.length >= 1 &&
            category.length >= 1 &&
            desc.length >= 1) {
          Position loc = await _determinePosition();
          await GetAddressFromLatLong(loc);
          print(Address);
          print(HomePage.videoFile);

          String url = await FireBase().upload(title: title);

          Users user = Users(
            username: username,
            datetime: DateTime.now(),
            url: url,
            title: title,
            category: category,
            description: desc,
            number: RecordDetailPage.number.toString(),
            address: Address,
            liked: 0,
            disliked: 0,
          );

          await FireBase().addUser(user);
          print("Upload successfull");
          Navigator.pushNamed(context, 'home');
        } else {
          SnackBar snackbar = SnackBar(
            content: Text("Fill all the fields"),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueAccent,
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
          ],
        ),
        margin: EdgeInsets.fromLTRB(25, 30, 25, 10),
        height: MediaQuery.of(context).size.height * (6 / 100),
        width: MediaQuery.of(context).size.width * (30 / 100),
        child: Center(
          child: Text(
            "Submit",
            style: TextStyle(
              fontSize: 20,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
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
                height: MediaQuery.of(context).size.height * (50 / 100),
                width: MediaQuery.of(context).size.height * (80 / 100),
                child: HomePage.videoFile == null
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
                              videoPlayerController: controller,
                              aspectRatio: 16 / 16,
                              autoPlay: true,
                              looping: true,
                            ),
                          )
                        : Container(),
              ),
              _form(
                hint: "Username",
                length: 25,
                controller: controllerUsername,
              ),
              _form(
                hint: "Title",
                length: 25,
                controller: controllerTitle,
              ),
              _form(
                hint: "Category",
                length: 25,
                controller: controllerCategory,
              ),
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
                padding: EdgeInsets.fromLTRB(20, 10, 10, 0),
                margin: EdgeInsets.fromLTRB(25, 10, 25, 10),
                height: MediaQuery.of(context).size.height * (high / 100),
                width: MediaQuery.of(context).size.height * (80 / 100),
                child: TextField(
                  expands: true,
                  controller: controllerDesc,
                  maxLines: null,
                  maxLength: 250,
                  onChanged: (value) {
                    setState(() {
                      if (value.length > 30) {
                        high = (value.length / 28.0);
                        high = high * 7.0;
                      }
                    });
                  },
                  style: TextStyle(
                    letterSpacing: 2,
                    fontSize: 18,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Description",
                    counterText: "",
                  ),
                ),
              ),
              _submit(),
            ],
          ),
        ),
      ),
    );
  }
}
