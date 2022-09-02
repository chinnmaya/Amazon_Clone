import 'package:amazon_clone/provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class adress_box extends StatelessWidget {
  const adress_box({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Container(
      height: 40,
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Color.fromARGB(255, 114, 226, 221),
        Color.fromARGB(255, 163, 226, 233),
      ], stops: [
        0.5,
        1.0
      ])),
      padding: EdgeInsets.only(left: 10),
      child: Row(
        children: [
          const Icon(
            Icons.location_on_outlined,
            size: 20,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 5),
              child: Text(
                "Deliver to ${user.name}-${user.address}",
                style: TextStyle(fontWeight: FontWeight.w500),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          const Padding(
              padding: EdgeInsets.only(left: 5, top: 2),
              child: Icon(
                Icons.arrow_drop_down_outlined,
                size: 18,
              ))
        ],
      ),
    );
  }
}