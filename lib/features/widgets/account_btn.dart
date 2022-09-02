import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class acc_btn extends StatelessWidget {
  final text;
  final VoidCallback ontab;
  const acc_btn({Key? key, required this.text, required this.ontab})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(
          horizontal: 10,
        ),
        height: 40,
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 0.0),
            borderRadius: BorderRadius.circular(50),
            color: Colors.white),
        child: OutlinedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              primary: Colors.black12.withOpacity(0.03),
            ),
            onPressed: ontab,
            child: Text(
              text,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.normal),
            )),
      ),
    );
  }
}
