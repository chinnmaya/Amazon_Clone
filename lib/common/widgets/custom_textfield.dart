import 'package:flutter/material.dart';

class CustomtextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hinttext;
  final int maxline;
  const CustomtextField(
      {Key? key,
      required this.textEditingController,
      required this.hinttext,
      this.maxline = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      decoration: InputDecoration(
        hintText: hinttext,
        border: const OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.black38,
        )),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.black38,
        )),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Enter your $hinttext";
        }
        return null;
      },
      maxLines: maxline,
    );
  }
}
