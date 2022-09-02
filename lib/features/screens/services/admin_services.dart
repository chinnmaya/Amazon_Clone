import 'dart:io';
import 'dart:convert';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart ' as http;
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:provider/provider.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../provider/user_provider.dart';

class admin_service {
  void sellproduct({
    required BuildContext context,
    required String name,
    required String description,
    required double price,
    required double quantity,
    required String category,
    required List<File> image,
  }) async {
    final userprovider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic('djmvqyhdu', 'irxqjzmd');
      List<String> imageUrls = [];
      for (int i = 0; i < image.length; i++) {
        CloudinaryResponse res = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(image[i].path, folder: name));
        imageUrls.add(res.secureUrl);
      }
      product producs = product(
          name: name,
          description: description,
          images: imageUrls,
          price: price,
          quantity: quantity,
          category: category);
      print(producs.name);
      print(producs.description);
      print(producs.price);
      print(producs.quantity);
      print(producs.category);

      http.Response res = await http.post(
        Uri.parse('$uri/admin/add-product'), //admin/add-product
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          //'x-auth-token': userprovider.user.token,
        },

        body: producs.toJson(),
      );
      print("token ${userprovider.user.token}");
      errorhandlefun(
          response: res,
          context: context,
          // ignore: use_build_context_synchronously
          onsucess: () {
            showSnackBar(context, 'product added sucessfully');
            Navigator.pop(context);
          });
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<List<product>> fetchproducts(BuildContext context) async {
    List<product> productlist = [];
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/admin/get-products'),
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
