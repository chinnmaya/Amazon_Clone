import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/widgets/single_product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../models/Orders.dart';
import '../screens/account_sc_service.dart';

class orders extends StatefulWidget {
  const orders({Key? key}) : super(key: key);

  @override
  State<orders> createState() => _ordersState();
}

class _ordersState extends State<orders> {
  List<Order>? orderss;
  final accountServices accountservice = accountServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getmyorders();
  }

  void getmyorders() async {
    orderss = await accountservice.getmyorders(context: context);
    print(orderss!.length);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return orderss == null
        ? const loader()
        : Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      "Yours orders",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      "See all",
                      style:
                          TextStyle(color: GlobalVariables.selectedNavBarColor),
                    ),
                  ),
                ],
              ),
              Container(
                  height: 170,
                  padding: EdgeInsets.only(left: 10, right: 00, top: 20),
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: orderss!.length,
                      itemBuilder: (context, index) {
                        return single_product(image: orderss![index].image);
                      })),
            ],
          );
  }
}
