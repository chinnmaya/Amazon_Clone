import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class BelowAppbar extends StatelessWidget {
  const BelowAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      decoration: BoxDecoration(
        gradient: GlobalVariables.appBarGradient,
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: Row(children: [
          RichText(
              text: TextSpan(
                  text: "Hellow, ",
                  style: const TextStyle(
                    fontSize: 22,
                    color: Colors.black,
                  ),
                  children: [
                TextSpan(
                    text: user.name,
                    style: const TextStyle(
                      fontSize: 22,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ))
              ])),
        ]),
      ),
    );
  }
}
