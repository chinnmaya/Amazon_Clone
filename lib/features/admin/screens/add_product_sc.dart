import 'dart:io';

import 'package:amazon_clone/common/widgets/custom_button.dart';
import 'package:amazon_clone/common/widgets/custom_textfield.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/screens/services/admin_services.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';

import 'package:dotted_border/dotted_border.dart';

import '../../../constants/global_variables.dart';

class Adproductsc extends StatefulWidget {
  static const String routname = '/add-product';
  const Adproductsc({Key? key}) : super(key: key);

  @override
  State<Adproductsc> createState() => _AdproductscState();
}

class _AdproductscState extends State<Adproductsc> {
  String categories = "Mobiles";
  TextEditingController productnamecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  final admin_service adminservice = admin_service();
  final _addproductfromkey = GlobalKey<FormState>();

  TextEditingController pricecontroller = TextEditingController();
  TextEditingController quantitycontroller = TextEditingController();
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    productnamecontroller.dispose();
    descriptioncontroller.dispose();
    pricecontroller.dispose();
    quantitycontroller.dispose();
  }

  List<File> imagee = [];

  List<String> category = [
    "Mobiles",
    "Essentials",
    "Appliences",
    "Books",
    "Fashion"
  ];
  void sellproduct() {
    if (_addproductfromkey.currentState!.validate() && imagee.isNotEmpty) {
      adminservice.sellproduct(
          context: context,
          name: productnamecontroller.text,
          description: descriptioncontroller.text,
          price: double.parse(pricecontroller.text),
          quantity: double.parse(quantitycontroller.text),
          category: categories,
          image: imagee);
      print(productnamecontroller.text);
      print(descriptioncontroller.text);
      print(pricecontroller.text);
      print(quantitycontroller.text);
      print(categories);
    }
  }

  void selectimage() async {
    var res = await pickimages();
    setState(() {
      imagee = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
            flexibleSpace: Container(
              decoration:
                  BoxDecoration(gradient: GlobalVariables.appBarGradient),
            ),
            title: const Text(
              "Add a Product",
              style: const TextStyle(color: Colors.black),
            )),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _addproductfromkey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Column(children: [
              SizedBox(
                height: 20,
              ),
              imagee.isNotEmpty
                  ? CarouselSlider(
                      items: imagee.map(
                        (i) {
                          return Builder(
                            builder: (BuildContext context) => Image.file(
                              i,
                              fit: BoxFit.cover,
                              height: 200,
                            ),
                          );
                        },
                      ).toList(),
                      options: CarouselOptions(
                        viewportFraction: 1,
                        height: 200,
                      ),
                    )
                  : GestureDetector(
                      onTap: selectimage,
                      child: DottedBorder(
                        radius: const Radius.circular(10),
                        borderType: BorderType.RRect,
                        dashPattern: const [10, 4],
                        strokeCap: StrokeCap.round,
                        child: Container(
                          width: double.infinity,
                          height: 150,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.folder_open_outlined,
                                size: 40,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "select product image",
                                style: TextStyle(
                                    fontSize: 15, color: Colors.grey.shade400),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
              SizedBox(
                height: 30,
              ),
              CustomtextField(
                textEditingController: productnamecontroller,
                hinttext: "Product Name",
              ),
              SizedBox(
                height: 10,
              ),
              CustomtextField(
                textEditingController: descriptioncontroller,
                hinttext: "Description",
                maxline: 7,
              ),
              SizedBox(
                height: 10,
              ),
              CustomtextField(
                textEditingController: pricecontroller,
                hinttext: "price",
              ),
              SizedBox(
                height: 10,
              ),
              CustomtextField(
                textEditingController: quantitycontroller,
                hinttext: "quantity",
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: DropdownButton(
                  value: categories,
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                  ),
                  items: category.map((String item) {
                    return DropdownMenuItem(value: item, child: Text(item));
                  }).toList(),
                  onChanged: (String? newval) {
                    setState(() {
                      categories = newval!;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              CustomBtn(text: "Sell", onpressed: sellproduct)
            ]),
          ),
        ),
      ),
    );
  }
}
