import 'package:amazon_clone/common/widgets/bottom_bar.dart';
import 'package:amazon_clone/features/address/screes/address_sc.dart';
import 'package:amazon_clone/features/admin/screens/add_product_sc.dart';
import 'package:amazon_clone/features/auth/screens/auth_screen.dart';
import 'package:amazon_clone/features/payment_page/screen/payment_sc.dart';
import 'package:amazon_clone/features/product_details/screens/product_details_screen.dart';
import 'package:amazon_clone/features/screens/home/category_deal.dart';
import 'package:amazon_clone/features/screens/home/home_screen.dart';
import 'package:amazon_clone/features/search/screens/search_sc.dart';
import 'package:amazon_clone/models/product.dart';

import 'package:flutter/material.dart';

import 'models/product.dart';

Route<dynamic> GenerateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case Authscreen.routName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const Authscreen());
    case HomeScreen.routName:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const HomeScreen());
    case Bottom_bar.routname:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const Bottom_bar());
    case Adproductsc.routname:
      return MaterialPageRoute(
          settings: routeSettings, builder: (_) => const Adproductsc());
    case CategoryDeal.Routname:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => CategoryDeal(
                category: category,
              ));
    case Search_screen.routeName:
      var searchquery = routeSettings.arguments as String;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => Search_screen(
                searchquery: searchquery,
              ));
    case productdetailsc.routName:
      var products = routeSettings.arguments as product;
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => productdetailsc(
                products: products,
              ));
    case address_screen.routename:
      var productss = routeSettings.arguments as product;

      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => address_screen(
                products: productss,
              ));

    case payment_sc.routename:
      var productss = routeSettings.arguments as product;
      // var name = routeSettings.arguments as String;
      var addresss = routeSettings.arguments as String;

      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => payment_sc(
                products: productss,
                address: addresss,
              ));
    default:
      return MaterialPageRoute(
          settings: routeSettings,
          builder: (_) => const Scaffold(
                body: Center(
                  child: Text("no page exist"),
                ),
              ));
  }
}
