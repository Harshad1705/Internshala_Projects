import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utilitiesstorage/main.dart';
import 'package:utilitiesstorage/show_objects.dart';

import 'modal.dart';

class Show_Class extends StatefulWidget {
  const Show_Class({Key? key}) : super(key: key);

  @override
  State<Show_Class> createState() => _Show_ClassState();
}

class _Show_ClassState extends State<Show_Class> {
  final CollectionReference _classes =
      FirebaseFirestore.instance.collection('classes');
  TextEditingController controllerClass_Name = TextEditingController();
  TextEditingController controllerRename = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff444654),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white38,
          child: Icon(
            Icons.add,
            size: 50,
          ),
          onPressed: () {
            controllerClass_Name.text = '';
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                title: Text("Name for new Class"),
                content: Container(
                  padding: EdgeInsets.only(left: 10),
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      width: 1.0,
                    ),
                  ),
                  child: Center(
                    child: TextField(
                      controller: controllerClass_Name,
                      style: GoogleFonts.comicNeue(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      if (controllerClass_Name.text.length >= 1) {
                        List obj = [];
                        Classes cls = Classes(
                          name: controllerClass_Name.text,
                          objects: obj,
                        );
                        add_class(cls);
                      }
                      Navigator.pushNamed(context, 'home');
                    },
                    child: Text("Ok"),
                  ),
                ],
              ),
            );
          },
        ),
        appBar: AppBar(
          backgroundColor: const Color(0xff343541),
          title: Center(
            child: Text(
              "Mechanical Department",
              style: GoogleFonts.comicNeue(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * (5 / 100),
            right: MediaQuery.of(context).size.width * (5 / 100),
            top: MediaQuery.of(context).size.width * (7 / 100),
          ),
          child: StreamBuilder(
              stream: _classes.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text("Something went wrong!");
                } else if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          snapshot.data!.docs[index];
                      return ShowClass(documentSnapshot: documentSnapshot);
                    },
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              }),
        ),
      ),
    );
  }

  Widget ShowClass({required DocumentSnapshot documentSnapshot}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) =>
                Show_Objects(documentSnapshot: documentSnapshot),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white38,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(blurRadius: 2, color: Colors.grey),
          ],
        ),
        child: ListTile(
          title: Text(
            "${documentSnapshot["name"]}",
            style: GoogleFonts.donegalOne(
              fontWeight: FontWeight.w500,
              fontSize: 18,
            ),
          ),
          trailing: SizedBox(
            width: 100,
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    edit_name(documentSnapshot);
                  },
                  icon: Icon(Icons.edit),
                ),
                IconButton(
                  onPressed: () {
                    delete(documentSnapshot);
                  },
                  icon: Icon(Icons.delete),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<dynamic> add_class(Classes cls) async {
    final docUser = _classes.doc();
    cls.id = docUser.id;
    final json = cls.toJson();
    await docUser.set(json);
  }

  Future<dynamic> edit_name(DocumentSnapshot documentSnapshot) async {
    controllerRename.text = '';
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("Rename Class"),
        content: Container(
          padding: EdgeInsets.only(left: 10),
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              width: 1.0,
            ),
          ),
          child: Center(
            child: TextField(
              controller: controllerRename,
              style: GoogleFonts.comicNeue(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              if (controllerRename.text.length >= 1 &&
                  controllerRename.text != documentSnapshot['name']) {
                await _classes
                    .doc(documentSnapshot['id'])
                    .update({"name": controllerRename.text});
              }
              Navigator.pushNamed(context, 'home');
            },
            child: Text("Ok"),
          ),
        ],
      ),
    );
  }

  Future<dynamic> delete(DocumentSnapshot documentSnapshot) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          "Delete Class",
          style: GoogleFonts.comicNeue(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Container(
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: Text(
              "Are you sure to delete ${documentSnapshot['name']} class",
              style: GoogleFonts.comicNeue(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () async {
              await _classes.doc(documentSnapshot['id']).delete();
              Navigator.pushNamed(context, 'home');
            },
            child: Text("Ok"),
          ),
        ],
      ),
    );
  }
}
