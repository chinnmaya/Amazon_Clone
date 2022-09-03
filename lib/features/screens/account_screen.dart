import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/screens/account_sc_service.dart';

import 'package:amazon_clone/features/widgets/below_appbar.dart';
import 'package:amazon_clone/features/widgets/order.dart';

import 'package:amazon_clone/features/widgets/top_button.dart';
import 'package:amazon_clone/models/Orders.dart';
import 'package:flutter/material.dart';

class account_sc extends StatefulWidget {
  const account_sc({Key? key}) : super(key: key);

  @override
  State<account_sc> createState() => _account_scState();
}

class _account_scState extends State<account_sc> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/images/amazon_in.png',
                  width: 120,
                  height: 45,
                  color: Colors.black,
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Icon(Icons.notifications_outlined),
                    ),
                    Icon(Icons.search),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          BelowAppbar(),
          SizedBox(
            height: 10,
          ),
          top_btn(),
          const SizedBox(
            height: 20,
          ),
          orders(),
        ],
      ),
    );
  }
}
