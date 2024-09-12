import 'package:amazon_clone/consts/consts.dart';

Widget homebuttons(double width, double height, icon, String? title) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        icon,
        width: 26,
      ),
      5.heightBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make()
    ],
  ).box.white.rounded.size(width, height).shadowSm.make();
}
