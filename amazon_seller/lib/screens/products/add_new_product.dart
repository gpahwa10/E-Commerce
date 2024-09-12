import 'package:amazon_seller/const/const.dart';
import 'package:amazon_seller/controller/products_controller.dart';
import 'package:amazon_seller/screens/products/components/product_dropdown.dart';
import 'package:amazon_seller/screens/products/components/product_images.dart';
import 'package:amazon_seller/widgets/custom_textfield.dart';
import 'package:amazon_seller/widgets/loading_indicator.dart';
import 'package:amazon_seller/widgets/login_button.dart';
import 'package:amazon_seller/widgets/text_styles.dart';

class AddNewProduct extends StatelessWidget {
  const AddNewProduct({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return Obx(
      () => Scaffold(
        backgroundColor: purpleColor,
        bottomNavigationBar: SizedBox(
          height: 50,
          child: controller.isLoading.value? loadingIndicator(circleColor:  Colors.blue):loginButton(
              title: "Add Product",
              onPress: () async {
                controller.isLoading(true);
                await controller.uploadImages();
                await controller.uploadProduct(context);
                Get.back();
              },
              color: white,
              textcolor: purpleColor),
        ),
        appBar: AppBar(
          title: boldText(text: "Add New Product", color: fontGrey, size: 16.0),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                customTextField(
                    controller: controller.pNameController,
                    label: "Product Name",
                    hint: "Name of Product",
                    isDescription: false),
                10.heightBox,
                customTextField(
                    controller: controller.pPriceController,
                    label: "Product Price",
                    hint: "Price of product per unit",
                    isDescription: false),
                10.heightBox,
                customTextField(
                    controller: controller.pQuantityController,
                    label: "Quantity",
                    hint: "Quantity of product available",
                    isDescription: false),
                10.heightBox,
                customTextField(
                    controller: controller.pDescriptionController,
                    label: "Product Description",
                    hint: "Description of product",
                    isDescription: true),
                10.heightBox,
                Divider(),
                10.heightBox,
                productDropDown(
                    hint: "Category",
                    list: controller.categoryList,
                    dropValue: controller.categoryValue,
                    controller: controller),
                10.heightBox,
                productDropDown(
                    hint: "Sub-Catgory",
                    list: controller.subCategoryList,
                    dropValue: controller.subcategoryValue,
                    controller: controller),
                10.heightBox,
                Divider(),
                10.heightBox,
                normalText(text: "Choose product images"),
                10.heightBox,
                Obx(
                  () => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(
                        3,
                        (index) => controller.pImagesList[index] != null
                            ? Image.file(
                                controller.pImagesList[index],
                                width: 100,
                              ).onTap(() {
                                controller.pickImage(
                                    index: index, context: context);
                              })
                            : productImages(lable: "${index + 1}").onTap(() {
                                controller.pickImage(
                                    index: index, context: context);
                              })),
                  ),
                ),
                5.heightBox,
                boldText(
                    text: "Note: First image will be display image",
                    color: lightGrey),
                10.heightBox,
                Divider(),
                10.heightBox,
                boldText(text: "Choose product colors", size: 16.0),
                10.heightBox,
                Obx(
                  () => Wrap(
                    spacing: 4.0,
                    runSpacing: 8.0,
                    children: List.generate(
                        9,
                        (index) => Stack(
                              alignment: Alignment.center,
                              children: [
                                VxBox()
                                    .color(Vx.randomColor)
                                    .roundedFull
                                    .size(50, 50)
                                    .make()
                                    .onTap(() {
                                  controller.selectedColorIndex.value = index;
                                }),
                                controller.selectedColorIndex.value == index
                                    ? const Icon(
                                        Icons.done,
                                        color: white,
                                      )
                                    : const SizedBox()
                              ],
                            )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
