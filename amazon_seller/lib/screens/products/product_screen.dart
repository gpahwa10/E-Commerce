import 'package:amazon_seller/const/const.dart';
import 'package:amazon_seller/controller/products_controller.dart';
import 'package:amazon_seller/screens/products/add_new_product.dart';
import 'package:amazon_seller/screens/products/product_details.dart';
import 'package:amazon_seller/services/store_services.dart';
import 'package:amazon_seller/widgets/appbar.dart';
import 'package:amazon_seller/widgets/loading_indicator.dart';
import 'package:amazon_seller/widgets/text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';
class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await controller.getCategories();
          controller.populateCategoryList();
          Get.to(() => const AddNewProduct());
        },
        backgroundColor: purpleColor,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(
          Icons.add,
          color: white,
          size: 28,
        ),
      ),
      appBar: customAppBar(title: product),
      body: StreamBuilder(
        stream: StoreServices.getProducts(uid: currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: loadingIndicator());
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.inventory_2_outlined,
                    size: 80,
                    color: lightGrey,
                  ),
                  const SizedBox(height: 15),
                  normalText(
                    text: "No products yet!",
                    color: fontGrey,
                    size: 18.0,
                  ),
                  const SizedBox(height: 10),
                  normalText(
                    text: "Add your first product with the + button",
                    color: lightGrey,
                  ),
                ],
              ),
            );
          } else {
            var data = snapshot.data!.docs;
            return Container(
              color: lightGrey.withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: data.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    return ProductCard(data: data[index], controller: controller);
                  },
                ),
              ),
            );
          }
        },
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final dynamic data;
  final ProductController controller;

  const ProductCard({Key? key, required this.data, required this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Null check for data
    if (data == null) {
      return const SizedBox.shrink(); // Return empty widget if data is null
    }

    // Fallback values for prices
    final actualPrice = data['p_actual_price'] ?? 0.0;
    final basePrice = data['p_base_price'] ?? 0.0;
    final quantity = data['p_quantity'];

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: (data['is_featured'] ?? false) ? purpleColor.withOpacity(0.3) : Colors.transparent,
          width: (data['is_featured'] ?? false) ? 1 : 0,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        onTap: () {
          if (data != null) {
            Get.to(() => ProductDetails(data: data));
          }
        },
        leading: Hero(
          tag: "${data.id}_image",
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                data['p_images'] != null && data['p_images'].isNotEmpty
                    ? data['p_images'][0]
                    : '',
                width: 85,
                height: 85,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 85,
                  height: 85,
                  color: Colors.grey.shade200,
                  child: const Icon(Icons.image_not_supported, color: darkGrey),
                ),
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    width: 85,
                    height: 85,
                    color: Colors.grey.shade100,
                    child: Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                            : null,
                        strokeWidth: 2,
                        color: purpleColor,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
        title: boldText(
          text: data['p_name'] ?? 'No Name',
          color: fontGrey,
          size: 16.0,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 5),
            Row(
              children: [
                Icon(
                  Icons.currency_rupee,
                  size: 14,
                  color: darkGrey,
                ),
                normalText(
                  text: actualPrice.toString(), // Safe usage with fallback
                  color: darkGrey,
                )
              ],
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                Icon(
                  Icons.price_change_outlined,
                  size: 14,
                  color: darkGrey.withOpacity(0.7),
                ),
                const SizedBox(width: 4),
                normalText(
                  text: "Base Price: ₹${basePrice.toString()}", // Safe usage
                  color: darkGrey.withOpacity(0.8),
                  size: 12.0,
                ),
              ],
            ),
            if (quantity != null) ...[
              const SizedBox(width: 10),
              Icon(
                Icons.inventory,
                size: 14,
                color: darkGrey.withOpacity(0.7),
              ),
              const SizedBox(width: 4),
              normalText(
                text: "Qty: $quantity",
                color: darkGrey.withOpacity(0.8),
                size: 13.0,
              ),
            ],
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: (data['is_featured'] ?? false) ? green.withOpacity(0.1) : red.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    (data['is_featured'] ?? false) ? Icons.star : Icons.star_border,
                    size: 12,
                    color: (data['is_featured'] ?? false) ? green : red,
                  ),
                  const SizedBox(width: 4),
                  normalText(
                    text: (data['is_featured'] ?? false) ? "Featured" : "Not Featured",
                    color: (data['is_featured'] ?? false) ? green : red,
                    size: 12.0,
                  ),
                ],
              ),
            ),
          ],
        ),
        trailing: VxPopupMenu(
          arrowSize: 0.0,
          menuBuilder: () => Column(
            children: List.generate(
              popUpMenuIcons.length,
                  (i) => Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Icon(
                      popUpMenuIcons[i],
                      color: data['featured_id'] == currentUser!.uid && i == 0
                          ? green
                          : i == 2 ? red : darkGrey,
                    ),
                    const SizedBox(width: 10),
                    normalText(
                      text: data['featured_id'] == currentUser!.uid && i == 0
                          ? "Remove Featured"
                          : popUpMenuTitles[i],
                      color: i == 2 ? red : darkGrey,
                    ),
                  ],
                ).onTap(() {
                  switch (i) {
                    case 0:
                      if (data['is_featured'] == true) {
                        controller.removeFeatured(data.id);
                      } else {
                        controller.addFeatured(data.id);
                      }
                      break;
                    case 1:
                      showDialog(
                        context: Get.context!,
                        builder: (context) => AlertDialog(
                          title: boldText(text: "Delete Product", color: purpleColor),
                          content: normalText(
                            text: "Are you sure you want to delete this product?",
                            color: darkGrey,
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: normalText(text: "Cancel", color: darkGrey),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: red,
                                foregroundColor: white,
                              ),
                              onPressed: () {
                                controller.removeProduct(data.id);
                                Navigator.pop(context);
                              },
                              child: normalText(text: "Delete", color: white),
                            ),
                          ],
                        ),
                      );
                      break;
                    default:
                  }
                }),
              ),
            ),
          )
              .box
              .color(white)
              .rounded
              .shadow
              .width(200)
              .make(),
          clickType: VxClickType.singleClick,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.more_vert_rounded),
          ),
        ),
      ),
    );
  }
}