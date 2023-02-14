import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  MyButton({Key? key,required this.fun,required this.title}) : super(key: key);
  final Function() fun;
  String title;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: fun,
      child: Text(
        title,
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(Colors.blue),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20))),
      ),
    );
  }
}
