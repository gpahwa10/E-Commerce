import 'package:amazon_seller/const/const.dart';

Widget productImages({required lable, onPress}) {
  return "$lable"
      .text
      .bold
      .color(fontGrey).size(16.0)
      .makeCentered()
      .box
      .color(lightGrey)
      .size(100, 100)
      .roundedSM
      .make();
}
