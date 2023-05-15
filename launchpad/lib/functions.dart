import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Components/dialogButton.dart';

class Functions {
  static exerciseAndProgrammDialog({
    required BuildContext context,
    required TextEditingController controller,
    required VoidCallback onPressed,
    required String title,
    required String labelText,
    required String buttonName,
  }) {
    return showDialog(
      context: context,
      builder: (context) => Center(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
          child: Dialog(
            backgroundColor: Colors.transparent,
            child: DialogButton(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${title}",
                    style: GoogleFonts.montserrat(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.w600,
                      fontSize: 20,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10),
                    child: SizedBox(
                      height: 60,
                      child: TextField(
                        controller: controller,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1.0,
                            ),
                          ),
                          hintText: "",
                          labelText: labelText,
                          prefixIcon: Icon(Icons.run_circle_outlined),
                          // You can add more customization options here
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: onPressed,
                    child: Container(
                      height: 30,
                      width: 60,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.blueAccent,
                          width: 0.5,
                        ),
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xffE7ECEF).withOpacity(0.5),
                      ),
                      child: Center(
                          child: Text(
                        buttonName,
                        style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 12,
                          fontWeight: FontWeight.w800,
                        ),
                      )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
