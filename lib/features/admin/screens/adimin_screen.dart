import 'package:amazon_clone/features/admin/screens/order_screen.dart';
import 'package:amazon_clone/features/admin/screens/post_screens.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../constants/global_variables.dart';

class admin_screen extends StatefulWidget {
  const admin_screen({Key? key}) : super(key: key);

  @override
  State<admin_screen> createState() => _admin_screenState();
}

class _admin_screenState extends State<admin_screen> {
  int page = 0;
  double bottomwidth = 42;
  double bottombarwidth = 5;
  List<Widget> pagess = [
    const post_screens(),
    //const HomeScreen(),
    //const account_sc(),
    const OrdersScreen(),
  ];
  void updatepage(int pagee) {
    setState(() {
      page = pagee;
    });
  }

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
              const Text(
                "Admin",
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
              )
            ],
          ),
        ),
      ),
      body: pagess[page],
      bottomNavigationBar: BottomNavigationBar(
        onTap: updatepage,
        currentIndex: page,
        selectedItemColor: GlobalVariables.selectedNavBarColor,
        unselectedItemColor: GlobalVariables.selectedNavBarColor,
        backgroundColor: GlobalVariables.backgroundColor,
        iconSize: 28,
        items: [
          BottomNavigationBarItem(
              icon: Container(
                  width: bottomwidth,
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(
                    color: page == 0
                        ? GlobalVariables.selectedNavBarColor
                        : GlobalVariables.backgroundColor,
                    width: bottombarwidth,
                  ))),
                  child: const Icon(Icons.home_outlined)),
              label: ""),
          BottomNavigationBarItem(
              icon: Container(
                width: bottomwidth,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                  color: page == 1
                      ? GlobalVariables.selectedNavBarColor
                      : GlobalVariables.backgroundColor,
                  width: bottombarwidth,
                ))),
                child: const Icon(Icons.analytics_outlined),
              ),
              label: ""),
          BottomNavigationBarItem(
              icon: Container(
                width: bottomwidth,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                  color: page == 2
                      ? GlobalVariables.selectedNavBarColor
                      : GlobalVariables.backgroundColor,
                  width: bottombarwidth,
                ))),
                child: const Icon(Icons.inbox_outlined),
              ),
              label: ""),
        ],
      ),
    );
  }
}
