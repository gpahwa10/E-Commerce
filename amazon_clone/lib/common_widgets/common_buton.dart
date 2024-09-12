import 'package:amazon_clone/consts/consts.dart';

Widget loginbutton({onPress, Color? bgcolor, Color? textColor,String? title}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: bgcolor, padding: const EdgeInsets.all(12)),
      onPressed: onPress,
      child: title!.text.color(textColor).fontFamily(bold).make());
}
