import 'package:amazon_clone/features/screens/account_sc_service.dart';

import 'package:amazon_clone/features/widgets/account_btn.dart';
import 'package:flutter/cupertino.dart';

class top_btn extends StatefulWidget {
  const top_btn({Key? key}) : super(key: key);

  @override
  State<top_btn> createState() => _top_btnState();
}

class _top_btnState extends State<top_btn> {
  final accountServices accounter = accountServices();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          acc_btn(text: "Yours orders", ontab: () {}),
          acc_btn(text: "Turn seller", ontab: () {}),
        ]),
        const SizedBox(
          height: 10,
        ),
        Row(children: [
          acc_btn(text: "Log Out", ontab: () => accounter.logout(context)),
          acc_btn(text: "Your Wishlist", ontab: () {}),
        ])
      ],
    );
  }
}
