import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/features/product_details/screens/product_details_screen.dart';
import 'package:amazon_clone/features/screens/services/home_services.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../constants/global_variables.dart';

class CategoryDeal extends StatefulWidget {
  final String category;
  const CategoryDeal({Key? key, required this.category}) : super(key: key);
  static const String Routname = '/categorydeal';

  @override
  State<CategoryDeal> createState() => _CategoryDealState();
}

class _CategoryDealState extends State<CategoryDeal> {
  Homeservices homeservices = new Homeservices();
  List<product>? productscategory;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchcategoryproduct();
  }

  fetchcategoryproduct() async {
    productscategory = await homeservices.getproducts(
        context: context, category: widget.category);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return productscategory == null
        ? const loader()
        : Scaffold(
            appBar: PreferredSize(
              preferredSize: const Size.fromHeight(50),
              child: AppBar(
                flexibleSpace: Container(
                  decoration:
                      BoxDecoration(gradient: GlobalVariables.appBarGradient),
                ),
                title: Text(
                  widget.category,
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            body: Column(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Keep shopping for category ${widget.category}',
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                Container(
                  height: 170,
                  child: GridView.builder(
                      padding: const EdgeInsets.only(left: 15),
                      itemCount: productscategory!.length,
                      scrollDirection: Axis.horizontal,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 1,
                              childAspectRatio: 1.4,
                              mainAxisSpacing: 10),
                      itemBuilder: (context, index) {
                        final product = productscategory![index];
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, productdetailsc.routName,
                                arguments: product);
                          },
                          child: Column(
                            children: [
                              SizedBox(
                                height: 130,
                                child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black12, width: 0.5),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Image.network(product.images[0]),
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.topLeft,
                                padding: const EdgeInsets.only(
                                    left: 0, top: 5, right: 15),
                                child: Text(
                                  product.name,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                )
              ],
            ),
          );
  }
}
