import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final CollectionReference docRef =
    FirebaseFirestore.instance.collection('users');

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, String> ctaData = {
    "CTA-1": "assets/images/cta1.png",
    "CTA-2": "assets/images/cta2.png",
    "CTA-3": "assets/images/cta2.png",
  };
  List<List<String>> articleData = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: getBottomNavigationBar(), // Google Nav bar
        backgroundColor: const Color(0xff02012D),
        body: StreamBuilder(
            stream: docRef.snapshots(),
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
                      for (int i = 0;
                          i < documnetSnapshot["articles"].length;
                          i++) {
                        List<String> b = [];
                        b.add(documnetSnapshot["articles"][i]["article_name"]);
                        b.add(documnetSnapshot["articles"][i]["article_img"]);
                        b.add(documnetSnapshot["articles"][i]["article_data"]);
                        articleData.add(b);
                      }
                      return Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),
                              getHeader(documnetSnapshot[
                                  "name"]), // Top Header Profile
                              const SizedBox(height: 20),
                              getProfilePercentage(), // Profile Percentage Container
                              const SizedBox(height: 20),
                              Text(
                                "Section Title 1",
                                textAlign: TextAlign.start,
                                style: GoogleFonts.outfit(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
                              getSectionCTA(), // CTA List Section 1
                              const SizedBox(height: 20),
                              Text(
                                "Section Title 2",
                                textAlign: TextAlign.start,
                                style: GoogleFonts.outfit(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 20),
                              getSection2CTA(documnetSnapshot[
                                  "doctor_name"] , documnetSnapshot[
                              "specialist"]), // CTA Section 2
                              const SizedBox(height: 20),
                              getArticleCard(), // Card Title - Articles with ViewMore Button
                              const SizedBox(height: 20),
                            ],
                          ),
                        ),
                      );
                    });
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }

  getHeader(String name) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset("assets/images/profileIcon.png"),
        const Spacer(flex: 1),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Good afternoon",
              textAlign: TextAlign.start,
              style: GoogleFonts.outfit(
                color: Colors.white,
              ),
            ),
            Text(
              name,
              textAlign: TextAlign.start,
              style: GoogleFonts.outfit(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const Spacer(flex: 8),
        const Icon(
          Icons.chat,
          color: Colors.white,
        ),
        const Spacer(flex: 1),
        const Icon(
          Icons.notifications,
          color: Colors.white,
        ),
      ],
    );
  } // Profile Header

  getProfilePercentage() {
    return Container(
      height: MediaQuery.of(context).size.height / 10,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xff1B2152),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CircularPercentIndicator(
            radius: 20.0,
            lineWidth: 1.0,
            percent: 0.7,
            startAngle: 180,
            center: Text(
              "70%",
              style: GoogleFonts.outfit(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            progressColor: Colors.yellowAccent,
          ),
          Text(
            "Please complete your profile to book\n consultations.",
            textAlign: TextAlign.start,
            style: GoogleFonts.outfit(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  } // Profile %

  getSectionCTA() {
    return Container(
      height: MediaQuery.of(context).size.height / 6,
      decoration: BoxDecoration(
        color: const Color(0xff02012D),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          getCTAContainer("CTA-1"),
          getCTAContainer("CTA-2"),
          getCTAContainer("CTA-3"),
        ],
      ),
    );
  } // CTA Section 1

  getCTAContainer(String cta) {
    return Container(
      height: MediaQuery.of(context).size.height / 6,
      width: MediaQuery.of(context).size.width / 3.5,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xff1B2152),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset(ctaData[cta]!),
          Text(
            cta,
            style: GoogleFonts.outfit(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  } // CTA Section 1 Containers

  getSection2CTA(String name , String specialist) {
    return Container(
      height: MediaQuery.of(context).size.height / 10,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xff1B2152),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Image.asset("assets/images/selectedCTA.png"),
          const Spacer(
            flex: 1,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                name,
                textAlign: TextAlign.start,
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                specialist,
                textAlign: TextAlign.start,
                style: GoogleFonts.outfit(
                  fontSize: 12,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          const Spacer(
            flex: 10,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 4,
            child: ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(
                    const Color(0xff1051E3),
                  ),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ))),
              onPressed: () {},
              child: Text(
                "CTA",
                textAlign: TextAlign.start,
                style: GoogleFonts.outfit(
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  } // CTA Section 2

  getArticleCard() {
    return Container(
      height: MediaQuery.of(context).size.height / 2.5,
      decoration: BoxDecoration(
        color: const Color(0xff1B2152),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 5),
            child: Text(
              "Card Title",
              textAlign: TextAlign.start,
              style: GoogleFonts.outfit(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          getArticles(0),
          getArticles(1),
          getArticles(2),
          getViewMoreButton(),
        ],
      ),
    );
  } // Article Card

  getArticles(int index) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          border: BorderDirectional(
              bottom: BorderSide(
        color: Color(0xff02012D),
      ))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(articleData[index][1]),
          const Spacer(
            flex: 1,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                articleData[index][0],
                textAlign: TextAlign.start,
                style: GoogleFonts.outfit(
                  color: Colors.white,
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                child: Text(
                  articleData[index][2],
                  textAlign: TextAlign.start,
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          Spacer(
            flex: 5,
          ),
        ],
      ),
    );
  } // Article Containers

  getViewMoreButton() {
    return Center(
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 3,
        child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                const Color(0xff1051E3),
              ),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ))),
          onPressed: () {},
          child: Text(
            "View More",
            textAlign: TextAlign.start,
            style: GoogleFonts.outfit(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  } // ViewMore Button Article container

  getBottomNavigationBar() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: const GNav(
          backgroundColor: Color(0xff2E2C71),
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          activeColor: Color(0xffffffff),
          color: Color(0xff1051E3),
          tabs: [
            GButton(
              icon: Icons.home_filled,
              text: "Home",
            ),
            GButton(
              icon: Icons.history,
              text: "History",
            ),
            GButton(
              icon: Icons.sticky_note_2,
              text: "File",
            ),
            GButton(
              icon: Icons.edit_note_sharp,
              text: "Notes",
            ),
          ],
        ),
      ),
    );
  } // Bottom Navigation Bar(Google Nav Bar)
}
