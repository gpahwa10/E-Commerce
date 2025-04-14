import 'package:amazon_clone/common_widgets/common_button.dart';
import 'package:amazon_clone/consts/consts.dart';
import 'package:amazon_clone/consts/lists.dart';
import 'package:amazon_clone/controller/product_controller.dart';
import 'package:amazon_clone/screens/chat_screen/chat_screen.dart';
import 'package:get/get.dart';

class ProductDetails extends StatelessWidget {
  final String? title;
  final dynamic data;

  const ProductDetails({super.key, required this.title, required this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    final colorScheme = Theme.of(context).colorScheme;
    return WillPopScope(
      onWillPop: () async {
        controller.resetValues();
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                controller.resetValues();
                Get.back();
              },
              icon: const Icon(Icons.arrow_back, color: darkFontGrey)),
          title: title!.text.color(darkFontGrey).fontFamily(bold).make(),
          actions: [
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
                child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image slider with indicator
                  Stack(
                    children: [
                      VxSwiper.builder(
                          autoPlay: true,
                          height: 350,
                          aspectRatio: 16 / 9,
                          viewportFraction: 1.0,
                          itemCount: data["p_images"].length,
                          itemBuilder: (context, index) {
                            return Image.network(
                              data["p_images"][index],
                              width: double.infinity,
                              fit: BoxFit.cover,
                              loadingBuilder:
                                  (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            loadingProgress.expectedTotalBytes!
                                        : null,
                                    color: redColor,
                                  ),
                                );
                              },
                            );
                          }),
                      // Image count indicator
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.7),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: "${data["p_images"].length} photos"
                              .text
                              .white
                              .size(12)
                              .make(),
                        ),
                      ),
                    ],
                  ),

                  // Product info section
                  Container(
                    padding: const EdgeInsets.all(16),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        title!.text
                            .size(18)
                            .color(darkFontGrey)
                            .fontFamily(bold)
                            .make(),

                        10.heightBox,

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // Price with discount tag
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "${data["p_price"]}"
                                    .numCurrency
                                    .text
                                    .color(redColor)
                                    .fontFamily(bold)
                                    .size(20)
                                    .make(),
                                // Optional discount tag
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: redColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: "20% OFF"
                                      .text
                                      .color(redColor)
                                      .size(12)
                                      .fontFamily(semibold)
                                      .make(),
                                ),
                              ],
                            ),

                            // Rating
                            Row(
                              children: [
                                VxRating(
                                  onRatingUpdate: (value) {},
                                  normalColor: textfieldGrey,
                                  selectionColor: golden,
                                  count: 5,
                                  maxRating: 5,
                                  value: double.parse(data["p_rating"]),
                                  size: 20,
                                  stepInt: false,
                                ),
                                5.widthBox,
                                "(${data["p_rating"]})"
                                    .text
                                    .color(textfieldGrey)
                                    .size(14)
                                    .make(),
                              ],
                            ),
                          ],
                        ),

                        15.heightBox,
                        const Divider(),
                        15.heightBox,

                        // Seller info
                        Row(
                          children: [
                            Expanded(
                                child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                "Seller:".text.color(textfieldGrey).make(),
                                5.heightBox,
                                "${data["p_seller"]}"
                                    .text
                                    .color(darkFontGrey)
                                    .fontFamily(semibold)
                                    .make(),
                              ],
                            )),
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: redColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: redColor.withOpacity(0.5)),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.message_rounded,
                                    color: redColor,
                                    size: 20,
                                  ),
                                  8.widthBox,
                                  "Chat"
                                      .text
                                      .color(redColor)
                                      .fontFamily(semibold)
                                      .make(),
                                ],
                              ),
                            ).onTap(() {
                              Get.to(() => const ChatScreen(), arguments: [
                                data['p_seller'],
                                data['p_vendorID']
                              ]);
                            })
                          ],
                        ),

                        20.heightBox,

                        // Color selection
                        Obx(
                          () => Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: lightGrey.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    "Color: "
                                        .text
                                        .color(darkFontGrey)
                                        .fontFamily(semibold)
                                        .make(),
                                    10.widthBox,
                                    Expanded(
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: List.generate(
                                              data["p_colors"].length,
                                              (index) => Stack(
                                                    alignment: Alignment.center,
                                                    children: [
                                                      VxBox()
                                                          .size(45, 45)
                                                          .roundedFull
                                                          .color(Color(data[
                                                                      "p_colors"]
                                                                  [index])
                                                              .withOpacity(1.0))
                                                          .margin(
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      6))
                                                          .make()
                                                          .onTap(() {
                                                        controller
                                                            .changeColorIndex(
                                                                index);
                                                      }),
                                                      Visibility(
                                                        visible: index ==
                                                            controller
                                                                .colorIndex
                                                                .value,
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: Colors.white,
                                                            shape:
                                                                BoxShape.circle,
                                                          ),
                                                          padding:
                                                              EdgeInsets.all(2),
                                                          child: const Icon(
                                                            Icons.check,
                                                            color: Colors.green,
                                                            size: 16,
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  )),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                15.heightBox,

                                // Quantity selector
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        "Quantity: "
                                            .text
                                            .color(darkFontGrey)
                                            .fontFamily(semibold)
                                            .make(),
                                        10.widthBox,
                                        Obx(
                                          () => Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 4),
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: textfieldGrey),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                IconButton(
                                                    onPressed: () {
                                                      controller
                                                          .decreaseQuantity();
                                                      controller
                                                          .calculateTotalAmount(
                                                              int.parse(data[
                                                                  "p_price"]));
                                                    },
                                                    constraints:
                                                        BoxConstraints.tightFor(
                                                            height: 36,
                                                            width: 36),
                                                    padding: EdgeInsets.zero,
                                                    icon: const Icon(
                                                        Icons.remove,
                                                        size: 18)),
                                                20.widthBox,
                                                controller.quantity.value.text
                                                    .size(16)
                                                    .fontFamily(bold)
                                                    .color(darkFontGrey)
                                                    .make(),
                                                20.widthBox,
                                                IconButton(
                                                    onPressed: () {
                                                      controller.increaseQuantity(
                                                          int.parse(data[
                                                              "p_quantity"]));
                                                      controller
                                                          .calculateTotalAmount(
                                                              int.parse(data[
                                                                  "p_price"]));
                                                    },
                                                    constraints:
                                                        BoxConstraints.tightFor(
                                                            height: 36,
                                                            width: 36),
                                                    padding: EdgeInsets.zero,
                                                    icon: const Icon(Icons.add,
                                                        size: 18)),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    "( ${data["p_quantity"]} Available)"
                                        .text
                                        .color(textfieldGrey)
                                        .make()
                                  ],
                                ),

                                15.heightBox,

                                // Total price
                                Row(
                                  children: [
                                    "Total: "
                                        .text
                                        .color(darkFontGrey)
                                        .fontFamily(semibold)
                                        .make(),
                                    10.widthBox,
                                    "${controller.totalPrice.value != 0 ? controller.totalPrice.value : data['p_price']}"
                                        .numCurrency
                                        .text
                                        .color(redColor)
                                        .size(18)
                                        .fontFamily(bold)
                                        .make()
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),

                        25.heightBox,

                        // Description
                        "Description"
                            .text
                            .size(16)
                            .color(darkFontGrey)
                            .fontFamily(bold)
                            .make(),
                        10.heightBox,
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: lightGrey.withOpacity(0.3),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: "${data["p_description"]}"
                              .text
                              .color(darkFontGrey)
                              .make(),
                        ),

                        20.heightBox,

                        // Details buttons with improved styling
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade300),
                          ),
                          child: ListView.separated(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: itemDetailsButtonList.length,
                            separatorBuilder: (context, index) => Divider(
                              height: 1,
                              color: Colors.grey.shade300,
                            ),
                            itemBuilder: (context, index) => ListTile(
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 4),
                              title: itemDetailsButtonList[index]
                                  .text
                                  .fontFamily(semibold)
                                  .color(darkFontGrey)
                                  .make(),
                              trailing:
                                  const Icon(Icons.arrow_forward_ios, size: 16),
                            ),
                          ),
                        ),

                        30.heightBox,

                        // // You may also like section
                        // prodcutSummaryLike.text
                        //     .fontFamily(bold)
                        //     .size(16)
                        //     .color(darkFontGrey)
                        //     .make(),
                        // 15.heightBox,
                        // SingleChildScrollView(
                        //   physics: const BouncingScrollPhysics(),
                        //   scrollDirection: Axis.horizontal,
                        //   child: Row(
                        //     children: List.generate(
                        //         6,
                        //         (index) => Container(
                        //               width: 160,
                        //               padding: const EdgeInsets.all(8),
                        //               margin: const EdgeInsets.only(right: 12),
                        //               decoration: BoxDecoration(
                        //                 color: Colors.white,
                        //                 borderRadius: BorderRadius.circular(12),
                        //                 boxShadow: [
                        //                   BoxShadow(
                        //                     color: Colors.grey.shade200,
                        //                     blurRadius: 4,
                        //                     spreadRadius: 1,
                        //                   ),
                        //                 ],
                        //               ),
                        //               child: Column(
                        //                 crossAxisAlignment:
                        //                     CrossAxisAlignment.start,
                        //                 children: [
                        //                   AspectRatio(
                        //                     aspectRatio: 1,
                        //                     child: ClipRRect(
                        //                       borderRadius:
                        //                           BorderRadius.circular(8),
                        //                       child: Image.asset(
                        //                         imgP1,
                        //                         fit: BoxFit.cover,
                        //                       ),
                        //                     ),
                        //                   ),
                        //                   10.heightBox,
                        //                   "Laptop 4GB/64GB"
                        //                       .text
                        //                       .color(darkFontGrey)
                        //                       .fontFamily(semibold)
                        //                       .make(),
                        //                   5.heightBox,
                        //                   "₹60,000"
                        //                       .text
                        //                       .size(16)
                        //                       .fontFamily(bold)
                        //                       .color(redColor)
                        //                       .make()
                        //                 ],
                        //               ),
                        //             )),
                        //   ),
                        // ),

                        40.heightBox,
                        // Extra padding at bottom for scrolling
                      ],
                    ),
                  ),
                ],
              ),
            )),

            // Add to cart button with improved styling
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: Offset(0, -5),
                  ),
                ],
              ),
              child: CommonButton(
                onPressed: () {
                  controller.addToCart(
                    title: data['p_name'],
                    image: data['p_images'][0],
                    sellerName: data['p_seller'],
                    color: data['p_colors'][controller.colorIndex.value],
                    vendorID: data['p_vendorID'],
                    qty: controller.quantity.value,
                    tPrice: controller.totalPrice.value!=0? controller.totalPrice.value: data['p_price'],
                    context: context,
                  );
                  VxToast.show(context, msg: "Item added to cart successfully");
                },
                backgroundColor: colorScheme.primary,
                text: 'Add To Cart',
              ),
            )
          ],
        ),
      ),
    );
  }
}
