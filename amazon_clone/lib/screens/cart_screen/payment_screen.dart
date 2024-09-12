import 'package:amazon_clone/common_widgets/common_buton.dart';
import 'package:amazon_clone/common_widgets/loading_indicator.dart';
import 'package:amazon_clone/consts/consts.dart';
import 'package:amazon_clone/consts/lists.dart';
import 'package:amazon_clone/controller/cart_controller.dart';
import 'package:amazon_clone/screens/home_screen/home.dart';
import 'package:get/get.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Obx(
      ()=> Scaffold(
          backgroundColor: whiteColor,
          appBar: AppBar(
            title: "Choose Payment Method"
                .text
                .fontFamily(semibold)
                .color(darkFontGrey)
                .make(),
          ),
          bottomNavigationBar: SizedBox(
              height: 60,
              child: controller.placingOrder.value
                  ? loadingIndicator()
                  : loginbutton(
                      onPress: () async  {
                        await controller.palceMyOrder(
                            orderPaymentMethod:
                                paymentMethods[controller.paymentIndex.value],
                            totalAmount: controller.totalP.value);
      
                        await controller.clearCart();
                        VxToast.show(context, msg: "Order Placed Successfully");
                        Get.offAll(const Home());
                      },
                      bgcolor: redColor,
                      textColor: whiteColor,
                      title: "Place My Order")),
          body: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Obx(
                () => Column(
                  children: List.generate(paymentMethodImg.length, (index) {
                    return GestureDetector(
                      onTap: () {
                        controller.changePaymentIndex(index);
                      },
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: controller.paymentIndex.value == index
                                    ? redColor
                                    : Colors.transparent,
                                width: 4)),
                        margin: const EdgeInsets.only(bottom: 8),
                        child: Stack(alignment: Alignment.topRight, children: [
                          Image.asset(
                            colorBlendMode: controller.paymentIndex.value == index
                                ? BlendMode.darken
                                : BlendMode.color,
                            color: controller.paymentIndex.value == index
                                ? Colors.black.withOpacity(0.5)
                                : Colors.transparent,
                            paymentMethodImg[index],
                            width: double.infinity,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                          controller.paymentIndex.value == index
                              ? Transform.scale(
                                  scale: 1.5,
                                  child: Checkbox(
                                      activeColor: Colors.green,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      value: true,
                                      onChanged: ((value) {})),
                                )
                              : Container()
                        ]),
                      ),
                    );
                  }),
                ),
              ))),
    );
  }
}
