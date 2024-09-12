import 'package:amazon_seller/const/const.dart';
import 'package:amazon_seller/controller/orders_controller.dart';
import 'package:amazon_seller/screens/orders/components/order_place_details.dart';
import 'package:amazon_seller/widgets/login_button.dart';
import 'package:amazon_seller/widgets/text_styles.dart';
import 'package:intl/intl.dart' as intl;

class OrderDetails extends StatefulWidget {
  final dynamic data;
  const OrderDetails({super.key, this.data});

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  var controller = Get.find<OrdersController>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getOrders(widget.data);
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          title: boldText(text: "Order Details", color: fontGrey, size: 16.0),
        ),
        bottomNavigationBar: Visibility(
          visible: !controller.confirmed.value,
          child: SizedBox(
            height: 60,
            width: context.screenWidth,
            child: loginButton(
                title: "Confirm Order", onPress: () {controller.confirmed(true);controller.changeStatus(title: "order_confirmed",status: true,docID: widget.data.id);}, color: green),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                //order delivery status section
                Visibility(
                  visible: !controller.confirmed.value,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [   
                      boldText(
                          text: "Order Status", size: 16.0, color: fontGrey),
                      SwitchListTile(
                        title: boldText(text: "Placed", color: fontGrey),
                        value: true,
                        onChanged: (value) {},
                        activeColor: green,
                      ),
                      SwitchListTile(
                        activeColor: green,
                        value: controller.confirmed.value,
                        onChanged: (value) {
                          controller.confirmed.value = value;
                        },
                        title: boldText(text: "Confirm", color: fontGrey),
                      ),
                      SwitchListTile(
                        activeColor: green,
                        value: controller.shipped.value,
                        onChanged: (value) {
                          controller.shipped.value = value;
                        },
                        title: boldText(text: "Shipped", color: fontGrey),
                      ),
                      SwitchListTile(
                        activeColor: green,
                        value: controller.outForDelivery.value,
                        onChanged: (value) {
                          controller.outForDelivery.value = value;
                        },
                        title:
                            boldText(text: "Out for Delivery", color: fontGrey),
                      ),
                      SwitchListTile(
                        activeColor: green,
                        value: controller.delivered.value,
                        onChanged: (value) {
                          controller.delivered.value = value;
                        },
                        title: boldText(text: "Delivered", color: fontGrey),
                      ),
                    ],
                  )
                      .box
                      .color(lightGrey)
                      .outerShadowMd
                      .padding(EdgeInsets.all(8))
                      .roundedSM
                      .make(),
                ),
                //order details section
                Column(
                  children: [
                    orderPlacedDetails("data",
                        title1: "Order Code",
                        title2: "Shipping Method",
                        titleDetails1: widget.data['order_code'],
                        titleDetails2: widget.data['shipping_Menthod']),
                    orderPlacedDetails("data",
                        title1: "Order Date",
                        title2: "Payment Method",
                        titleDetails1: intl.DateFormat()
                            .add_yMd()
                            .format((widget.data['order_date'].toDate())),
                        titleDetails2: widget.data['payment_Method']),
                    orderPlacedDetails("data",
                        title1: "Payment Status",
                        title2: "Delivery Status",
                        titleDetails1: "Unpaid",
                        titleDetails2: "Order Placed "),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12.0, vertical: 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              boldText(
                                  text: "Shipping Address", color: purpleColor),
                              "${widget.data['order_by_name']}".text.make(),
                              "${widget.data['order_by_email']}".text.make(),
                              "${widget.data['order_by_address']}".text.make(),
                              "${widget.data['order_by-city']}".text.make(),
                              "${widget.data['order_by-state']}".text.make(),
                              "${widget.data['order_by-phone']}".text.make(),
                              "${widget.data['order_by-postalCode']}"
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
                                boldText(
                                    text: "Total Amount", color: Colors.black),
                                boldText(
                                    text: "₹ ${widget.data['total_amount']}",
                                    color: red)
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ).box.color(lightGrey).outerShadowMd.roundedSM.make(),
                const Divider(),
                10.heightBox,

                boldText(text: "Ordered Products", color: fontGrey),
                10.heightBox,
                ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: controller.orders.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        orderPlacedDetails(
                          widget.data['orders'],
                          title1: "${widget.data['orders'][index]['title']}",
                          title2: "${widget.data['orders'][index]['tPrice']}",
                          titleDetails1:
                              "${widget.data['orders'][index]['qty']}x",
                          titleDetails2: "Refundable",
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Container(
                            height: 20,
                            width: 30,
                            // color: red,
                            color: Color(
                              widget.data['orders'][index]['color'],
                            ),
                          ),
                        ),
                        const Divider(),
                      ],
                    );
                  },
                )
                    .box
                    .outerShadowLg
                    .color(white)
                    .margin(const EdgeInsets.only(bottom: 4))
                    .make(),
                10.heightBox,
                // Column(
                //   children: [
                //     Row(
                //       children: [
                //         // "Sub-Total:".text.fontFamily(semibold).size(16).make(),
                //         boldText(text: "Sub-Total"),
                //         "1000".text.make()
                //       ],
                //     ),
                //     Row(
                //       children: [
                //         // "Tax:".text.fontFamily(semibold).size(16).make(),
                //         boldText(text: "Tax"),
                //         "1000".text.make()
                //       ],
                //     ),
                //     Row(
                //       children: [
                //         // "Discount:".text.fontFamily(semibold).size(16).make(),
                //         boldText(text: "Discount:"),
                //         "1000".text.make()
                //       ],
                //     ),
                //     Row(
                //       children: [
                //         // "Grand Total:".text.fontFamily(semibold).size(16).make(),
                //         boldText(text: "Grand Total"),
                //         "1000".text.make()
                //       ],
                //     )
                //   ],
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
