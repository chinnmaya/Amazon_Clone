import 'package:amazon_clone/features/address/service/address_sc_service.dart';
import 'package:amazon_clone/features/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_textfield.dart';
import '../../../constants/global_variables.dart';
import '../../../constants/utils.dart';
import '../../../models/product.dart';

class payment_sc extends StatefulWidget {
  static const String routename = '/payment';
  final product products;
  final String address;

  const payment_sc({
    Key? key,
    required this.address,
    required this.products,
  }) : super(key: key);

  @override
  State<payment_sc> createState() => _payment_scState();
}

class _payment_scState extends State<payment_sc> {
  final paymentfromkey = GlobalKey<FormState>();
  final TextEditingController Name_controller = TextEditingController();
  final TextEditingController phone_number_controller = TextEditingController();
  final TextEditingController email_controller = TextEditingController();
  var cusdetails = "";

  void paypressed() {
    cusdetails = "";
    bool isfrom = Name_controller.text.isNotEmpty ||
        phone_number_controller.text.isNotEmpty ||
        email_controller.text.isNotEmpty;
    if (isfrom) {
      if (paymentfromkey.currentState!.validate()) {
        cusdetails =
            '${Name_controller.text},${phone_number_controller.text},${email_controller.text}';
      } else {
        throw Exception("Please enter all the values");
      }
    } else {
      showSnackBar(context, 'Enter your details');
    }
    openCheckout();

    print(cusdetails);
  }

  void codModeorder() {
    showSnackBar(context, "Transcation Completed");
    address_service.placeorder(
        image: widget.products.images[0],
        context: context,
        address: widget.address,
        totalsum: widget.products.price,
        productName: widget.products.name);
    //Navigator.pop(context);
    AwesomeDialog(
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.SUCCES,
      body: Center(
        child: Text(
          'Your order has placed sucessfully and it will deliver to you soon.KEEP SHOOPING😍.SEE YOU SOON WITH A ORDER😎',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      title: 'Sucess',
      desc: 'order Placed',
      btnOkOnPress: () {
        Navigator.pop(context);
        Navigator.pop(context);
      },
    )..show();
  }

  late Razorpay _razorpay;
  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  void openCheckout() async {
    print(widget.products.price);
    var options = {
      'key': 'rzp_test_HDmuR0sSJbJ29R',
      'amount': widget.products.price * 100,
      'name': Name_controller.text,
      'description': widget.products.name,
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {
        'contact': phone_number_controller.text,
        'email': email_controller.text
      },
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  Address_service address_service = Address_service();

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('Success Response: $response');

    address_service.placeorder(
        image: widget.products.images[0],
        context: context,
        address: widget.address,
        totalsum: widget.products.price,
        productName: widget.products.name);
    /*AwesomeDialog(
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.SUCCES,
      body: Center(
        child: Text(
          'Your order has placed sucessfully and it will deliver to you soon',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
      ),
      title: 'Sucess',
      desc: 'order Placed',
      btnOkOnPress: () {
        Navigator.pushNamed(context, HomeScreen.routName);
      },
    )..show();
    showSnackBar(context, "Transcation Completed");*/

    /*Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Error Response: $response');
    /* Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External SDK Response: $response');
    /* Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT); */
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
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Form(
          key: paymentfromkey,
          child: Column(
            children: [
              CustomtextField(
                textEditingController: Name_controller,
                hinttext: "Enter your name",
              ),
              const SizedBox(
                height: 10,
              ),
              CustomtextField(
                textEditingController: phone_number_controller,
                hinttext: "Enter your Phone number",
              ),
              const SizedBox(
                height: 10,
              ),
              CustomtextField(
                textEditingController: email_controller,
                hinttext: "Enter your Email",
              ),
              const SizedBox(
                height: 10,
              ),
              CustomBtn(text: "Pay with card,Upi,bank", onpressed: paypressed),
              const SizedBox(
                height: 10,
              ),
              CustomBtn(text: "Pay with Cod", onpressed: codModeorder)
            ],
          ),
        ),
      ),
    );
  }
}
