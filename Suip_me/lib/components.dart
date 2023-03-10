import 'package:flutter/material.dart';

class Components extends StatefulWidget {
  const Components({Key? key}) : super(key: key);

  static Container imgContainer(BuildContext context, String img) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: 20, horizontal: MediaQuery.of(context).size.width * 0.15),
      height: MediaQuery.of(context).size.height * 0.4,
      width: MediaQuery.of(context).size.width * 0.7,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Color(0xff444654),
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(img),
        ),
      ),
      // child: Image.network(),
    );
  }

  static Container buttons(String name, Function func) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xff343541),
      ),
      child: TextButton(
        child: Text(name),
        onPressed: () {
          func();
        },
      ),
    );
  }

  @override
  State<Components> createState() => _ComponentsState();
}

class _ComponentsState extends State<Components> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
