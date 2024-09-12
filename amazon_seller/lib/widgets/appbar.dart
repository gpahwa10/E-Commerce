import 'package:amazon_seller/const/const.dart';
import 'package:amazon_seller/widgets/text_styles.dart';
import 'package:intl/intl.dart' as intl;
AppBar customAppBar({title}){
  return AppBar(
        automaticallyImplyLeading: false,
        title: boldText(text: title, color: darkGrey, size: 16.0),
        actions: [
          Center(
              child: normalText(
                  text: intl.DateFormat('EEE, MMM d ' 'yyyy')
                      .format(DateTime.now()),
                  color: purpleColor)),
          10.widthBox,
        ],
      );
}