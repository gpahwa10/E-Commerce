import 'package:amazon_clone/consts/consts.dart';

Widget featuredButton(icon, String? title) {
  return Row(
    children: [
      Image.asset(
        icon,
        width: 60,
        fit: BoxFit.fill,
      ),
      10.widthBox,
      title!.text.fontFamily(semibold).color(darkFontGrey).make()
    ],
  )
      .box
      .roundedSM
      .width(200)
      .margin(const EdgeInsets.symmetric(horizontal: 4))
      .outerShadowSm
      .padding(const EdgeInsets.all(4))
      .make();
}
