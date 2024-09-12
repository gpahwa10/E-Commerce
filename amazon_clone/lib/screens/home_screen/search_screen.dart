import 'package:amazon_clone/common_widgets/loading_indicator.dart';
import 'package:amazon_clone/consts/consts.dart';
import 'package:amazon_clone/screens/categories_screen/product_details.dart';
import 'package:amazon_clone/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  final String? title;

  const SearchScreen({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: title?.text.color(darkFontGrey).make(),
        ),
        body: FutureBuilder(
            future: FirestoreServices.searchProduts(title),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return loadingIndicator();
              } else if (snapshot.data!.docs.isEmpty) {
                return "No such product found".text.makeCentered();
              } else {
                var data = snapshot.data!.docs;
                // var filterData= data.where('p_name', isLessThanOrEqualTo: title);
                var filterData = data.where((element) => element['p_name']
                    .toString()
                    .toLowerCase()
                    .contains(title!.toLowerCase())).toList();
                return GridView(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            mainAxisExtent: 300),
                    children: filterData
                        .mapIndexed((currentValue, index) => Column(
                              children: [
                                Image.network(
                                  filterData[index]['p_images'][0],
                                  width: 200,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                                const Spacer(),
                                "${filterData[index]['p_name']}"
                                    .text
                                    .color(darkFontGrey)
                                    .fontFamily(semibold)
                                    .make(),
                                const Spacer(),
                                "${filterData[index]['p_price']}"
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
                                .outerShadowMd
                                .margin(
                                    const EdgeInsets.symmetric(horizontal: 4))
                                .padding(const EdgeInsets.all(8))
                                .roundedSM
                                .make()
                                .onTap(() {
                              Get.to(ProductDetails(
                                  title: "${filterData[index]['p_name']}",
                                  data: filterData[index]));
                            }))
                        .toList());
              }
            }));
  }
}
