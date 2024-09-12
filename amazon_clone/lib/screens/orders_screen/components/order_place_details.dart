import 'package:amazon_clone/consts/consts.dart';
Widget orderPlacedDetails(data,{title1,titleDetails1,title2,titleDetails2}){
  return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    "$title1".text.fontFamily(semibold).make(),
                    "$titleDetails1"
                        .text
                        .color(redColor)
                        .fontFamily(semibold)
                        .make()
                  ],
                ),
                SizedBox(
                  width: 150,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      "$title2".text.fontFamily(semibold).make(),
                      "$titleDetails2"
                          .text
                          .color(redColor)
                          .fontFamily(semibold)
                          .make()
                    ],
                  ),
                )
              ],
            ),
          );
}