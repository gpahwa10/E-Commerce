import 'package:amazon_clone/common_widgets/loading_indicator.dart';
import 'package:amazon_clone/consts/consts.dart';
import 'package:amazon_clone/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
          title: Row(
            children: [
              Text(
                'Wishlist ',
                style: TextStyle(
                    color: colorScheme.onSurface,
                    fontWeight: FontWeight.bold,
                    fontSize: 24.sp),
              ),
              // SizedBox(
              //   width: 10.w,
              // ),
              // Container(
              //   height: 34.h,
              //   width: 34.w,
              //   decoration: BoxDecoration(
              //       shape: BoxShape.circle,
              //       color: colorScheme.secondary.withOpacity(0.6)),
              //   child: Center(
              //       child: Text(
              //     '2',
              //     style:
              //         TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400),
              //   )),
              // )
            ],
          )),
      body: StreamBuilder(
          stream: FirestoreServices.getWishlist(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loadingIndicator();
            } else if (snapshot.data!.docs.isEmpty) {
              return 'No Items in wishlist!'
                  .text
                  .color(darkFontGrey)
                  .makeCentered();
            } else {
              var data = snapshot.data!.docs;
              return Expanded(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: data.length,
                    itemBuilder: ((BuildContext context, index) {
                      return Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              // Product Image
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  '${data[index]['p_images'][0]}',
                                  width: 80.w,
                                  height: 80.h,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Container(
                                    width: 80.w,
                                    height: 80.h,
                                    color: Colors.grey.shade200,
                                    child: const Icon(Icons.image_not_supported,
                                        color: Colors.grey),
                                  ),
                                ),
                              ),

                              // Product Details
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${data[index]['p_name']}",
                                      style: TextStyle(
                                          color: colorScheme.onSurface,
                                          fontWeight: FontWeight.w600,fontSize: 14.sp),
                                    ),
                                    const SizedBox(height: 6),
                                    Text("${data[index]['p_base_price']}",style: TextStyle(
                                        color: colorScheme.onSurface,
                                        fontWeight: FontWeight.w400,fontSize: 12.sp),)
                                  ],
                                ),
                              ),

                              // Favorite Icon
                              InkWell(
                                onTap: () async {
                                  await firestore
                                      .collection(productCollection)
                                      .doc(data[index].id)
                                      .set({
                                    'p_wishlist': FieldValue.arrayRemove(
                                        [currentUser!.uid])
                                  }, SetOptions(merge: true));
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.grey.shade50,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.favorite,
                                    color: redColor,
                                    size: 22,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    })),
              );
            }
          }),
    );
  }
}
