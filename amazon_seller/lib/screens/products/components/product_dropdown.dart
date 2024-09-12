import 'package:amazon_seller/const/const.dart';
import 'package:amazon_seller/controller/products_controller.dart';
import 'package:amazon_seller/widgets/text_styles.dart';

Widget productDropDown({hint,required List<String> list, dropValue,required ProductController controller}) {
  return Obx(
    ()=> DropdownButtonHideUnderline(
        child: DropdownButton(
      hint: normalText(text: '$hint', color: fontGrey),
      value: dropValue.value == ''?null:dropValue.value,
      isExpanded: true,
      items: list.map((e) {
        return DropdownMenuItem(value: e, child: e.toString().text.make());
      }).toList(),
      onChanged: (newValue) {
        if (hint == "Category") {
          controller.subcategoryValue.value =='';
          controller.populateSubCategory(newValue.toString());
        }
        dropValue.value = newValue.toString();
      },
    ).box.white.padding(const EdgeInsets.symmetric(horizontal: 4)).roundedSM.make()),
  );
}
