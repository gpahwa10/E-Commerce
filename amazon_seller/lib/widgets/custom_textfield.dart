import 'package:amazon_seller/const/const.dart';
import 'package:amazon_seller/widgets/text_styles.dart';

Widget customTextField({label, hint, controller, isDescription}) {
  return TextFormField(
    controller: controller,
    style: const TextStyle(color: white),
    maxLines: isDescription ? 4 : 2,
    decoration: InputDecoration(
        isDense: true,
        label: normalText(text: label),
        hintText: hint,
        hintStyle: const TextStyle(color: lightGrey),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: white)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: white)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: white))),
  );
}
