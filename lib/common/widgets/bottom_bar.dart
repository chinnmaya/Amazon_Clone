import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/favorites/screens/favorites_sc.dart';

import 'package:amazon_clone/features/screens/account_screen.dart';
import 'package:amazon_clone/features/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../provider/user_provider.dart';

class Bottom_bar extends StatefulWidget {
  static const String routname = '/actual-home';
  const Bottom_bar({Key? key}) : super(key: key);

  @override
  State<Bottom_bar> createState() => _Bottom_barState();
}

class _Bottom_barState extends State<Bottom_bar> {
  int page = 0;
  double bottomwidth = 42;
  double bottombarwidth = 5;
  List<Widget> pagess = [
    const HomeScreen(),
    const account_sc(),
    const favorites_sc(),
  ];
  void updatepage(int pagee) {
    setState(() {
      page = pagee;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cartlength = context.watch<UserProvider>().user.cart.length;
    return Scaffold(
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
                    child: const Icon(Icons.person_outline_outlined)),
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
                    child: const Icon(Icons.favorite_outline_outlined)),
                label: ""),
          ],
        ));
  }
}
