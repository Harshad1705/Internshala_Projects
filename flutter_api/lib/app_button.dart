import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {

  final String operation;
  final String description;
  final Color? operationColor;
  final VoidCallback? onPressed;

  const AppButton({
    required this.operation ,
    required this.description ,
    this.operationColor=Colors.black ,
    this.onPressed}
    );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child:  MaterialButton(
        onPressed: (){
          onPressed?.call();
        },
        color: Colors.white,
        height: 60,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              operation,
              style: TextStyle(
                color: operationColor,
                fontSize:32,
                fontFamily: 'Menlo',
                fontWeight: FontWeight.w900,
              ),
            ),
            Text(
              description,
              style: TextStyle(
                fontSize:20,
                fontWeight: FontWeight.w300,
              ),
            )
          ],
        ),
      ),
    );
  }
}