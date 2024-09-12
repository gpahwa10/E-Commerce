import 'package:amazon_clone/consts/consts.dart';

Widget customTextField({String? title, String? hint,TextEditingController? controller, bool? isPass}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.color(Colors.red).fontFamily(semibold).size(16).make(),
      TextFormField(
        obscureText: isPass!,
        controller: controller,
        decoration:  InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(fontFamily: semibold, color: fontGrey),
          isDense: true,
          fillColor: lightGrey,
          filled: true,
          border: InputBorder.none,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
        ),
      )
    ],
  );
}
