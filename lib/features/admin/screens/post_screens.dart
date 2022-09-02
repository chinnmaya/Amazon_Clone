import 'package:amazon_clone/common/widgets/loader.dart';
import 'package:amazon_clone/features/admin/screens/add_product_sc.dart';
import 'package:amazon_clone/features/screens/services/admin_services.dart';
import 'package:amazon_clone/features/widgets/single_product.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class post_screens extends StatefulWidget {
  const post_screens({Key? key}) : super(key: key);

  @override
  State<post_screens> createState() => _post_screensState();
}

class _post_screensState extends State<post_screens> {
  List<product>? products = [];
  final admin_service admin = new admin_service();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchallproduct();
  }

  fetchallproduct() async {
    products = await admin.fetchproducts(context);
    setState(() {});
  }

  void Navigatetoproduct() {
    Navigator.pushNamed(context, Adproductsc.routname);
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const loader()
        : Scaffold(
            body: GridView.builder(
                itemCount: products!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (context, index) {
                  final productdata = products![index];
                  return Column(
                    children: [
                      SizedBox(
                        height: 140,
                        child: single_product(image: productdata.images[0]),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Text(
                              productdata.name,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(Icons.delete_outline))
                        ],
                      ),
                    ],
                  );
                }),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: Navigatetoproduct,
              tooltip: "Add a product",
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
