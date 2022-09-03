import 'dart:io';
import 'dart:convert';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart ' as http;
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:provider/provider.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../provider/user_provider.dart';

class Address_service {
  void saveUserAddress({
    required BuildContext context,
    required String address,
  }) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/save-user-address'), //admin/add-product
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userprovider.user.token,
        },

        body: jsonEncode({'address': address}),
      );
      print("token ${userprovider.user.token}");
      errorhandlefun(
        response: res,
        context: context,
        // ignore: use_build_context_synchronously
        onsucess: () {
          User user = userprovider.user
              .copyWith(address: jsonDecode(res.body)['address']);
          userprovider.setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void placeorder({
    required BuildContext context,
    required String address,
    required double totalsum,
    required String productName,
    required String image,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<product> productlist = [];
    try {
      print(userProvider.user.token);
      http.Response response = await http.post(Uri.parse('$uri/api/order'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          },
          body: jsonEncode({
            'image': image,
            'name': productName,
            'totalPrice': totalsum,
            'address': address,
            //'userId': userProvider.user.token,
          }));
      print(productName);
      print(address);
      errorhandlefun(
          response: response,
          context: context,
          onsucess: () {
            showSnackBar(context, 'your order has been placed');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
