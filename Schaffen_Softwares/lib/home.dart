import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:swipe/swipe.dart';
import 'package:swipe_to/swipe_to.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> imagBar = [
    "image_49.png",
    "image_71.png",
    "image_49.png",
    "image_71.png",
  ];
  int imgIndex = 0;
  // bool not_show_anything = true;
  bool show_like = false;
  bool show_nope = false;
  bool is_photo_page = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffFFFFFF),
        body: Stack(
          alignment: AlignmentDirectional.bottomCenter,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15, top: 20, bottom: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage:
                                AssetImage('assets/images/image_65.png'),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "150",
                            style: TextStyle(
                              fontSize: 10,
                              color: Color(0xffF4B514),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Image.asset('assets/images/diamond.png'),
                          SizedBox(
                            width: 20,
                          ),
                          Icon(
                            Icons.notifications_none,
                            color: Color(0xff858585),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Image.asset('assets/images/setting.png'),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Welcome,",
                    style: TextStyle(
                        fontFamily: "Pangolin",
                        fontWeight: FontWeight.w400,
                        color: Color(0xff3A3A3A),
                        fontStyle: FontStyle.normal),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text(
                    "Shikha Gaur!",
                    style: TextStyle(
                        fontFamily: "Pangolin",
                        fontSize: 30,
                        fontWeight: FontWeight.w300,
                        color: Color(0xfff4E5ED9),
                        fontStyle: FontStyle.normal),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  SwipeTo(
                    iconSize: 0,
                    onLeftSwipe: () {
                      setState(() {
                        show_nope = true;
                        show_like = false;
                      });
                    },
                    onRightSwipe: () {
                      setState(() {
                        show_like = true;
                        show_nope = false;
                      });
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        image: is_photo_page
                            ? DecorationImage(
                                image: AssetImage(
                                    "assets/images/${imagBar[imgIndex]}"),
                                fit: BoxFit.cover)
                            : null,
                      ),
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 0.57,
                      child: is_photo_page
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  children: [
                                    Column(
                                      children: [
                                        Container(
                                          height: 4,
                                          child: ListView.builder(
                                            scrollDirection: Axis.horizontal,
                                            shrinkWrap: true,
                                            physics:
                                                NeverScrollableScrollPhysics(),
                                            itemCount: imagBar.length,
                                            itemBuilder: (context, index) {
                                              return Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.20,
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 20,
                                                    vertical: 10),
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 5),
                                                decoration: BoxDecoration(
                                                    color: index == imgIndex
                                                        ? Colors.white
                                                        : Colors.grey,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5)),
                                              );
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  imgIndex = (imgIndex - 1) %
                                                      imagBar.length;
                                                });
                                              },
                                              child: Image.asset(
                                                  'assets/images/left.png'),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                setState(() {
                                                  imgIndex = (imgIndex + 1) %
                                                      imagBar.length;
                                                });
                                              },
                                              child: Image.asset(
                                                  'assets/images/right.png'),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        show_like
                                            ? like_get_box(context, "LIKE",
                                                Color(0xff09EE57))
                                            : Center(),
                                        show_nope
                                            ? like_get_box(context, "NOPE",
                                                Color(0xffF83C27))
                                            : Center(),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Samara Doe, 26",
                                          style: TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "Philosopher",
                                            fontStyle: FontStyle.normal,
                                            color: Color(0xffFFFFFF),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 5,
                                        ),
                                        Stack(
                                          alignment:
                                              AlignmentDirectional.center,
                                          children: [
                                            SvgPicture.asset(
                                              'assets/images/greentick.svg',
                                            ),
                                            Icon(
                                              Icons.done,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "Lives in Spain",
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Outfit",
                                        fontStyle: FontStyle.normal,
                                        color: Color(0xffFFFFFF),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                                'assets/images/star.png'),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "23.1",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400,
                                                fontFamily: "Outfit",
                                                fontStyle: FontStyle.normal,
                                                color: Color(0xffE6E6E6),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Icon(
                                          Icons.more_vert,
                                          color: Color(0xffE6E6E6),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            )
                          : Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundImage: AssetImage(
                                      'assets/images/${imagBar[imgIndex]}'),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Samara Doe",
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: "Philosopher",
                                        fontStyle: FontStyle.normal,
                                        color: Color(0xff565656),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Stack(
                                      alignment: AlignmentDirectional.center,
                                      children: [
                                        SvgPicture.asset(
                                          'assets/images/greentick.svg',
                                        ),
                                        Icon(
                                          Icons.done,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Text(
                                  "Lives in Spain",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Outfit",
                                    // fontStyle: FontStyle.normal,
                                    color: Colors.black,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.only(top: 15),
                                  width:
                                      MediaQuery.of(context).size.width * 0.8,
                                  child: Text(
                                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                                    style: TextStyle(
                                      fontFamily: "Outfit",
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: Color(0xff666666),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Interest",
                                  style: TextStyle(
                                    fontFamily: "Philosopher",
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    interest_Box("Pets"),
                                    interest_Box("Religion"),
                                    interest_Box("Psycholgy"),
                                  ],
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    interest_Box("Music"),
                                    interest_Box("Cosplay"),
                                  ],
                                ),
                              ],
                            ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      getContainer("cancel.png"),
                      getContainer("glodenStar.png"),
                      getContainer("check.png"),
                    ],
                  ),
                ],
              ),
            ),
            Stack(
              alignment: AlignmentDirectional.bottomCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    color: Color.fromRGBO(78, 94, 217, 0.1),
                  ),
                  height: MediaQuery.of(context).size.height * 0.08,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        child: Image.asset('assets/images/people.png'),
                        height: 30,
                        width: 30,
                      ),
                      SizedBox(
                        child: Image.asset('assets/images/girl.png'),
                        height: 30,
                        width: 30,
                      ),
                      Text(
                        "\nSwipe",
                        style: TextStyle(
                            fontFamily: "Pangolin",
                            fontSize: 13,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff3A3A3A),
                            fontStyle: FontStyle.normal),
                      ),
                      SizedBox(
                        child: Image.asset('assets/images/contacts.png'),
                        height: 30,
                        width: 30,
                      ),
                      SizedBox(
                        child: Image.asset('assets/images/chat.png'),
                        height: 30,
                        width: 30,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.white,
                  width: 6,
                ),
                borderRadius: BorderRadius.circular(50),
              ),
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * 0.04, left: 0),
              child: FloatingActionButton(
                backgroundColor: Color(0xff4E5ED8),
                child: Center(child: Image.asset('assets/images/thumb.png')),
                onPressed: () {
                  setState(() {
                    is_photo_page = !is_photo_page;
                    show_nope = false;
                    show_like = false;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container interest_Box(String value) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xffFE6067),
      ),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: Center(
          child: Text(
        value,
        style: TextStyle(
            fontFamily: "Outfit",
            fontSize: 14,
            color: Colors.white,
            fontWeight: FontWeight.bold),
      )),
    );
  }

  Container like_get_box(BuildContext context, String name, Color color) {
    return Container(
      decoration: BoxDecoration(
        // color : Colors.red,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color, width: 2),
      ),
      height: MediaQuery.of(context).size.height * 0.07,
      width: MediaQuery.of(context).size.width * 0.25,
      child: Center(
        child: Text(
          name,
          style: TextStyle(
            // fontFamily: "Outfit",
            color: color,
            fontSize: 32,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget getContainer(String abc) {
    return Container(
      height: 50,
      width: 50,
      // box-shadow: 0px 4px 10px 0px #0000001A;
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 2),
              color: Colors.grey.shade300,
              blurRadius: 5,
              spreadRadius: 0.1,
            ),
            BoxShadow(
              offset: Offset(2, 0),
              color: Colors.grey.shade300,
              blurRadius: 5,
              spreadRadius: 0.1,
            ),
          ]),
      child: Center(
        child: Image.asset("assets/images/$abc"),
      ),
    );
  }
}
