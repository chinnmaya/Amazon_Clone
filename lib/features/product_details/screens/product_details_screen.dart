import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/stars.dart';
import 'package:amazon_clone/features/address/screes/address_sc.dart';
import 'package:amazon_clone/features/favorites/services/favorites_sc_service.dart';
import 'package:amazon_clone/features/product_details/services/product_details_services.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../../constants/global_variables.dart';
import '../../search/screens/search_sc.dart';

class productdetailsc extends StatefulWidget {
  static const String routName = '/product-details';
  final product products;
  const productdetailsc({Key? key, required this.products}) : super(key: key);

  @override
  State<productdetailsc> createState() => _productdetailscState();
}

class _productdetailscState extends State<productdetailsc> {
  final productServices productservice = productServices();
  final FavoriteService favoriteService = FavoriteService();
  void navigatetosearch(String query) {
    Navigator.pushNamed(context, Search_screen.routeName, arguments: query);
  }

  void navigatetoAddress() {
    Navigator.pushNamed(context, address_screen.routename,
        arguments: widget.products);
  }

  void addtocart() {
    favoriteService.placeorder(
      context: context,
      totalsum: widget.products.price,
      productName: widget.products.name,
      image: widget.products.images[0],
    );
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
              Expanded(
                  child: Container(
                height: 42,
                margin: const EdgeInsets.only(left: 15),
                child: Material(
                  borderRadius: BorderRadius.circular(7),
                  elevation: 1,
                  child: TextFormField(
                    onFieldSubmitted: navigatetosearch,
                    decoration: InputDecoration(
                        prefixIcon: InkWell(
                          child: Padding(
                            padding: EdgeInsets.only(left: 6),
                            child: Icon(
                              Icons.search,
                              color: Colors.black,
                              size: 23,
                            ),
                          ),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.only(top: 10),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(7),
                          ),
                          borderSide: BorderSide(
                            color: Colors.black38,
                            width: 1,
                          ),
                        ),
                        hintText: "Search Amazon.in",
                        hintStyle: const TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 17)),
                  ),
                ),
              )),
              Container(
                color: Colors.transparent,
                height: 42,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: const Icon(Icons.mic, color: Colors.black, size: 25),
              )
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(widget.products.id!),
                  const Stars(rating: 4),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 10,
              ),
              child: Text(
                widget.products.name,
                style: const TextStyle(fontSize: 15),
              ),
            ),
            CarouselSlider(
              items: widget.products.images.map(
                (i) {
                  return Builder(
                    builder: (BuildContext context) => Image.network(
                      i,
                      fit: BoxFit.contain,
                      height: 300,
                    ),
                  );
                },
              ).toList(),
              options: CarouselOptions(
                viewportFraction: 1,
                height: 200,
              ),
            ),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: RichText(
                text: TextSpan(
                    text: "Deal Price: ",
                    style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                    children: [
                      TextSpan(
                          text: "\$${widget.products.price}",
                          style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Colors.red))
                    ]),
              ),
            ),
            Padding(
                padding: const EdgeInsets.all(8),
                child: Text(widget.products.description)),
            Container(
              color: Colors.black12,
              height: 5,
            ),
            Padding(
                padding: const EdgeInsets.all(10),
                child:
                    CustomBtn(text: "Buy now", onpressed: navigatetoAddress)),
            const SizedBox(
              height: 10,
            ),
            Padding(
                padding: const EdgeInsets.all(10),
                child: CustomBtn(
                  text: "Add to Favorite",
                  onpressed: addtocart,
                  color: const Color.fromRGBO(254, 216, 19, 1),
                )),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Rate this Product",
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            RatingBar.builder(
                initialRating: 0,
                minRating: 1,
                direction: Axis.horizontal,
                allowHalfRating: true,
                itemCount: 5,
                itemPadding: const EdgeInsets.symmetric(horizontal: 5),
                itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: GlobalVariables.secondaryColor,
                    ),
                onRatingUpdate: (rating) {
                  productservice.rateProduct(
                      buildContext: context,
                      products: widget.products,
                      rating: rating);
                })
          ],
        ),
      ),
    );
  }
}
