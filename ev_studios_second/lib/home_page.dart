import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DateTime from = DateTime.now();
  DateTime to = DateTime.now();
  final DateRangePickerController dateRangePickerControllerFrom =
      DateRangePickerController();
  final DateRangePickerController dateRangePickerControllerTo =
      DateRangePickerController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Age Calculator",
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.height / 20,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Select Date From (DOB)",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 40,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  datePicker(dateRangePickerControllerFrom),
                ],
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "Select Date To (Till Date)",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 40,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  datePicker(dateRangePickerControllerTo),
                ],
              ),
              SizedBox(
                width: 20,
              ),
            ],
          ),
          SizedBox(
              width: MediaQuery.of(context).size.width / 10,
              height: MediaQuery.of(context).size.height / 12,
              child: FloatingActionButton(
                onPressed: () {
                  from = dateRangePickerControllerFrom.selectedDate ??
                      DateTime.now();
                  to = dateRangePickerControllerTo.selectedDate ??
                      DateTime.now();
                  var ans = to.difference(from);
                  if (!ans.isNegative) {
                    double temp = (ans.inDays / 365);
                    int years = temp.toInt();
                    var days = ans.inDays % 365;
                    showDialog(
                      context: context,
                      builder: (ctx) => AlertDialog(
                        title: const Text("Your Age is:"),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 10,),
                            showAge("Years: $years"),
                            const SizedBox(height: 10,),
                            showAge("Days: $days"),
                            const SizedBox(height: 10,),
                          ],
                        ),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const HomePage()));
                            },
                            child: Text("Ok"),
                          ),
                        ],
                      ),
                    );
                  } else {
                    SnackBar snackBar = const SnackBar(
                        content: Text("Please Select Correct Date"));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80),
                ),
                isExtended: true,
                child: Container(
                  padding: EdgeInsets.all(
                    MediaQuery.of(context).size.width / 100,
                  ),
                  child: Text(
                    "Calculate\n\t\t\t\tAge",
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.height / 100,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ))
        ],
      ),
    );
  }

  showAge(String text) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height / 20,
      width: MediaQuery.of(context).size.width / 4,
      decoration: BoxDecoration(
          color: const Color(0XFFF1F2F6),
          borderRadius: BorderRadius.circular(32.0),
          boxShadow: const [
            BoxShadow(
              offset: Offset(4, 4),
              color: Colors.blueGrey,
              blurRadius: 5.0,
            ),
            BoxShadow(
              offset: Offset(-4, -4),
              color: Colors.white60,
              blurRadius: 5.0,
              spreadRadius: 1.0,
            )
          ]),
      child: Center(child: Text(text)),
    );
  }

  datePicker(var controller) {
    return Container(
      padding: const EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height / 2,
      width: MediaQuery.of(context).size.width / 2.5,
      decoration: BoxDecoration(
          color: const Color(0XFFF1F2F6),
          borderRadius: BorderRadius.circular(32.0),
          boxShadow: const [
            BoxShadow(
              offset: Offset(4, 4),
              color: Colors.blueGrey,
              blurRadius: 5.0,
            ),
            BoxShadow(
              offset: Offset(-4, -4),
              color: Colors.white60,
              blurRadius: 5.0,
              spreadRadius: 1.0,
            )
          ]),
      child: SfDateRangePicker(
        todayHighlightColor: Colors.blueAccent,
        selectionColor: Colors.blueAccent,
        // showActionButtons: true,
        showNavigationArrow: true,
        showTodayButton: true,
        toggleDaySelection: true,
        controller: controller,
      ),
    );
  }
}
