import 'package:amazon_clone/common_widgets/loading_indicator.dart';
import 'package:amazon_clone/consts/consts.dart';
import 'package:amazon_clone/controller/cart_controller.dart';
import 'package:amazon_clone/routes/app_routes.dart';
import 'package:amazon_clone/screens/cart_screen/widgets/cart_item_tile.dart';
import 'package:amazon_clone/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.w),
          child: Row(
            children: [
              Text(
                "Total: ₹${controller.totalP.value}",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              Spacer(),
              GestureDetector(
                onTap: () => Get.toNamed(AppRoutes.shippingView),
                child: Container(
                  height: 40.h,
                  width: 128.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12.r),
                      color: colorScheme.tertiary.withOpacity(0.8)),
                  child: Center(
                      child: Text(
                    "Checkout",
                    style: TextStyle(
                        color: colorScheme.onPrimary,
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp),
                  )),
                ),
              )
            ],
          ),
        ),
        backgroundColor: whiteColor,
        appBar: AppBar(
            title: Row(
              children: [
                Text(
                  'Cart',
                  style: TextStyle(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.bold,
                      fontSize: 24.sp),
                ),
                SizedBox(
                  width: 10.w,
                ),
                Container(
                  height: 34.h,
                  width: 34.w,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colorScheme.secondary.withOpacity(0.6)),
                  child: Center(
                      child: Text(
                    "${controller.productSnapshot.length}",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
                  )),
                )
              ],
            )),
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
                    .makeCentered();
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
                              return CartItemTile(
                                  qty: data[index]['qty'],
                                  id: data[index].id,
                                  title: data[index]['title'],
                                  image: data[index]['image'],
                                  tPrice: data[index]['tPrice'].toString());
                            })),
                      ),
                    ],
                  ),
                );
              }
            })));
  }
}
