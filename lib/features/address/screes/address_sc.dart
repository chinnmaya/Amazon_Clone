import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/features/address/service/address_sc_service.dart';
import 'package:amazon_clone/features/payment_page/screen/payment_sc.dart';
import 'package:amazon_clone/models/product.dart';
import 'package:amazon_clone/provider/user_provider.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_textfield.dart';
import '../../../constants/global_variables.dart';
import 'package:pay/pay.dart';

class address_screen extends StatefulWidget {
  static const String routename = '/address';
  final product products;

  const address_screen({Key? key, required this.products}) : super(key: key);

  @override
  State<address_screen> createState() => _address_screenState();
}

class _address_screenState extends State<address_screen> {
  String addresstoUsed = "";
  List<PaymentItem> paymentlist = [];
  final adressfromkey = GlobalKey<FormState>();
  final TextEditingController flatBuildingController = TextEditingController();
  final TextEditingController areaStreetController = TextEditingController();
  final TextEditingController pincodeController = TextEditingController();
  final TextEditingController townCityController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    flatBuildingController.dispose();
    areaStreetController.dispose();
    pincodeController.dispose();
    townCityController.dispose();
  }

  final Address_service adresservice = Address_service();

  void paypressed(String addressfromProvider) {
    bool isfrom = flatBuildingController.text.isNotEmpty ||
        areaStreetController.text.isNotEmpty ||
        pincodeController.text.isNotEmpty ||
        townCityController.text.isNotEmpty;
    if (isfrom) {
      if (adressfromkey.currentState!.validate()) {
        addresstoUsed =
            '${flatBuildingController.text},${areaStreetController.text},${pincodeController.text},${townCityController.text}';
      } else {
        throw Exception("Please enter all the values");
      }
    } else if (addressfromProvider.isNotEmpty) {
      addresstoUsed = addressfromProvider;
    } else {
      showSnackBar(context, 'An Unkown Error Ocurred');
    }

    adresservice.saveUserAddress(context: context, address: addresstoUsed);

    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => payment_sc(
              products: widget.products,
              address: addresstoUsed,
            )));

    print(addresstoUsed);
  }

  void payRes(res) {}

  void applepayRes(res) {}

  @override
  Widget build(BuildContext context) {
    var addrress = context.watch<UserProvider>().user.address;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: BoxDecoration(gradient: GlobalVariables.appBarGradient),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8),
          child: Column(children: [
            if (addrress.isNotEmpty)
              Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black12),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        addrress,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "OR",
                    style: TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            Form(
              key: adressfromkey,
              child: Column(
                children: [
                  CustomtextField(
                    textEditingController: flatBuildingController,
                    hinttext: "Flat,House no,Building",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomtextField(
                    textEditingController: areaStreetController,
                    hinttext: "Area,street",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomtextField(
                    textEditingController: pincodeController,
                    hinttext: "Pincode",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomtextField(
                    textEditingController: townCityController,
                    hinttext: "Town & City",
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomBtn(text: "Buy Now", onpressed: () => paypressed(addrress))
          ]),
        ),
      ),
    );
  }
}
