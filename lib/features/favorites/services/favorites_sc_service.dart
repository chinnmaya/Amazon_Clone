import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart ' as http;
import 'package:provider/provider.dart';

import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../models/Orders.dart';
import '../../../models/product.dart';
import '../../../provider/user_provider.dart';

class FavoriteService {
  Future<List<Order>> favoritesOrders({required BuildContext context}) async {
    List<Order> orderlist = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/favorites/me'),
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

  void placeorder({
    required BuildContext context,
    required double totalsum,
    required String productName,
    required String image,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<product> productlist = [];
    try {
      print(userProvider.user.token);
      http.Response response = await http.post(Uri.parse('$uri/api/favorites'),
          headers: {
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token,
          },
          body: jsonEncode({
            'image': image,
            'name': productName,
            'totalPrice': totalsum,
          }));
      print(productName);

      errorhandlefun(
          response: response,
          context: context,
          onsucess: () {
            showSnackBar(context, 'Added sucessfully!');
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
