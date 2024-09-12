import 'package:amazon_seller/const/const.dart';
import 'package:amazon_seller/widgets/text_styles.dart';

Widget orderPlacedDetails(data,
    {title1, titleDetails1, title2, titleDetails2}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            boldText(text: title1,color: purpleColor),
            boldText(text: titleDetails1,color: red)
            // "$title1".text.fontFamily(semibold).make(),
            // "$titleDetails1".text.color(redColor).fontFamily(semibold).make()
          ],
        ),
        SizedBox(
          width: 150,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            boldText(text: title2,color: purpleColor),
            boldText(text: titleDetails2,color: red),

              // "$title2".text.fontFamily(semibold).make(),
              // "$titleDetails2".text.color(redColor).fontFamily(semibold).make()
            ],
          ),
        )
      ],
    ),
  );
}
