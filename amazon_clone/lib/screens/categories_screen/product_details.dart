import 'package:amazon_clone/common_widgets/common_button.dart';
import 'package:amazon_clone/consts/consts.dart';
import 'package:amazon_clone/consts/lists.dart';
import 'package:amazon_clone/controller/product_controller.dart';
import 'package:amazon_clone/screens/chat_screen/chat_screen.dart';
import 'package:amazon_clone/screens/negotiation_screen/negotiation_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            icon: const Icon(Icons.arrow_back, color: darkFontGrey),
          ),
          title: Text(
            title ?? 'Product Details', // Fallback if title is null
            style: TextStyle(
              color: darkFontGrey,
              fontFamily: bold,
            ),
          ),
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
                ),
              ),
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
                        SizedBox(
                          height: 350.h,
                          width: double.infinity,
                          child: PageView.builder(
                            itemCount: (data['p_images'] as List?)?.length ?? 0,
                            pageSnapping: true,
                            itemBuilder: (context, index) {
                              return Image.network(
                                (data['p_images'] as List?)?[index] ?? '',
                                width: double.infinity,
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes!
                                          : null,
                                      color: redColor,
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.error, color: darkFontGrey),
                              );
                            },
                          ),
                        ),
                        // Image count indicator
                        Positioned(
                          bottom: 10.h,
                          right: 10.w,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Text(
                              "${(data['p_images'] as List?)?.length ?? 0} photos",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.sp,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),

                    // Product info section
                    Container(
                      padding: EdgeInsets.all(16.w),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.r),
                          topRight: Radius.circular(25.r),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title ?? data['p_name'] ?? 'No Name', // Use p_name if title is null
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: darkFontGrey,
                              fontFamily: bold,
                            ),
                          ),

                          SizedBox(height: 10.h),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Price with discount tag
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "\$${(data['p_actual_price'] ?? 0).toString()}", // Fallback to 0
                                    style: TextStyle(
                                      color: redColor,
                                      fontFamily: bold,
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                  // Optional discount tag (assuming a discount logic)
                                  // if ((data['p_base_price'] ?? 0) > (data['p_actual_price'] ?? 0))
                                  //   Container(
                                  //     margin: EdgeInsets.only(top: 4.h),
                                  //     padding: EdgeInsets.symmetric(
                                  //       horizontal: 8.w,
                                  //       vertical: 2.h,
                                  //     ),
                                  //     decoration: BoxDecoration(
                                  //       color: redColor.withOpacity(0.1),
                                  //       borderRadius: BorderRadius.circular(4.r),
                                  //     ),
                                  //     child: Text(
                                  //       "${(((data['p_base_price'] ?? 0) - (data['p_actual_price'] ?? 0)) / (data['p_base_price'] ?? 1) * 100).toStringAsFixed(0)}% OFF",
                                  //       style: TextStyle(
                                  //         color: redColor,
                                  //         fontSize: 12.sp,
                                  //         fontFamily: semibold,
                                  //       ),
                                  //     ),
                                  //   ),
                                ],
                              ),

                              // Rating
                              Row(
                                children: [
                                  Row(
                                    children: List.generate(
                                      5,
                                          (index) => Icon(
                                        index < (double.tryParse(data['p_rating']?.toString() ?? "0.0") ?? 0.0).floor()
                                            ? Icons.star
                                            : index < (double.tryParse(data['p_rating']?.toString() ?? "0.0") ?? 0.0)
                                            ? Icons.star_half
                                            : Icons.star_border,
                                        color: golden,
                                        size: 20.sp,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 5.w),
                                  Text(
                                    "(${data['p_rating'] ?? '0.0'})",
                                    style: TextStyle(
                                      color: textfieldGrey,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          SizedBox(height: 15.h),
                          const Divider(),
                          SizedBox(height: 15.h),

                          // Seller info
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Seller:",
                                      style: TextStyle(
                                        color: textfieldGrey,
                                      ),
                                    ),
                                    SizedBox(height: 5.h),
                                    Text(
                                      data['p_seller'] ?? 'Unknown Seller',
                                      style: TextStyle(
                                        color: darkFontGrey,
                                        fontFamily: semibold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => const ChatScreen(), arguments: [
                                    data['p_seller'] ?? 'Unknown Seller',
                                    data['p_vendorID'] ?? ''
                                  ]);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8.w),
                                  decoration: BoxDecoration(
                                    color: redColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12.r),
                                    border: Border.all(
                                      color: redColor.withOpacity(0.5),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.message_rounded,
                                        color: redColor,
                                        size: 20,
                                      ),
                                      SizedBox(width: 8.w),
                                      Text(
                                        "Chat",
                                        style: TextStyle(
                                          color: redColor,
                                          fontFamily: semibold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(width: 10.w),
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => NegotiationScreen(), arguments: [
                                    data['p_name'] ?? 'Unknown Product',
                                    data['p_actual_price'] ?? 0,
                                    data['p_base_price'] ?? 0,
                                    (data['p_images'] as List?)?.first ?? ''
                                  ]);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(8.w),
                                  decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12.r),
                                    border: Border.all(
                                      color: Colors.green.withOpacity(0.5),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      const Icon(
                                        Icons.handshake_outlined,
                                        color: Colors.green,
                                        size: 20,
                                      ),
                                      SizedBox(width: 8.w),
                                      Text(
                                        "Negotiate",
                                        style: TextStyle(
                                          color: Colors.green,
                                          fontFamily: semibold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 20.h),

                          // Color selection
                          Obx(
                                () => Container(
                              padding: EdgeInsets.all(16.w),
                              decoration: BoxDecoration(
                                color: lightGrey.withOpacity(0.3),
                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        "Color: ",
                                        style: TextStyle(
                                          color: darkFontGrey,
                                          fontFamily: semibold,
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: List.generate(
                                              (data['p_colors'] as List?)?.length ?? 0,
                                                  (index) => Stack(
                                                alignment: Alignment.center,
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      controller.changeColorIndex(index);
                                                    },
                                                    child: Container(
                                                      margin: EdgeInsets.symmetric(
                                                        horizontal: 6.w,
                                                      ),
                                                      width: 45.w,
                                                      height: 45.w,
                                                      decoration: BoxDecoration(
                                                        color: Color(
                                                          (data['p_colors'] as List?)?[index] ?? 0xFF000000,
                                                        ).withOpacity(1.0),
                                                        shape: BoxShape.circle,
                                                      ),
                                                    ),
                                                  ),
                                                  Visibility(
                                                    visible: index ==
                                                        controller.colorIndex.value,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        shape: BoxShape.circle,
                                                      ),
                                                      padding: EdgeInsets.all(2.w),
                                                      child: const Icon(
                                                        Icons.check,
                                                        color: Colors.green,
                                                        size: 16,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 15.h),

                                  // Quantity selector
                                  Column(
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Quantity: ",
                                            style: TextStyle(
                                              color: darkFontGrey,
                                              fontFamily: semibold,
                                            ),
                                          ),
                                          SizedBox(width: 10.w),
                                          Obx(
                                                () => Container(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 8.w,
                                                vertical: 4.h,
                                              ),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: textfieldGrey,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(8.r),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  IconButton(
                                                    onPressed: () {
                                                      controller.decreaseQuantity();
                                                      controller.calculateTotalAmount(
                                                        int.parse((data['p_actual_price'] ?? '0').toString()),
                                                      );
                                                    },
                                                    constraints: BoxConstraints.tightFor(
                                                      height: 36.h,
                                                      width: 36.w,
                                                    ),
                                                    padding: EdgeInsets.zero,
                                                    icon: Icon(
                                                      Icons.remove,
                                                      size: 18.sp,
                                                    ),
                                                  ),
                                                  SizedBox(width: 20.w),
                                                  Text(
                                                    "${controller.quantity.value}",
                                                    style: TextStyle(
                                                      fontSize: 16.sp,
                                                      fontFamily: bold,
                                                      color: darkFontGrey,
                                                    ),
                                                  ),
                                                  SizedBox(width: 20.w),
                                                  IconButton(
                                                    onPressed: () {
                                                      controller.increaseQuantity(
                                                        int.parse((data['p_quantity'] ?? '0').toString()),
                                                      );
                                                      controller.calculateTotalAmount(
                                                        int.parse((data['p_actual_price'] ?? '0').toString()),
                                                      );
                                                    },
                                                    constraints: BoxConstraints.tightFor(
                                                      height: 36.h,
                                                      width: 36.w,
                                                    ),
                                                    padding: EdgeInsets.zero,
                                                    icon: Icon(
                                                      Icons.add,
                                                      size: 18.sp,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 6.h),
                                      Text(
                                        "( ${(data['p_quantity'] ?? 0)} Available)",
                                        style: TextStyle(
                                          color: textfieldGrey,
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 15.h),

                                  // Total price
                                  Row(
                                    children: [
                                      Text(
                                        "Total: ",
                                        style: TextStyle(
                                          color: darkFontGrey,
                                          fontFamily: semibold,
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Text(
                                        "\$${(controller.totalPrice.value != 0 ? controller.totalPrice.value : (data['p_actual_price'] ?? 0))}",
                                        style: TextStyle(
                                          color: redColor,
                                          fontSize: 18.sp,
                                          fontFamily: bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(height: 25.h),

                          // Description
                          Text(
                            "Description",
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: darkFontGrey,
                              fontFamily: bold,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Container(
                            padding: EdgeInsets.all(12.w),
                            decoration: BoxDecoration(
                              color: lightGrey.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: Text(
                              data['p_description'] ?? 'No description available',
                              style: TextStyle(
                                color: darkFontGrey,
                              ),
                            ),
                          ),

                          SizedBox(height: 20.h),

                          // Details buttons with improved styling
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
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
                                  horizontal: 16.w,
                                  vertical: 4.h,
                                ),
                                title: Text(
                                  itemDetailsButtonList[index],
                                  style: TextStyle(
                                    fontFamily: semibold,
                                    color: darkFontGrey,
                                  ),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  size: 16.sp,
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 40.h),
                          // Extra padding at bottom for scrolling
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Add to cart button with improved styling
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 8.h,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 10,
                    spreadRadius: 1,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: CommonButton(
                onPressed: () {
                  controller.addToCart(
                    title: data['p_name'] ?? 'Unknown Product',
                    image: (data['p_images'] as List?)?.first ?? '',
                    sellerName: data['p_seller'] ?? 'Unknown Seller',
                    color: (data['p_colors'] as List?)?.first ?? 0xFF000000,
                    vendorID: data['p_vendorID'] ?? '',
                    qty: controller.quantity.value,
                    tPrice: controller.totalPrice.value != 0
                        ? controller.totalPrice.value
                        : (data['p_actual_price'] ?? 0),
                    context: context,
                  );
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Item added to cart successfully"),
                      duration: const Duration(seconds: 2),
                    ),
                  );
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