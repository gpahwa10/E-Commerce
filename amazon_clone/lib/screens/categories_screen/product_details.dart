import 'package:amazon_clone/consts/consts.dart';
import 'package:amazon_clone/controller/product_controller.dart';
import 'package:amazon_clone/routes/app_routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(title!),
          leading: IconButton(
            onPressed: () {
              controller.resetValues();
              Get.back();
            },
            icon: const Icon(Icons.arrow_back, color: darkFontGrey),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.toNamed(AppRoutes.cartView);
              },
              icon: const Icon(
                Icons.shopping_cart_outlined,
                color: darkFontGrey,
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image slider with pagination dots
                    Stack(
                      children: [
                        VxSwiper.builder(
                          autoPlay: true,
                          height: 300,
                          aspectRatio: 16 / 9,
                          enlargeCenterPage: true,
                          itemCount: data["p_images"].length,
                          itemBuilder: (context, index) {
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(12),
                                child: Image.network(
                                  data["p_images"][index],
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          },
                          onPageChanged: (index) {
                            controller.currentImageIndex.value = index;
                          },
                        ),
                        Positioned(
                          bottom: 10,
                          left: 0,
                          right: 0,
                          child: Obx(
                            () => Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                data["p_images"].length,
                                (index) => Container(
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  width: 8,
                                  height: 8,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: controller.currentImageIndex.value ==
                                            index
                                        ? redColor
                                        : Colors.grey.shade300,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Favorite button
                        Positioned(
                          top: 10,
                          right: 10,
                          child: Obx(
                            () => Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 1,
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.favorite,
                                color: controller.isFav.value
                                    ? redColor
                                    : Colors.grey.shade400,
                                size: 20,
                              ),
                            ).onTap(() {
                              if (controller.isFav.value) {
                                controller.removeFromWishlist(data.id, context);
                              } else {
                                controller.addToWishlist(data.id, context);
                              }
                            }),
                          ),
                        ),
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Size Section
                          // "Size: ${data["p_size"] ?? "7 UK"}".text.color(textfieldGrey).make(),
                          10.heightBox,
                          // Size selection
                          // SingleChildScrollView(
                          //   scrollDirection: Axis.horizontal,
                          //   child: Row(
                          //     children: List.generate(
                          //       5,
                          //           (index) {
                          //         List<String> sizes = ["6 UK", "7 UK", "8 UK", "9 UK", "10 UK"];
                          //         return Obx(
                          //               () => Container(
                          //             margin: const EdgeInsets.only(right: 8),
                          //             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          //             decoration: BoxDecoration(
                          //               color: controller.selectedSizeIndex.value == index
                          //                   ? redColor.withOpacity(0.1)
                          //                   : Colors.grey.shade50,
                          //               border: Border.all(
                          //                 color: controller.selectedSizeIndex.value == index
                          //                     ? redColor
                          //                     : Colors.grey.shade300,
                          //               ),
                          //               borderRadius: BorderRadius.circular(8),
                          //             ),
                          //             child: Text(
                          //               sizes[index],
                          //               style: TextStyle(
                          //                 color: controller.selectedSizeIndex.value == index
                          //                     ? redColor
                          //                     : darkFontGrey,
                          //                 fontFamily: semibold,
                          //               ),
                          //             ),
                          //           ).onTap(() {
                          //             controller.selectedSizeIndex.value = index;
                          //           }),
                          //         );
                          //       },
                          //     ),
                          //   ),
                          // ),
                          // Product title
                          Text(
                            title!,
                            style: TextStyle(
                                fontSize: 18.sp, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 10.h),
                          // title!.text
                          //     .size(18)
                          //     .color(darkFontGrey)
                          //     .fontFamily(bold)
                          //     .make(),
                          // 8.heightBox,
                          // Description
                          Text(data["p_description"] != null
                              ? data["p_description"].toString().substring(
                                  0,
                                  data["p_description"].toString().length > 100
                                      ? 100
                                      : data["p_description"].toString().length)
                              : "No description"),
                          data["p_description"] != null &&
                                  data["p_description"].toString().length > 100
                              ? "More"
                                  .text
                                  .color(redColor)
                                  .fontFamily(semibold)
                                  .make()
                              : Container(),
                          SizedBox(height: 10.h),
                          // Rating
                          Row(
                            children: [
                              VxRating(
                                onRatingUpdate: (value) {},
                                normalColor: textfieldGrey,
                                selectionColor: golden,
                                count: 5,
                                size: 20,
                                maxRating: 5,
                                value: double.parse(data["p_rating"] ?? "4.5"),
                                stepInt: false,
                              ),
                              5.widthBox,
                              SizedBox(width: 5.w),

                              // "(${data["p_rating_count"] ?? "56,890"})".text.color(textfieldGrey).make(),
                            ],
                          ),

                          SizedBox(height: 15.h),
                          Row(
                            children: [
                              // "${data["p_price_original"] ?? "₹2,999"}"
                              //     .text
                              //     .color(textfieldGrey)
                              //     .lineThrough
                              //     .make(),
                              SizedBox(width: 10.w),
                              Text(
                                "₹ ${data["p_price"]}",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16.sp),
                              ),
                              SizedBox(width: 10.w),
                              // "${data["p_discount"] ?? "50% OFF"}"
                              //     .text
                              //     .color(Colors.green)
                              //     .fontFamily(semibold)
                              //     .make(),
                            ],
                          ),

                          SizedBox(height: 20.h),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.verified,
                                      color: Colors.green, size: 18),
                                  5.widthBox,
                                  "Trusted Seller"
                                      .text
                                      .fontFamily(semibold)
                                      .make(),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.list_alt_outlined, size: 18),
                                  5.widthBox,
                                  "Return policy"
                                      .text
                                      .fontFamily(semibold)
                                      .make(),
                                ],
                              ),
                            ],
                          ),

                          20.heightBox,
                          // Delivery info
                          Row(
                            children: [
                              "Delivery in".text.color(darkFontGrey).make(),
                              5.widthBox,
                              "within Hour"
                                  .text
                                  .color(darkFontGrey)
                                  .fontFamily(bold)
                                  .make(),
                            ],
                          ),

                          20.heightBox,
                          Text(
                            "view Similar",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16.sp),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom buttons
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.blue.shade900,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: "Add to cart"
                            .text
                            .white
                            .fontFamily(semibold)
                            .make(),
                      ),
                    ).onTap(() {
                      controller.addToCart(
                        title: data['p_name'],
                        image: data['p_images'][0],
                        sellerName: data['p_seller'],
                        color: data['p_colors'] != null
                            ? data['p_colors'][controller.colorIndex.value]
                            : null,
                        vendorID: data['p_vendorID'],
                        qty: controller.quantity.value,
                        tPrice: controller.totalPrice.value,
                        context: context,
                      );
                      VxToast.show(context,
                          msg: "Item added to cart successfully");
                    }),
                  ),
                  10.widthBox,
                  Expanded(
                    child: Container(
                      height: 45,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: "Buy Now".text.white.fontFamily(semibold).make(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
