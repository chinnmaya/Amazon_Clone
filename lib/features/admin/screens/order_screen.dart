import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/features/admin/screens/adimin_screen.dart';
import 'package:amazon_clone/features/order_details/order_detail_screen/orderdetail_sc.dart';
import 'package:amazon_clone/features/screens/services/admin_services.dart';
import 'package:amazon_clone/features/widgets/single_product.dart';
import 'package:amazon_clone/models/Orders.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../screens/services/admin_services.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  List<Order>? orders;
  final admin_service admin_ser = admin_service();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchOrder();
  }

  void fetchOrder() async {
    orders = await admin_ser.fetchOrders(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orders == null
        ? const loader()
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: orders!.length,
            itemBuilder: (context, index) {
              final orderData = orders![index];
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          orderDetail_screen(order: orderData)));
                },
                child: SizedBox(
                  height: 140,
                  child: single_product(image: orderData.image),
                ),
              );
            },
          );
  }
}
