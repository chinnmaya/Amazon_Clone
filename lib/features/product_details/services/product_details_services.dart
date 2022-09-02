import 'dart:convert';

import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/models/user.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../../../constants/error_handling.dart';
import '../../../constants/global_variables.dart';
import '../../../provider/user_provider.dart';
import '../../../provider/user_provider.dart';
import 'package:http/http.dart ' as http;

class productServices {
  void addtocart({
    required BuildContext buildContext,
    required product products,
  }) async {
    final userProvider = Provider.of<UserProvider>(buildContext, listen: false);
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/api/add-to-cart'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({'id': products.id}),
      );
      errorhandlefun(
          response: response,
          context: buildContext,
          onsucess: () {
            User user = userProvider.user
                .copyWith(cart: jsonDecode(response.body)['cart']);
            userProvider.setUserFromModel(user);
          });
    } catch (e) {
      showSnackBar(buildContext, e.toString());
    }
  }

  void rateProduct({
    required BuildContext buildContext,
    required product products,
    required double rating,
  }) async {
    final userProvider = Provider.of<UserProvider>(buildContext, listen: false);
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/api/rate-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({'id': products.id!, rating: rating}),
      );
      errorhandlefun(
          response: response,
          context: buildContext,
          onsucess: () {
            showSnackBar(buildContext, "Thanks for your Rating");
          });
    } catch (e) {
      showSnackBar(buildContext, e.toString());
    }
  }
}
