import 'package:amazon_clone/consts/consts.dart';
import 'package:amazon_clone/screens/orders_screen/components/order_place_details.dart';
import 'package:amazon_clone/screens/orders_screen/components/order_status.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart' as intl;
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderDetails extends StatelessWidget {
  final dynamic data;
  const OrderDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    DateTime orderDate = (data['order_date'] as Timestamp).toDate();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Order Details"
            .text
            .color(darkFontGrey)
            .fontFamily(semibold)
            .make(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            orderStatus(
                color: redColor,
                title: "Placed",
                icon: Icons.done,
                showDone: data['order_placed']),
            orderStatus(
                color: Colors.blue[900],
                title: "Confirmed",
                icon: Icons.thumb_up_alt,
                showDone: data['order_confirmed']),
            orderStatus(
                color: Colors.yellow[800],
                title: "Delivery",
                icon: Icons.delivery_dining,
                showDone: data['order_ondelivery']),
            orderStatus(
                color: Colors.green[700],
                title: "Delivered",
                icon: Icons.done_all_rounded,
                showDone: data['order_delivered']),
            const Divider(),
            10.heightBox,
            Column(
              children: [
                orderPlacedDetails(data,
                    title1: "Order Code",
                    title2: "Shipping Method",
                    titleDetails1: data['order_code'],
                    titleDetails2: data['shipping_Menthod']),
                orderPlacedDetails(data,
                    title1: "Order Date",
                    title2: "Payment Method",
                    titleDetails1:
                        intl.DateFormat().add_yMd().format(orderDate),
                    titleDetails2: data['payment_Method']),
                orderPlacedDetails(data,
                    title1: "Payment Status",
                    title2: "Delivery Status",
                    titleDetails1: "Unpaid",
                    titleDetails2: "Order Placed "),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "Shipping Address".text.fontFamily(semibold).make(),
                          "Name: ${data["order_by_name"]}".text.make(),
                          "Email: ${data["order_by_email"]}".text.make(),
                          "Address: ${data["order_by_address"]}".text.make(),
                          "City: ${data["order_by-city"]}".text.make(),
                          "State: ${data["order_by-state"]}".text.make(),
                          "Phone: ${data["order_by-phone"]}".text.make(),
                          "Postal Code: ${data["order_by-postalCode"]}"
                              .text
                              .make(),
                        ],
                      ),
                      SizedBox(
                        width: 150,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Total Amount".text.fontFamily(semibold).make(),
                            "${data['total_amount']}"
                                .text
                                .color(redColor)
                                .fontFamily(bold)
                                .make()
                          ],
                        ),
                      )
                    ],
                  ),
                )
              ],
            ).box.color(whiteColor).outerShadowMd.make(),
            const Divider(),
            10.heightBox,
            "Ordered Products"
                .text
                .size(16)
                .color(darkFontGrey)
                .fontFamily(semibold)
                .makeCentered(),
            10.heightBox,
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: data['orders'].length,
              itemBuilder: (context, index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    orderPlacedDetails(
                      data['orders'],
                      title1: data['orders'][index]['title'],
                      title2: data['orders'][index]['tPrice'],
                      titleDetails1: '${data['orders'][index]['qty']}x',
                      titleDetails2: "Refundable",
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Container(
                          height: 20,
                          width: 30,
                          color: Color(data['orders'][index]['color'])),
                    ),
                    const Divider(),
                  ],
                );
              },
            )
                .box
                .outerShadowLg
                .color(whiteColor)
                .margin(const EdgeInsets.only(bottom: 4))
                .make(),
            10.heightBox,
            Column(
              children: [
                Row(
                  children: [
                    "Sub-Total:".text.fontFamily(semibold).size(16).make(),
                    "1000".text.make()
                  ],
                ),
                Row(
                  children: [
                    "Tax:".text.fontFamily(semibold).size(16).make(),
                    "1000".text.make()
                  ],
                ),
                Row(
                  children: [
                    "Discount:".text.fontFamily(semibold).size(16).make(),
                    "1000".text.make()
                  ],
                ),
                Row(
                  children: [
                    "Grand Total:".text.fontFamily(semibold).size(16).make(),
                    "1000".text.make()
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
