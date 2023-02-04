import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:utilitiesstorage/modal.dart';
import 'package:utilitiesstorage/show_class.dart';

class Show_Objects extends StatefulWidget {
  const Show_Objects({Key? key, required this.documentSnapshot})
      : super(key: key);

  final DocumentSnapshot documentSnapshot;

  @override
  State<Show_Objects> createState() => _Show_ObjectsState();
}

class _Show_ObjectsState extends State<Show_Objects> {
  final CollectionReference _classes =
      FirebaseFirestore.instance.collection('classes');
  final TextEditingController controllerObjectName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff444654),
      appBar: AppBar(
        backgroundColor: const Color(0xff343541),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "${widget.documentSnapshot["name"]}",
              style: GoogleFonts.comicNeue(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            IconButton(
              onPressed: () {
                add_object(widget.documentSnapshot);
              },
              icon: Icon(Icons.add),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: widget.documentSnapshot["objects"].length,
        itemBuilder: (context, index) {
          return ShowObject(
              value: widget.documentSnapshot["objects"][index],
              documentSnapshot: widget.documentSnapshot);
        },
      ),
    );
  }

  Future<dynamic> add_object(DocumentSnapshot documentSnapshot) {
    return showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text("New object name"),
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
              controller: controllerObjectName,
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
              if (controllerObjectName.text.length >= 1) {
                List ob = documentSnapshot["objects"];
                if (!ob.contains(controllerObjectName.text)) {
                  ob.add(controllerObjectName.text);
                  String name = documentSnapshot['name'];
                  _classes.doc(documentSnapshot['id']).delete();
                  Classes cls = Classes(
                    name: name,
                    objects: ob,
                  );
                  final docUser = _classes.doc();
                  cls.id = docUser.id;
                  final json = cls.toJson();
                  await docUser.set(json);
                }
              }
              Navigator.pushNamed(context, 'home');
            },
            child: Text("Ok"),
          ),
        ],
      ),
    );
  }

  Widget ShowObject(
      {required String value, required DocumentSnapshot documentSnapshot}) {
    return Container(
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
          value,
          style: GoogleFonts.donegalOne(
            fontWeight: FontWeight.w500,
            fontSize: 18,
          ),
        ),
        trailing: SizedBox(
          width: 100,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () async {
                  await _classes.doc(documentSnapshot['id']).update({
                    'objects': FieldValue.arrayRemove([value]),
                  });
                  Navigator.pushNamed(context, 'home');
                },
                icon: Icon(Icons.delete),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
