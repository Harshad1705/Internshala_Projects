import 'package:flutter/material.dart';
import 'package:flutter_api/app_button.dart';
import 'package:flutter_api/base_client.dart';
import 'package:flutter_api/users.dart';

class FlutterApi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color(0xff1E1E1E),
        body: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              const FlutterLogo(size: 72),
              AppButton(
                operation: "GET",
                description: "Fetch users",
                operationColor: Colors.lightGreen,
                onPressed: () async {
                  var response =
                      await BaseClient().get('/users').catchError((err) {});
                  if (response == null) return;
                  debugPrint("Success : Get");

                  var users = userFromJson(response);
                  debugPrint('User count : ' + users.length.toString());
                },
              ),
              AppButton(
                operation: "POST",
                description: "Add users",
                operationColor: Colors.lightBlue,
                onPressed: () async {
                  var user = User(
                    name: "Harshad",
                    qualifications: [
                      Qualification(
                          degree: 'Bachelors', completionData: '17-05-2020'),
                    ],
                  );
                  var response = await BaseClient()
                      .post('/users', user)
                      .catchError((err) {});
                  if (response == null) return;
                  debugPrint("Success : Post ");
                },
              ),
              AppButton(
                operation: "PUT",
                description: "Edit users",
                operationColor: Colors.orangeAccent,
                onPressed: () async {
                  var id = 3;
                  var user = User(
                    name: "Harry",
                    qualifications: [
                      Qualification(
                          degree: 'Bachelors', completionData: '17-05-2020'),
                    ],
                  );
                  var response = await BaseClient()
                      .put('/users/$id', user)
                      .catchError((err) {});
                  if (response == null) return;
                  debugPrint("Success : Put ");
                },
              ),
              AppButton(
                operation: "DELETE",
                description: "Remove users",
                operationColor: Colors.red,
                onPressed: () async {
                  var id = 2;
                  var response = await BaseClient()
                      .delete('/users/$id')
                      .catchError((err) {});
                  if (response == null) return;
                  debugPrint("Success : Delete");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
