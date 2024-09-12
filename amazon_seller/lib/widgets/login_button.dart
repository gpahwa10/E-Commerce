import 'package:amazon_seller/const/const.dart';
import 'package:amazon_seller/widgets/text_styles.dart';

Widget loginButton(
    {required String title,
    Color color = purpleColor,
    Color textcolor = white,
    required onPress}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          backgroundColor: color,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12)))),
      onPressed: onPress,
      child: boldText(text: title, size: 16.0, color: textcolor));
}
