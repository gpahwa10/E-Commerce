import 'package:amazon_clone/common_widgets/bg_widget.dart';
import 'package:amazon_clone/common_widgets/loading_indicator.dart';
import 'package:amazon_clone/consts/consts.dart';
import 'package:amazon_clone/controller/product_controller.dart';
import 'package:amazon_clone/screens/categories_screen/product_details.dart';
import 'package:amazon_clone/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CategoryDetails extends StatefulWidget {
  final String? title;
  const CategoryDetails({super.key, required this.title});

  @override
  State<CategoryDetails> createState() => _CategoryDetailsState();
}

class _CategoryDetailsState extends State<CategoryDetails> {
  @override
  void initState() {
    super.initState();
    swithcCategory(widget.title);
  }

  swithcCategory(title) {
    if (controller.subcat.contains(title)) {
      productMethod = FirestoreServices.getSubCategoryProduct(title);
    } else {
      productMethod = FirestoreServices.getProducts(title);
    }
  }

  var controller = Get.find<ProductController>();

  dynamic productMethod;
  @override
  Widget build(BuildContext context) {
    return bgWidget(
      Scaffold(
        appBar: AppBar(
          title: widget.title!.text.white.fontFamily(bold).make(),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: List.generate(
                    controller.subcat.length,
                    (index) => "${controller.subcat[index]}"
                            .text
                            .size(12)
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .makeCentered()
                            .box
                            .margin(const EdgeInsets.symmetric(horizontal: 4))
                            .rounded
                            .white
                            .size(110, 50)
                            .make()
                            .onTap(() {
                          swithcCategory("${controller.subcat[index]}");
                          setState(() {});
                        })),
              ),
            ),
            10.heightBox,
            StreamBuilder(
              stream: productMethod,
              builder: ((BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Expanded(child: Center(child: loadingIndicator()));
                } else if (snapshot.data!.docs.isEmpty) {
                  return Expanded(
                      child: "No Products Found."
                          .text
                          .color(darkFontGrey)
                          .makeCentered());
                } else {
                  var data = snapshot.data!.docs;

                  return Expanded(
                      child: GridView.builder(
                          physics: const BouncingScrollPhysics(),
                          itemCount: data.length,
                          shrinkWrap: true,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 8,
                                  crossAxisSpacing: 8,
                                  mainAxisExtent: 300),
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.network(
                                  data[index]["p_images"][0],
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ).box.roundedSM.clip(Clip.antiAlias).make(),
                                const Spacer(),
                                "${data[index]['p_name']}"
                                    .text
                                    .color(darkFontGrey)
                                    .fontFamily(semibold)
                                    .make(),
                                const Spacer(),
                                "${data[index]["p_price"]}"
                                    .numCurrencyWithLocale(locale: "en_IN")
                                    .text
                                    .size(16)
                                    .fontFamily(bold)
                                    .color(Colors.black)
                                    .make()
                              ],
                            )
                                .box
                                .white
                                .margin(
                                    const EdgeInsets.symmetric(horizontal: 4))
                                .padding(const EdgeInsets.all(8))
                                .roundedSM
                                .outerShadowSm
                                .make()
                                .onTap(() {
                              controller.checkIfFav(data[index]);
                              Get.to(() => ProductDetails(
                                  data: data[index],
                                  title: "${data[index]["p_name"]}"));
                            });
                          }));
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}

// SingleChildScrollView(
                        //   scrollDirection: Axis.horizontal,
                        //   physics: const BouncingScrollPhysics(),
                        //   child: Row(
                        //     children: List.generate(
                        //         controller.subcat.length,
                        //         (index) => "${controller.subcat[index]}"
                        //             .text
                        //             .size(12)
                        //             .fontFamily(semibold)
                        //             .color(darkFontGrey)
                        //             .makeCentered()
                        //             .box
                        //             .margin(
                        //                 const EdgeInsets.symmetric(horizontal: 4))
                        //             .rounded
                        //             .white
                        //             .size(110, 50)
                        //             .make()),
                        //   ),
                        // ),