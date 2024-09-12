import 'package:amazon_clone/common_widgets/common_buton.dart';
import 'package:amazon_clone/common_widgets/loading_indicator.dart';
import 'package:amazon_clone/consts/consts.dart';
import 'package:amazon_clone/controller/cart_controller.dart';
import 'package:amazon_clone/screens/cart_screen/shipping_screen.dart';
import 'package:amazon_clone/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    return Scaffold(
        bottomNavigationBar: loginbutton(
            onPress: () {
              Get.to(const ShippingScreen());
            },
            bgcolor: redColor,
            textColor: whiteColor,
            title: "Proceed to checkout"),
        backgroundColor: whiteColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: "Cart".text.color(darkFontGrey).fontFamily(semibold).make(),
        ),
        body: StreamBuilder(
            stream: FirestoreServices.getCart(currentUser!.uid),
            builder:
                ((BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return loadingIndicator();
              } else if (snapshot.data!.docs.isEmpty) {
                return "Cart is Empty!"
                    .text
                    .fontFamily(semibold)
                    .color(darkFontGrey)
                    .make();
              } else {
                var data = snapshot.data!.docs;
                controller.calculate(data);
                controller.productSnapshot = data;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: ((BuildContext context, index) {
                              return ListTile(
                                  leading: Image.network(
                                    '${data[index]['image']}',
                                    width: 80,
                                    fit: BoxFit.cover,
                                  ),
                                  title:
                                      "${data[index]['title']}  (x${data[index]['qty']})"
                                          .text
                                          .size(16)
                                          .fontFamily(semibold)
                                          .make(),
                                  subtitle: "${data[index]['tPrice']}"
                                      .numCurrency
                                      .text
                                      .size(14)
                                      .color(redColor)
                                      .fontFamily(semibold)
                                      .make(),
                                  trailing: const Icon(
                                    Icons.delete,
                                    color: redColor,
                                  ).onTap(() {
                                    FirestoreServices.deleteDoc(data[index].id);
                                  }));
                            })),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          "Total Price"
                              .text
                              .color(darkFontGrey)
                              .fontFamily(semibold)
                              .make(),
                          Obx(
                            () => controller.totalP.value.numCurrency.text
                                .color(redColor)
                                .fontFamily(semibold)
                                .make(),
                          )
                        ],
                      )
                          .box
                          .padding(const EdgeInsets.all(12))
                          .width(context.screenWidth - 60)
                          .color(lightGolden)
                          .make(),
                      10.heightBox,
                    ],
                  ),
                );
              }
            })));
  }
}
