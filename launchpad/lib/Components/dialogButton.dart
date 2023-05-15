import 'package:flutter/material.dart';

class DialogButton extends StatelessWidget {
  const DialogButton({
    super.key,
    required this.child,
    this.padding = EdgeInsets.zero,
  });

  final Widget child;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            blurRadius: 30,
            offset: Offset(-14, -14),
            color: Colors.white.withOpacity(0.5),
          ),
          BoxShadow(
            blurRadius: 30,
            offset: Offset(14, 14),
            color: Color(0xffA7A9AF),
          ),
        ],
        color: Color(0xffE7ECEF).withOpacity(0.5),
      ),
      child:  child,
    );
  }
}