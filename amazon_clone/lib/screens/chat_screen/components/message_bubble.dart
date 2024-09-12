import 'package:amazon_clone/consts/consts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart' as intl;

Widget messageBubble(DocumentSnapshot data) {
  var t =
      data['created_on'] == null ? DateTime.now() : data['created_on'].toDate();
  var time = intl.DateFormat("h:mma").format(t);
  return Directionality(
    textDirection:
        data['uid'] == currentUser!.uid ? TextDirection.rtl : TextDirection.ltr,
    child: Container(
        margin: const EdgeInsets.only(bottom: 12, left: 12, right: 5),
        // margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: data['uid'] == currentUser!.uid ? redColor : darkFontGrey,
            borderRadius: data['uid'] == currentUser!.uid
                ? const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomLeft: Radius.circular(20))
                : const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                    bottomRight: Radius.circular(20),
                  )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "${data['msg']}".text.size(16).color(whiteColor).make(),
            10.heightBox,
            time.text.color(whiteColor.withOpacity(0.5)).make(),
          ],
        )),
  );
}