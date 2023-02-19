import 'dart:io';
import 'dart:math';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:revamph/registratin.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PlatformFile? pickedFile;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();
                SnackBar sb = SnackBar(content: Text("LogOut Successfull"));
                ScaffoldMessenger.of(context).showSnackBar(sb);
                Navigator.pushReplacementNamed(context, '/registration');
              },
              icon: Icon(Icons.logout)),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height * 0.5,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(
            left: MediaQuery.of(context).size.width * 0.20,
            right: MediaQuery.of(context).size.width * 0.20,
            top: MediaQuery.of(context).size.width * 0.10,
          ),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.black12,
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 1,
                offset: Offset(2, 2),
                color: Colors.grey,
              ),
              BoxShadow(
                blurRadius: 1,
                offset: Offset(-2, -2),
                color: Colors.grey,
              ),
            ],
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () async {
                  final result = await FilePicker.platform.pickFiles();
                  print(result);
                  if (result != null) {
                    setState(() {
                      pickedFile = result.files.first;
                    });
                  }
                  print(pickedFile?.path);
                  final path = '${await FirebaseAuth.instance.currentUser!.email}/file/${pickedFile!.name}';
                  final file = File(pickedFile!.path.toString());
                  final ref = FirebaseStorage.instance.ref().child(path);
                  await ref.putFile(file as File);
                  SnackBar sn =
                      SnackBar(content: Text("File has been uploaded"));
                  ScaffoldMessenger.of(context).showSnackBar(sn);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.blue,
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 1,
                        offset: Offset(2, 2),
                        // color: Colors.blue.shade300,
                      ),
                      BoxShadow(
                        blurRadius: 1,
                        offset: Offset(-2, -2),
                        color: Colors.grey,
                      ),
                    ],
                  ),
                  height: MediaQuery.of(context).size.height * 0.5 * 0.1,
                  width: MediaQuery.of(context).size.width * 0.5 * 0.5,
                  child: Center(
                    child: Text(
                      "Select File",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
