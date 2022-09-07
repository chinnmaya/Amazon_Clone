import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/features/screens/home/category_deal.dart';
import 'package:flutter/cupertino.dart';

class top_categories extends StatelessWidget {
  const top_categories({Key? key}) : super(key: key);
  void navigatetocategories(BuildContext context, String category) {
    Navigator.pushNamed(context, CategoryDeal.Routname, arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemExtent: 85,
          itemCount: GlobalVariables.categoryImages.length,
          itemBuilder: ((context, index) {
            return GestureDetector(
              onTap: () => navigatetocategories(
                  context, GlobalVariables.categoryImages[index]['title']!),
              child: Column(children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(58),
                    child: Image.asset(
                      GlobalVariables.categoryImages[index]['image']!,
                      fit: BoxFit.cover,
                      height: 40,
                      width: 40,
                    ),
                  ),
                ),
                Text(
                  GlobalVariables.categoryImages[index]['title']!,
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                )
              ]),
            );
          })),
    );
  }
}
