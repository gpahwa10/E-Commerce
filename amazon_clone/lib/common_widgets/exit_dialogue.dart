import 'package:amazon_clone/common_widgets/common_buton.dart';
import 'package:amazon_clone/consts/consts.dart';
import 'package:flutter/services.dart';

Widget exitDialog(context) {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.fontFamily(bold).size(18).make(),
        const Divider(),
        "Are you sure you want to exit the application?"
            .text
            .fontFamily(bold)
            .color(darkFontGrey)
            .size(16)
            .color(darkFontGrey)
            .make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            loginbutton(onPress: () {
              SystemNavigator.pop();
            }, bgcolor:  redColor,textColor:  whiteColor,title:  "Yes"),
            loginbutton(onPress:  () {
              Navigator.pop(context);
            },bgcolor:  whiteColor,textColor:  Colors.black, title: "No")
          ],
        )
      ],
    ).box.color(lightGrey).padding(const EdgeInsets.all(12)).roundedSM.make(),
  );
}
