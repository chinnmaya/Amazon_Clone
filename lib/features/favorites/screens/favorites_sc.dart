import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/features/favorites/services/favorites_sc_service.dart';
import 'package:amazon_clone/features/product_details/screens/product_details_screen.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../constants/global_variables.dart';
import '../../../models/Orders.dart';
import '../../order_details/order_detail_screen/orderdetail_sc.dart';
import '../../widgets/single_product.dart';

class favorites_sc extends StatefulWidget {
  const favorites_sc({Key? key}) : super(key: key);

  @override
  State<favorites_sc> createState() => _favorites_scState();
}

class _favorites_scState extends State<favorites_sc> {
  List<Order>? favorites;
  final FavoriteService favoriteService = FavoriteService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchOrder();
  }

  void fetchOrder() async {
    favorites = await favoriteService.favoritesOrders(context: context);
    setState(() {});
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
              Container(
                alignment: Alignment.topLeft,
                child: Image.asset(
                  'assets/images/amazon_in.png',
                  width: 120,
                  height: 45,
                  color: Colors.black,
                ),
              ),
              Container(
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(right: 15),
                      child: Icon(Icons.notifications_outlined),
                    ),
                    Icon(Icons.search),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      body: favorites == null
          ? const loader()
          : GridView.builder(
              gridDelegate:
                  SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: favorites!.length,
              itemBuilder: (context, index) {
                final orderData = favorites![index];
                return Padding(
                  padding: EdgeInsets.all(8),
                  child: GestureDetector(
                    onTap: () {},
                    child: SizedBox(
                      height: 140,
                      child: single_product(image: orderData.image),
                    ),
                  ),
                );
              }),
    );
  }
}
