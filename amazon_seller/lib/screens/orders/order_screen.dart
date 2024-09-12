import 'package:amazon_seller/const/const.dart';
import 'package:amazon_seller/controller/orders_controller.dart';
import 'package:amazon_seller/screens/orders/order_details.dart';
import 'package:amazon_seller/services/store_services.dart';
import 'package:amazon_seller/widgets/appbar.dart';
import 'package:amazon_seller/widgets/loading_indicator.dart';
import 'package:amazon_seller/widgets/text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart' as intl;

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(OrdersController());
    return Scaffold(
        appBar: customAppBar(title: orders),
        body: StreamBuilder(
            stream: StoreServices.getOrders(uid: currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return loadingIndicator();
              } else {
                var data = snapshot.data!.docs;
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: List.generate(
                          data.length,
                          (index) => ListTile(
                                onTap: () {
                                  Get.to(OrderDetails(
                                    data: data[index],
                                  ));
                                },
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                tileColor: textfieldGrey,
                                title: boldText(
                                    text: "Product Code",
                                    color: purpleColor,
                                    size: 14.0),
                                subtitle: Column(
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.calendar_month,
                                          color: fontGrey,
                                        ),
                                        10.widthBox,
                                        boldText(
                                            color: fontGrey,
                                            text: intl.DateFormat()
                                                .add_yMd()
                                                .format(DateTime.now())),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.payment,
                                          color: fontGrey,
                                        ),
                                        10.widthBox,
                                        boldText(color: red, text: unpaid)
                                      ],
                                    )
                                  ],
                                ),
                                trailing: boldText(
                                    text: "₹${data[index]['total_amount']}",
                                    color: purpleColor,
                                    size: 16.0),
                              )
                                  .box
                                  .margin(const EdgeInsets.only(bottom: 4))
                                  .make()),
                    ),
                  ),
                );
              }
            }));
  }
}
