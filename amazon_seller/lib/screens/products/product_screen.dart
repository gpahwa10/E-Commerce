import 'package:amazon_seller/const/const.dart';
import 'package:amazon_seller/controller/products_controller.dart';
import 'package:amazon_seller/screens/products/add_new_product.dart';
import 'package:amazon_seller/screens/products/product_details.dart';
import 'package:amazon_seller/services/store_services.dart';
import 'package:amazon_seller/widgets/appbar.dart';
import 'package:amazon_seller/widgets/loading_indicator.dart';
import 'package:amazon_seller/widgets/text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductController());

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await controller.getCategories();
            controller.populateCategoryList();
            Get.to(() => AddNewProduct());
          },
          backgroundColor: purpleColor,
          child: const Icon(
            Icons.add,
            color: white,
          ),
        ),
        appBar: customAppBar(title: product),
        body: StreamBuilder(
            stream: StoreServices.getProducts(uid: currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return loadingIndicator();
              } else {
                var data = snapshot.data!.docs;
                return Padding(
                  padding: const EdgeInsets.all(8),
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: List.generate(
                          data.length,
                          (index) => Card(
                                child: ListTile(
                                  trailing: VxPopupMenu(
                                      arrowSize: 0.0,
                                      menuBuilder: () => Column(
                                            children: List.generate(
                                                popUpMenuIcons.length,
                                                (i) => Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              12.0),
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                              popUpMenuIcons[i],
                                                              color: data[index]
                                                                              [
                                                                              'featured_id'] ==
                                                                          currentUser!
                                                                              .uid &&
                                                                      i == 0
                                                                  ? green
                                                                  : darkGrey),
                                                          10.widthBox,
                                                          normalText(
                                                              text: data[index][
                                                                              'featured_id'] ==
                                                                          currentUser!
                                                                              .uid &&
                                                                      i == 0
                                                                  ? "Remove Featured"
                                                                  : popUpMenuTitles[
                                                                      i],
                                                              color: darkGrey),
                                                        ],
                                                      ).onTap(() {
                                                        switch (i) {
                                                          case 0:
                                                            if (data[index][
                                                                    'is_featured'] ==
                                                                true) {
                                                              controller
                                                                  .removeFeatured(
                                                                      data[index]
                                                                          .id);
                                                            } else {
                                                              controller
                                                                  .addFeatured(
                                                                      data[index]
                                                                          .id);
                                                            }
                                                            break;
                                                          case 1:
                                                            break;
                                                          case 2:
                                                            controller
                                                                .removeProduct(
                                                                    data[index]
                                                                        .id);
                                                            break;

                                                          default:
                                                        }
                                                      }),
                                                    )),
                                          )
                                              .box
                                              .color(white)
                                              .rounded
                                              .width(200)
                                              .make(),
                                      clickType: VxClickType.singleClick,
                                      child:
                                          const Icon(Icons.more_vert_rounded)),
                                  onTap: () {
                                    Get.to(ProductDetails(
                                      data: data[index],
                                    ));
                                  },
                                  leading: Image.network(
                                    "${data[index]['p_images'][0]}",
                                    width: 100,
                                    height: 100,
                                    // fit: BoxFit.cover,
                                  ),
                                  title: boldText(
                                      text: "${data[index]['p_name']}",
                                      color: fontGrey,
                                      size: 14.0),
                                  subtitle: Row(
                                    children: [
                                      normalText(
                                          text:
                                              "₹${"${data[index]['p_price']}".numCurrency}",
                                          color: darkGrey),
                                      10.widthBox,
                                      normalText(
                                          text: data[index]['is_featured']
                                              ? "Featured"
                                              : "Not Featured",
                                          color: data[index]['is_featured']
                                              ? green
                                              : red)
                                    ],
                                  ),
                                ),
                              )),
                    ),
                  ),
                );
              }
            }));
  }
}
