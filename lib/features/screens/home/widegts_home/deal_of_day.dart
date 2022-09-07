import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/features/product_details/screens/product_details_screen.dart';
import 'package:amazon_clone/features/screens/services/home_services.dart';
import 'package:amazon_clone/models/product.dart';

import 'package:flutter/material.dart';

class Deal_of_day extends StatefulWidget {
  const Deal_of_day({Key? key}) : super(key: key);

  @override
  State<Deal_of_day> createState() => _Deal_of_dayState();
}

class _Deal_of_dayState extends State<Deal_of_day> {
  final Homeservices homeservices = Homeservices();
  product? products;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchdealofday();
  }

  void fetchdealofday() async {
    products = await homeservices.fetchdealoftheday(context: context);
    setState(() {});
  }

  void navigatetoproductscreen() {
    Navigator.pushNamed(context, productdetailsc.routName, arguments: products);
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const loader()
        : products!.name.isEmpty
            ? const SizedBox()
            : GestureDetector(
                onTap: navigatetoproductscreen,
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      padding: EdgeInsets.only(left: 10, top: 15),
                      child: const Text(
                        "Deal of the day",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Image.network(
                      products!.images[0],
                      height: 235,
                      fit: BoxFit.fitHeight,
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15),
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Rs. ${products!.price}',
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 15, right: 40, top: 5),
                      alignment: Alignment.topLeft,
                      child: Text(
                        products!.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: products!.images
                              .map(
                                (e) => Image.network(
                                  e,
                                  height: 100,
                                  width: 100,
                                  fit: BoxFit.fitWidth,
                                ),
                              )
                              .toList(),
                        )),
                    Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 15,
                        ).copyWith(left: 15),
                        alignment: Alignment.topLeft,
                        child: Text('See all deals',
                            style: TextStyle(
                              color: Colors.cyan[800],
                            )))
                  ],
                ),
              );
  }
}
