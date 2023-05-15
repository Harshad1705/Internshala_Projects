import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Components/button.dart';
import '../Components/programTile.dart';
import '../data.dart';
import '../functions.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffE7ECEF),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Functions.exerciseAndProgrammDialog(
                        context: context,
                        buttonName: "Add",
                        title: "Add Program",
                        labelText: "Program",
                        controller: Data.controller,
                        onPressed: () {
                          if (Data.controller.text.length != 0) {
                            List temp = [];
                            temp.add(Data.controller.text);
                            temp.add([]);

                            Data.program.add(temp);
                            Data.controller.clear();

                            setState(() {});
                          }
                          Navigator.pop(context);
                        },
                      );
                    },
                    child: SizedBox(
                      width: 150,
                      child: Button(
                        padding:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                        borderRadius: 10,
                        child: Text(
                          "Create Program",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  GestureDetector(
                    onTap: () {
                      Functions.exerciseAndProgrammDialog(
                        context: context,
                        buttonName: "Add",
                        title: "Add Exercise",
                        labelText: "Exercise",
                        controller: Data.controller,
                        onPressed: () {
                          if (Data.controller.text.length != 0) {
                            Data.exercise.add(Data.controller.text);
                            Data.controller.clear();

                            setState(() {});
                          }
                          Navigator.pop(context);
                        },
                      );
                    },
                    child: SizedBox(
                      width: 150,
                      child: Button(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        borderRadius: 10,
                        child: Text(
                          "Create Exercise",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.roboto(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 30, bottom: 20),
                child: Text(
                  "Your Program",
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                    color: Colors.blueAccent,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: Data.program.length,
                  itemBuilder: (context, index) {
                    return ProgramTile(
                      index: index,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
