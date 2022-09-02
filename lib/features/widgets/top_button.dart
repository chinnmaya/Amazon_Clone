import 'package:amazon_clone/features/widgets/account_btn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class top_btn extends StatelessWidget {
  const top_btn({Key? key}) : super(key: key);

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
          acc_btn(text: "Log Out", ontab: () {}),
          acc_btn(text: "Your Wishlist", ontab: () {}),
        ])
      ],
    );
  }
}
