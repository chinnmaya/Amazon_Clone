import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/screens/home/widegts_home/address_box.dart';
import 'package:amazon_clone/features/screens/home/widegts_home/carusoul_img.dart';
import 'package:amazon_clone/features/screens/home/widegts_home/deal_of_day.dart';
import 'package:amazon_clone/features/screens/home/widegts_home/top_categories.dart';

import 'package:flutter/material.dart';

import '../../search/screens/search_sc.dart';

class HomeScreen extends StatefulWidget {
  static const String routName = '/homescreen';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void navigatetosearch(String query) {
    Navigator.pushNamed(context, Search_screen.routeName, arguments: query);
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
              Expanded(
                  child: Container(
                height: 42,
                margin: const EdgeInsets.only(left: 15),
                child: Material(
                  borderRadius: BorderRadius.circular(7),
                  elevation: 1,
                  child: TextFormField(
                    onFieldSubmitted: navigatetosearch,
                    decoration: InputDecoration(
                        prefixIcon: InkWell(
                          child: Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1,
                          ),
                        ),
                        hintText: "Search Amazon.in",
                        hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 17)),
                  ),
                ),
              )),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(Icons.mic, color: Colors.black, size: 25),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: const [
            adress_box(),
            SizedBox(
              height: 10,
            ),
            top_categories(),
            SizedBox(
              height: 10,
            ),
            carusol_img(),
            Deal_of_day()
          ],
        ),
      ),
    );
  }
}
