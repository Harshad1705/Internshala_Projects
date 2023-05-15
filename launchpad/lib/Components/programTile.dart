import 'package:flutter/material.dart';
import 'package:launchpad/screens/home.dart';

import '../data.dart';
import '../functions.dart';

class ProgramTile extends StatefulWidget {
  const ProgramTile({
    super.key,
    required this.index,
  });

  final int index;

  @override
  State<ProgramTile> createState() => _ProgramTileState();
}

class _ProgramTileState extends State<ProgramTile> {
  bool visible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blueAccent,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                visible = !visible;
              });
            },
            child: Row(
              children: [
                Container(
                  height: 50,
                  width: 50,
                  margin: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blueAccent,
                    ),
                    shape: BoxShape.circle,
                    color: Colors.white38,
                  ),
                  child: Center(
                    child: Text(
                      "${widget.index + 1}",
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    Data.program[widget.index][0],
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.blueAccent,
                    ),
                  ),
                ),
                !visible
                    ? Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Functions.exerciseAndProgrammDialog(
                                context: context,
                                buttonName: "Change",
                                title: "Change Program Name",
                                labelText: "Program",
                                controller: Data.controller,
                                onPressed: () {
                                  if (Data.controller.text.length != 0) {
                                    Data.program[widget.index][0] =
                                        Data.controller.text;
                                    Data.controller.clear();
                                    setState(() {});
                                  }
                                  Navigator.pop(context);
                                },
                              );
                            },
                            icon: Icon(
                              Icons.edit,
                              size: 20,
                              color: Colors.blueAccent,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                visible = !visible;
                              });
                            },
                            icon: Icon(
                              Icons.keyboard_arrow_down_sharp,
                              size: 25,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ],
                      )
                    : Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Functions.exerciseAndProgrammDialog(
                                context: context,
                                buttonName: "Change",
                                title: "Add Exercise",
                                labelText: "Exercise",
                                controller: Data.controller,
                                onPressed: () {
                                  if (Data.controller.text.length != 0) {
                                    Data.program[widget.index][1]
                                        .add(Data.controller.text);
                                    Data.controller.clear();
                                    setState(() {});
                                  }
                                  Navigator.pop(context);
                                },
                              );
                            },
                            icon: Icon(
                              Icons.add,
                              size: 25,
                              color: Colors.blueAccent,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Data.program.removeAt(widget.index);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => HomePage(),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.delete,
                              size: 25,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ],
                      ),
              ],
            ),
          ),
          Visibility(
            visible: visible,
            child: Column(
              children: [
                SizedBox(
                  height: 5,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: Data.program[widget.index][1].length,
                    itemBuilder: (context, temp) {
                      return Row(
                        children: [
                          Expanded(
                            child: Text(
                              "* ${Data.program[widget.index][1][temp]}",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.blueAccent,
                              ),
                            ),
                          ),
                          GestureDetector(
                              onTap: () {
                                Data.program[widget.index][1].removeAt(temp);
                                setState(() {});
                              },
                              child: Icon(
                                Icons.delete_outline,
                                size: 18,
                                color: Colors.lightBlue,
                              )),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
