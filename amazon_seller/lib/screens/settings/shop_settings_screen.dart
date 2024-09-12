import 'package:amazon_seller/const/const.dart';
import 'package:amazon_seller/controller/profile_controller.dart';
import 'package:amazon_seller/widgets/custom_textfield.dart';
import 'package:amazon_seller/widgets/loading_indicator.dart';
import 'package:amazon_seller/widgets/text_styles.dart';

class ShopSettings extends StatelessWidget {
  const ShopSettings({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: boldText(text: shopSettings, size: 16.0),
          actions: [
            controller.isLoading.value
                ? loadingIndicator(circleColor: white)
                : TextButton(
                    onPressed: () async {
                      controller.isLoading(true);
                      await controller.updateShop(
                        shopAddress: controller.shopAddresController.text,
                        shopDesc: controller.shopDescriptionController.text,
                        shopMobile: controller.shopMobileController.text,
                        shopWebsite: controller.shopWebsiteController.text,
                        shopName: controller.shopNameController.text,
                      );
                      VxToast.show(context, msg: "Shop Settings Updated");
                    },
                    child: normalText(text: save))
          ],
        ),
        backgroundColor: purpleColor,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              customTextField(
                  label: shopName,
                  hint: shopNameHint,
                  isDescription: false,
                  controller: controller.shopNameController),
              10.heightBox,
              customTextField(
                  label: address,
                  hint: shopAddressHint,
                  isDescription: false,
                  controller: controller.shopAddresController),
              10.heightBox,
              customTextField(
                  label: mobile,
                  hint: shopMobHint,
                  isDescription: false,
                  controller: controller.shopMobileController),
              10.heightBox,
              customTextField(
                  label: website,
                  hint: shopWebHint,
                  isDescription: false,
                  controller: controller.shopWebsiteController),
              10.heightBox,
              customTextField(
                  label: description,
                  hint: shopDescHint,
                  isDescription: true,
                  controller: controller.shopDescriptionController)
            ],
          ),
        ),
      ),
    );
  }
}
