import 'package:amazon_clone/common_widgets/home_buttons.dart';
import 'package:amazon_clone/common_widgets/loading_indicator.dart';
import 'package:amazon_clone/consts/consts.dart';
import 'package:amazon_clone/consts/lists.dart';
import 'package:amazon_clone/controller/home_controller.dart';
import 'package:amazon_clone/controller/product_controller.dart';
import 'package:amazon_clone/screens/categories_screen/product_details.dart';
import 'package:amazon_clone/screens/home_screen/search_screen.dart';
// import 'package:amazon_clone/screens/home_screen/components/featured_button.dart';
import 'package:amazon_clone/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var controller = Get.put(ProductController());
    var controllerS = Get.find<HomeController>();
    return Container(
      color: lightGrey,
      width: context.screenWidth,
      height: context.screenHeight,
      padding: const EdgeInsets.all(12),
      child: SafeArea(
        child: Column(
          children: [
            //search bar
            Container(
              alignment: Alignment.center,
              height: 60,
              child: TextFormField(
                controller: controllerS.searchController,
                decoration: InputDecoration(
                    border: InputBorder.none,
                    suffixIcon: const Icon(Icons.search).onTap(() {
                      if (controllerS
                          .searchController.text.isNotEmptyAndNotNull) {
                        Get.to(SearchScreen(
                          title: controllerS.searchController.text,
                        ));
                      }
                    }),
                    filled: true,
                    fillColor: whiteColor,
                    hintText: searchTab,
                    hintStyle: const TextStyle(color: textfieldGrey)),
              ).box.outerShadowSm.make(),
            ),
            10.heightBox,
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    //swiper1
                    VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: sliderList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Image.asset(
                          sliderList[index],
                          fit: BoxFit.fill,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .make();
                      },
                    ),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                        2,
                        (index) => homebuttons(
                          context.screenWidth / 2.5,
                          context.screenHeight * 0.15,
                          index == 0 ? icTodaysDeal : icFlashDeal,
                          index == 0 ? todayDeal : flashSale,
                        ),
                      ),
                    ),
                    10.heightBox,
                    VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: sliderList2.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Image.asset(
                          sliderList2[index],
                          fit: BoxFit.fill,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .make();
                      },
                    ),
                    10.heightBox,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: List.generate(
                          3,
                          (index) => homebuttons(
                                context.screenWidth / 3.5,
                                context.screenHeight * 0.15,
                                index == 0
                                    ? icTopCategories
                                    : index == 1
                                        ? icBrands
                                        : icTopSeller,
                                index == 0
                                    ? topCategories
                                    : index == 1
                                        ? brand
                                        : topSeller,
                              )),
                    ),
                    // 20.heightBox,
                    // Align(
                    //     alignment: Alignment.centerLeft,
                    //     child: featuredCategories.text
                    //         .size(20)
                    //         .color(darkFontGrey)
                    //         .fontFamily(semibold)
                    //         .make()),
                    // 20.heightBox,
                    // SingleChildScrollView(
                    //   scrollDirection: Axis.horizontal,
                    //   child: Row(
                    //       children: List.generate(
                    //           3,
                    //           (index) => Column(
                    //                 children: [
                    //                   featuredButton(featuredList1[index],
                    //                       featuredTitle1[index]),
                    //                   10.heightBox,
                    //                   featuredButton(featuredList2[index],
                    //                       featuredTitle2[index]),
                    //                 ],
                    //               )).toList()),
                    // ),

                    //Featured Products
                    20.heightBox,
                    Container(
                      padding: const EdgeInsets.all(12),
                      width: double.infinity,
                      decoration: const BoxDecoration(color: redColor),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          featuredProduct.text.white
                              .fontFamily(semibold)
                              .size(18)
                              .make(),
                          10.heightBox,
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: FutureBuilder(
                                future: FirestoreServices.getFeaturedProducts(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData) {
                                    return loadingIndicator();
                                  } else if (snapshot.data!.docs.isEmpty) {
                                    return Center(
                                      child: "No Featured Products yet!"
                                          .text
                                          .color(whiteColor)
                                          .makeCentered(),
                                    );
                                  } else {
                                    var featuredData = snapshot.data!.docs;
                                    return Row(
                                      children: List.generate(
                                          featuredData.length,
                                          (index) => Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Image.network(
                                                    featuredData[index]
                                                        ['p_images'][0],
                                                    width: 130,
                                                    height: 130,
                                                    fit: BoxFit.cover,
                                                  ),
                                                  10.heightBox,
                                                  "${featuredData[index]['p_name']}"
                                                      .text
                                                      .color(darkFontGrey)
                                                      .fontFamily(semibold)
                                                      .make(),
                                                  10.heightBox,
                                                  "${featuredData[index]['p_price']}"
                                                      .numCurrency
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
                                                  .margin(const EdgeInsets
                                                      .symmetric(horizontal: 4))
                                                  .padding(
                                                      const EdgeInsets.all(8))
                                                  .make()
                                                  .onTap(() {
                                                Get.to(ProductDetails(
                                                    title:
                                                        "${featuredData[index]['p_name']}",
                                                    data: featuredData[index]));
                                              })),
                                    );
                                  }
                                }),
                          ),
                        ],
                      ),
                    ),
                    20.heightBox,
                    //swiper 3
                    VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: sliderList2.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Image.asset(
                          sliderList2[index],
                          fit: BoxFit.fill,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .make();
                      },
                    ),
                    //all products section
                    20.heightBox,
                    Align(
                      alignment: Alignment.centerLeft,
                      child: "All Products"
                          .text
                          .fontFamily(bold)
                          .size(18)
                          .color(darkFontGrey)
                          .make(),
                    ),
                    20.heightBox,
                    StreamBuilder(
                        stream: FirestoreServices.allProducts(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return loadingIndicator();
                          } else {
                            var allProductData = snapshot.data!.docs;
                            return GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: allProductData.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        crossAxisSpacing: 8,
                                        mainAxisSpacing: 8,
                                        mainAxisExtent: 300),
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Image.network(
                                        allProductData[index]['p_images'][0],
                                        width: 200,
                                        height: 200,
                                        fit: BoxFit.cover,
                                      ),
                                      const Spacer(),
                                      "${allProductData[index]['p_name']}"
                                          .text
                                          .color(darkFontGrey)
                                          .fontFamily(semibold)
                                          .make(),
                                      const Spacer(),
                                      "${allProductData[index]['p_price']}"
                                          .numCurrency
                                          .text
                                          .size(16)
                                          .fontFamily(bold)
                                          .color(Colors.black)
                                          .make()
                                    ],
                                  )
                                      .box
                                      .white
                                      .margin(const EdgeInsets.symmetric(
                                          horizontal: 4))
                                      .padding(const EdgeInsets.all(8))
                                      .roundedSM
                                      .make()
                                      .onTap(() {
                                    Get.to(ProductDetails(
                                        title:
                                            "${allProductData[index]['p_name']}",
                                        data: allProductData[index]));
                                  });
                                });
                          }
                        })
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
