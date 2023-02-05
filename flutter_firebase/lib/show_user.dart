import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/add_user.dart';

class ShowUser extends StatefulWidget {
  const ShowUser({Key? key}) : super(key: key);

  @override
  State<ShowUser> createState() => _ShowUserState();
}

class _ShowUserState extends State<ShowUser> {

  final CollectionReference _products =
      FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
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
                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        leading: CircleAvatar(
                          child: Text("${documnetSnapshot['age']}"),
                        ),
                        title: Text(documnetSnapshot['name']),
                        subtitle: Text(documnetSnapshot['birthday']),
                        trailing: SizedBox(
                          width: 100,
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  update(documnetSnapshot);
                                },
                                icon: Icon(Icons.create),
                              ),
                              IconButton(
                                onPressed: () {
                                  delete(documnetSnapshot);
                                },
                                icon: Icon(Icons.delete),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }

  Future<dynamic> update(DocumentSnapshot snapshot) async {
    _products.doc(snapshot['id']).update({'name': 'Name Changed' , 'age': 0 ,});
  }

  Future<dynamic> delete(DocumentSnapshot snapshot) async{
    _products.doc(snapshot['id']).delete();
  }

}
