import 'dart:convert';

import 'package:flutter/material.dart';

import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../models/product.dart';
import 'package:http/http.dart ' as http;

class Homeservices {
  Future<List<product>> getproducts(
      {required BuildContext context, required String category}) async {
    List<product> productlist = [];
    try {
      print(category);
      http.Response response = await http.get(
        Uri.parse('$uri/api/products?category=$category'),
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

  Future<product> fetchdealoftheday({required BuildContext context}) async {
    //List<product> productlist = [];
    product products = product(
        name: '',
        description: '',
        price: 0,
        quantity: 0,
        images: [],
        category: '');
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/deal-of-day'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          //'x-auth-token': userprovider.user.token,
        },
      );
      errorhandlefun(
          response: response,
          context: context,
          onsucess: () {
            products = product.fromJson(response.body);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return products;
  }
}
