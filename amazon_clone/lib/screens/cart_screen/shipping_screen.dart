import 'package:amazon_clone/common_widgets/common_buton.dart';
import 'package:amazon_clone/common_widgets/custom_textfield.dart';
import 'package:amazon_clone/consts/consts.dart';
import 'package:amazon_clone/controller/cart_controller.dart';
import 'package:amazon_clone/screens/cart_screen/payment_screen.dart';
import 'package:get/get.dart';

class ShippingScreen extends StatelessWidget {
  const ShippingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: "Shipping Info"
            .text
            .fontFamily(semibold)
            .color(darkFontGrey)
            .make(),
      ),
      bottomNavigationBar: SizedBox(
          height: 60,
          child: loginbutton(
              onPress: () {
                if (controller.addressController.text.length > 10) {
                  Get.to(const PaymentMethods());
                } else {
                  VxToast.show(context,
                      msg: "Please fill all the mentioned Details");
                }
              },
              bgcolor: redColor,
              textColor: whiteColor,
              title: "Continue!")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            customTextField(
                title: "Address",
                hint: "Address",
                isPass: false,
                controller: controller.addressController),
            customTextField(
                title: "City",
                hint: "City",
                isPass: false,
                controller: controller.cityController),
            customTextField(
                title: "State",
                hint: "State",
                isPass: false,
                controller: controller.stateController),
            customTextField(
                title: "Postal Code",
                hint: "Postal Code",
                isPass: false,
                controller: controller.postalCodeController),
            customTextField(
                title: "Phone",
                hint: "Phone",
                isPass: false,
                controller: controller.phoneController)
          ],
        ),
      ),
    );
  }
}
