import 'package:amazon_clone/consts/consts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customTextField({String? title, String? hint,TextEditingController? controller, bool? isPass,required ColorScheme colorScheme}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title!.text.color(colorScheme.onPrimary).fontFamily(semibold).size(16).make(),
      Container(
        decoration: BoxDecoration(
            color: colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: colorScheme.onSurfaceVariant.withOpacity(0.6),
            )),
        child: TextFormField(
          obscureText: isPass!,
          controller: controller,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
              contentPadding:
              EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h)),
        ),
      )
    ],
  );
}
