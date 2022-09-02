import 'package:amazon_clone/common/widgets/stars.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Searched_item extends StatelessWidget {
  final product products;
  const Searched_item({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(children: [
            Image.network(
              products.images[0],
              fit: BoxFit.fitHeight,
              height: 135,
              width: 135,
            ),
            Column(
              children: [
                Container(
                  width: 235,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    products.name,
                    style: const TextStyle(fontSize: 16),
                    maxLines: 2,
                  ),
                ),
                Container(
                    width: 235,
                    padding: const EdgeInsets.only(top: 5, left: 10),
                    child: Stars(rating: 2)),
                Container(
                  width: 235,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    '\$${products.price}',
                    style: const TextStyle(
                        fontSize: 16, fontWeight: FontWeight.bold),
                    maxLines: 2,
                  ),
                ),
                Container(
                  width: 235,
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Eligible for FREE shipping',
                  ),
                ),
                Container(
                  width: 235,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    'In Stock',
                    style: const TextStyle(color: Colors.teal),
                    maxLines: 2,
                  ),
                ),
              ],
            )
          ]),
        )
      ],
    );
  }
}
