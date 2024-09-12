import 'package:amazon_clone/common_widgets/common_buton.dart';
import 'package:amazon_clone/consts/consts.dart';
import 'package:amazon_clone/consts/lists.dart';
import 'package:amazon_clone/controller/product_controller.dart';
import 'package:amazon_clone/screens/chat_screen/chat_screen.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ProductDetails extends StatelessWidget {
  final String? title;
  final dynamic data;
  const ProductDetails({super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return WillPopScope(
      onWillPop: () async {
        controller.resetValues();
        return true;
      },
      child: Scaffold(
        backgroundColor: lightGrey,
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                controller.resetValues();
                Get.back();
              },
              icon: const Icon(Icons.arrow_back)),
          title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
          actions: [
            IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.share,
                  color: darkFontGrey,
                )),
            Obx(
              () => IconButton(
                  onPressed: () {
                    if (controller.isFav.value) {
                      controller.removeFromWishlist(data.id, context);
                    } else {
                      controller.addToWishlist(data.id, context);
                    }
                  },
                  icon: Icon(
                    Icons.favorite,
                    color: controller.isFav.value ? redColor : darkFontGrey,
                  )),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VxSwiper.builder(
                        autoPlay: true,
                        height: 350,
                        aspectRatio: 16 / 9,
                        itemCount: data["p_images"].length,
                        itemBuilder: (context, index) {
                          return Image.network(data["p_images"][index],
                              width: double.infinity, fit: BoxFit.cover);
                        }),
                    10.heightBox,
                    title!.text
                        .size(16)
                        .color(darkFontGrey)
                        .fontFamily(semibold)
                        .make(),
                    //Rating Section
                    10.heightBox,
                    VxRating(
                      onRatingUpdate: (value) {},
                      normalColor: textfieldGrey,
                      selectionColor: golden,
                      count: 5,
                      maxRating: 5,
                      value: double.parse(data["p_rating"]),
                      size: 25,
                      stepInt: false,
                    ),
                    10.heightBox,
                    //Price
                    "${data["p_price"]}"
                        .numCurrency
                        .text
                        .color(redColor)
                        .fontFamily(bold)
                        .size(18)
                        .make(),
                    10.heightBox,
                    Row(
                      children: [
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "${data["p_seller"]}"
                                .text
                                .white
                                .fontFamily(semibold)
                                .make(),
                            5.heightBox,
                            "${data["p_description"]}"
                                .text
                                .color(darkFontGrey)
                                .fontFamily(semibold)
                                .size(16)
                                .make()
                          ],
                        )),
                        const CircleAvatar(
                          backgroundColor: Colors.white,
                          child: Icon(
                            Icons.message_rounded,
                            color: darkFontGrey,
                          ),
                        ).onTap(() {
                          Get.to(() => const ChatScreen(), arguments: [
                            data['p_seller'],
                            data['p_vendorID']
                          ]);
                        })
                      ],
                    )
                        .box
                        .height(60)
                        .padding(const EdgeInsets.symmetric(horizontal: 16))
                        .color(textfieldGrey)
                        .make(),
                    //color section
                    20.heightBox,
                    Obx(
                      () => Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child:
                                    "Color:".text.color(textfieldGrey).make(),
                              ),
                              Row(
                                children: List.generate(
                                    data["p_colors"].length,
                                    (index) => Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            VxBox()
                                                .size(40, 40)
                                                .roundedFull
                                                .color(Color(
                                                        data["p_colors"][index])
                                                    .withOpacity(1.0))
                                                .margin(
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 6))
                                                .make()
                                                .onTap(() {
                                              controller
                                                  .changeColorIndex(index);
                                            }),
                                            Visibility(
                                              visible: index ==
                                                  controller.colorIndex.value,
                                              child: const Icon(
                                                Icons.done,
                                                color: whiteColor,
                                              ),
                                            )
                                          ],
                                        )),
                              ),
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),
                          //Quantity Section
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: "Quantity:"
                                    .text
                                    .color(textfieldGrey)
                                    .make(),
                              ),
                              Obx(
                                () => Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          controller.decreaseQuantity();
                                          controller.calculateTotalAmount(
                                              int.parse(data["p_price"]));
                                        },
                                        icon: const Icon(Icons.remove)),
                                    controller.quantity.value.text
                                        .size(16)
                                        .fontFamily(bold)
                                        .color(darkFontGrey)
                                        .make(),
                                    IconButton(
                                        onPressed: () {
                                          controller.increaseQuantity(
                                              int.parse(data["p_quantity"]));
                                          controller.calculateTotalAmount(
                                              int.parse(data["p_price"]));
                                        },
                                        icon: const Icon(Icons.add)),
                                    10.widthBox,
                                    "( ${data["p_quantity"]} Available)"
                                        .text
                                        .color(textfieldGrey)
                                        .make()
                                  ],
                                ),
                              ),
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),
                          //Total
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child:
                                    "Total:".text.color(textfieldGrey).make(),
                              ),
                              "${controller.totalPrice.value}"
                                  .numCurrency
                                  .text
                                  .color(redColor)
                                  .size(16)
                                  .fontFamily(bold)
                                  .make()
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make()
                        ],
                      ).box.white.shadowSm.make(),
                    ),
                    //Description Section
                    10.heightBox,
                    "Decription"
                        .text
                        .color(darkFontGrey)
                        .fontFamily(semibold)
                        .make(),
                    10.heightBox,
                    "${data["p_description"]}".text.color(darkFontGrey).make(),
                    //button Section
                    10.heightBox,
                    ListView(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: List.generate(
                          itemDetailsButtonList.length,
                          (index) => ListTile(
                                title: itemDetailsButtonList[index]
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                                trailing: const Icon(Icons.arrow_forward),
                              )),
                    ),
                    //products may like section
                    20.heightBox,
                    prodcutSummaryLike.text
                        .fontFamily(bold)
                        .size(16)
                        .color(darkFontGrey)
                        .make(),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            6,
                            (index) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      imgP1,
                                      width: 150,
                                      fit: BoxFit.cover,
                                    ),
                                    10.heightBox,
                                    "Laptop 4GB/64GB"
                                        .text
                                        .color(darkFontGrey)
                                        .fontFamily(semibold)
                                        .make(),
                                    10.heightBox,
                                    "₹60,000"
                                        .text
                                        .size(16)
                                        .fontFamily(bold)
                                        .color(Colors.black)
                                        .make()
                                  ],
                                )
                                    .box
                                    .roundedSM
                                    .white
                                    .margin(const EdgeInsets.symmetric(
                                        horizontal: 4))
                                    .padding(const EdgeInsets.all(8))
                                    .make()),
                      ),
                    ),
                  ],
                ),
              ),
            )),
            SizedBox(
              height: 60,
              width: double.infinity,
              child: loginbutton(onPress: () {
                controller.addToCart(
                  title: data['p_name'],
                  image: data['p_images'][0],
                  sellerName: data['p_seller'],
                  color: data['p_colors'][controller.colorIndex.value],
                  vendorID: data['p_vendorID'],
                  qty: controller.quantity.value,
                  tPrice: controller.totalPrice.value,
                  context: context,
                );
                VxToast.show(context, msg: "Item added to cart successfully");
              },bgcolor:  redColor,textColor:  whiteColor,title:  "ADD TO CART"),
            )
          ],
        ),
      ),
    );
  }
}
