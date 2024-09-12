import 'package:amazon_clone/consts/consts.dart';

Widget detailsTab({double? width, String? count, String? title}){
  return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                count!.text.size(16).color(darkFontGrey).fontFamily(bold).make(),
                5.heightBox,
                title!.text.color(darkFontGrey).make()
              ],
            )
                .box.white
                .rounded.height(80)
                .width(width!)
                .padding(const EdgeInsets.all(4))
                .make();
}