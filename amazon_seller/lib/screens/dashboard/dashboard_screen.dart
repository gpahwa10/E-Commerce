import 'package:amazon_seller/const/const.dart';
import 'package:amazon_seller/screens/products/product_details.dart';
import 'package:amazon_seller/services/store_services.dart';
import 'package:amazon_seller/widgets/appbar.dart';
import 'package:amazon_seller/widgets/dashboard_button.dart';
import 'package:amazon_seller/widgets/loading_indicator.dart';
import 'package:amazon_seller/widgets/text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: customAppBar(title: dashboard),
        body: StreamBuilder(
            stream: StoreServices.getProducts(uid: currentUser!.uid),
            builder:
                ((BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return loadingIndicator();
              } else {
                var data = snapshot.data!.docs;
                data = data.sortedBy((a, b) =>
                    b['p_wishlist'].length.compareTo(a['p_wishlist'].length));
                return Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          dashboardScreenButton(context,
                              title: product, count: 75, icon: imgProducts),
                          dashboardScreenButton(context,
                              title: orders, count: 15, icon: imgOrders)
                        ],
                      ),
                      10.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          dashboardScreenButton(context,
                              title: ratings, count: 60, icon: imgStar),
                          dashboardScreenButton(context,
                              title: totalSales, count: 15, icon: imgAccount)
                        ],
                      ),
                      10.heightBox,
                      const Divider(),
                      10.heightBox,
                      boldText(text: popular, color: darkGrey, size: 16.0),
                      20.heightBox,
                      ListView(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        children: List.generate(
                            data.length,
                            (index) => data[index]['p_wishlist'].length==0 ? SizedBox(): ListTile(
                                  onTap: () {
                                    Get.to(() => ProductDetails(
                                          data: data[index],
                                        ));
                                  },
                                  leading: Image.network(
                                    data[index]['p_images'][0],
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  title: boldText(
                                      text: "${data[index]['p_name']}",
                                      color: fontGrey,
                                      size: 14.0),
                                  subtitle: normalText(
                                      text:
                                          "₹${"${data[index]['p_price']}".numCurrency}",
                                      color: darkGrey),
                                )),
                      )
                    ],
                  ),
                );
              }
            })));
  }
}
