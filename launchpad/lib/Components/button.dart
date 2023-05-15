import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.child,
    required this.padding,
    this.borderRadius = 30,
  });

  final Widget child;
  final EdgeInsets padding;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: [
          BoxShadow(
            blurRadius: 30,
            offset: Offset(-28, -28),
            color: Colors.white,
          ),
          BoxShadow(
            blurRadius: 30,
            offset: Offset(28, 28),
            color: Color(0xffA7A9AF),
          ),
        ],
        color: Color(0xffE7ECEF),
      ),
      child: Center(child: child),
    );
  }
}
