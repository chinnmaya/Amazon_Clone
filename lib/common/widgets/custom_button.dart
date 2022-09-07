import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final String text;
  final Color? color;

  final VoidCallback onpressed;
  const CustomBtn(
      {Key? key, required this.text, required this.onpressed, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onpressed,
      child: Text(
        text,
        style: TextStyle(color: color == null ? Colors.white : Colors.black),
      ),
      style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 50), primary: color),
    );
  }
}
