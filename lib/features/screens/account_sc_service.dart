import 'dart:convert';

import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone/models/Orders.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants/error_handling.dart';
import '../../constants/global_variables.dart';
import '../../constants/utils.dart';

import 'package:http/http.dart ' as http;

import '../../provider/user_provider.dart';

class accountServices {
  Future<List<Order>> getmyorders({required BuildContext context}) async {
    List<Order> orderlist = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/orders/me'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );
      errorhandlefun(
          response: response,
          context: context,
          onsucess: () {
            for (int i = 0; i < jsonDecode(response.body).length; i++) {
              orderlist.add(Order.fromJson(jsonEncode(
                jsonDecode(response.body)[i],
              )));
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return orderlist;
  }

  void logout(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('x-auth-token', '');
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => Authscreen()),
          (Route<dynamic> route) => false);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
