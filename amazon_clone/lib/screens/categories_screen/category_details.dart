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
  var controller = Get.find<ProductController>();
  dynamic productMethod;
  String? selectedSubcat;

  @override
  void initState() {
    super.initState();
    switchCategory(widget.title);
    selectedSubcat = null;
  }

  switchCategory(title) {
    if (controller.subcat.contains(title)) {
      productMethod = FirestoreServices.getSubCategoryProduct(title);
      selectedSubcat = title;
    } else {
      productMethod = FirestoreServices.getProducts(title);
      selectedSubcat = null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(
        elevation: 0,
        title: widget.title!.text.black.fontFamily(bold).size(18).make(),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Subcategories
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                "Subcategories".text.size(16).fontFamily(semibold).color(darkFontGrey).make()
                    .box.padding(const EdgeInsets.only(left: 16, bottom: 8)).make(),
                SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: [
                      10.widthBox,
                      ...List.generate(
                        controller.subcat.length,
                            (index) {
                          bool isSelected = selectedSubcat == controller.subcat[index];
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.only(right: 10, bottom: 5),
                            decoration: BoxDecoration(
                              color: isSelected ? redColor : Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                )
                              ],
                            ),
                            child: "${controller.subcat[index]}"
                                .text
                                .size(12)
                                .fontFamily(semibold)
                                .color(isSelected ? Colors.white : darkFontGrey)
                                .makeCentered()
                                .box
                                .padding(const EdgeInsets.symmetric(horizontal: 15))
                                .size(110, 45)
                                .make(),
                          ).onTap(() {
                            switchCategory("${controller.subcat[index]}");
                            setState(() {});
                          });
                        },
                      ),
                      10.widthBox,
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Product grid
          10.heightBox,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                "Products".text.size(16).fontFamily(semibold).color(darkFontGrey).make(),
                const Spacer(),
                StreamBuilder(
                  stream: productMethod,
                  builder: ((context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return "${snapshot.data!.docs.length} items"
                          .text
                          .size(14)
                          .color(darkFontGrey.withOpacity(0.7))
                          .make();
                    } else {
                      return "".text.make();
                    }
                  }),
                )
              ],
            ),
          ),
          15.heightBox,

          StreamBuilder(
            stream: productMethod,
            builder: ((BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        loadingIndicator(),
                        10.heightBox,
                        "Loading products...".text.color(darkFontGrey).make(),
                      ],
                    ),
                  ),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.search_off_rounded, size: 60, color: redColor),
                      20.heightBox,
                      "No Products Found."
                          .text
                          .size(16)
                          .color(darkFontGrey)
                          .fontFamily(semibold)
                          .makeCentered(),
                      10.heightBox,
                      "Try selecting a different category".text.color(darkFontGrey).make(),
                    ],
                  ),
                );
              } else {
                var data = snapshot.data!.docs;

                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      itemCount: data.length,
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 12,
                        crossAxisSpacing: 12,
                        mainAxisExtent: 280,
                      ),
                      itemBuilder: (context, index) {
                        return Hero(
                          tag: data[index].id,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                )
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Product image
                                ClipRRect(
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    topRight: Radius.circular(10),
                                  ),
                                  child: Image.network(
                                    data[index]["p_images"][0],
                                    width: double.infinity,
                                    height: 170,
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
                                      ).box.size(170, 170).make();
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Center(
                                        child: Icon(
                                          Icons.image_not_supported_outlined,
                                          size: 50,
                                          color: Colors.grey,
                                        ),
                                      ).box.size(170, 170).make();
                                    },
                                  ),
                                ),

                                // Product details
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      "${data[index]['p_name']}"
                                          .text
                                          .color(darkFontGrey)
                                          .fontFamily(semibold)
                                          .size(14)
                                          .maxLines(1)
                                          .overflow(TextOverflow.ellipsis)
                                          .make(),
                                      5.heightBox,
                                      "${data[index]["p_actual_price"]}"
                                          .text
                                          .size(16)
                                          .fontFamily(bold)
                                          .color(redColor)
                                          .make(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ).onTap(() {
                            controller.checkIfFav(data[index]);
                            Get.to(
                                  () => ProductDetails(
                                data: data[index],
                                title: "${data[index]["p_name"]}",
                              ),
                              transition: Transition.rightToLeft,
                              duration: const Duration(milliseconds: 300),
                            );
                          }),
                        );
                      },
                    ),
                  ),
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}