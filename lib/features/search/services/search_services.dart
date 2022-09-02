import 'dart:convert';

import 'package:amazon_clone/constants/global_variables.dart';
import 'package:flutter/material.dart';

import '../../../constants/error_handling.dart';
import '../../../constants/utils.dart';
import '../../../models/product.dart';
import 'package:http/http.dart ' as http;

class Searchservice {
  Future<List<product>> getsearchproducts(
      {required BuildContext context, required String searchquery}) async {
    List<product> productlist = [];
    try {
      // print(category);
      http.Response response = await http.get(
        Uri.parse('$uri/api/products/search/$searchquery'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          //'x-auth-token': userprovider.user.token,
        },
      );
      errorhandlefun(
          response: response,
          context: context,
          onsucess: () {
            for (int i = 0; i < jsonDecode(response.body).length; i++) {
              productlist.add(product.fromJson(jsonEncode(
                jsonDecode(response.body)[i],
              )));
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productlist;
  }
}
