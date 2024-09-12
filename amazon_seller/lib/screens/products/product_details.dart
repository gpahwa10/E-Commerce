import 'package:amazon_seller/const/const.dart';
import 'package:amazon_seller/widgets/text_styles.dart';

class ProductDetails extends StatelessWidget {
  final dynamic data;
  const ProductDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: boldText(text: "${data['p_name']}", color: fontGrey, size: 16.0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VxSwiper.builder(
                  autoPlay: true,
                  height: 350,
                  aspectRatio: 16 / 9,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Image.network(data['p_images'][index],
                        width: double.infinity, fit: BoxFit.cover);
                  }),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    10.heightBox,
                    boldText(
                        text: "${data['p_name']}", color: fontGrey, size: 16.0),10.heightBox,
                    Row(
                      children: [
                        boldText(text: "${data['p_category']}",color: fontGrey,size: 16.0),10.widthBox,
                        normalText(text: "${data['p_subcategory']}",color: fontGrey,size: 16.0)
                      ],
                    ),
                    //Rating Section
                    10.heightBox,
                    VxRating(
                      onRatingUpdate: (value) {},
                      normalColor: textfieldGrey,
                      selectionColor: golden,
                      count: 5,
                      maxRating: 5,
                      value: 3,
                      size: 25,
                      stepInt: false,
                    ),
                    10.heightBox,
                    //Price
                    boldText(text: "₹${"${data['p_price']}".numCurrency}", color: red, size: 18.0),
                    20.heightBox,
                    Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: boldText(text: "Color", color: fontGrey),
                            ),
                            Row(
                              children: List.generate(
                                3,
                                (index) => VxBox()
                                    .size(40, 40)
                                    .roundedFull
                                    .color(Vx.randomColor.withOpacity(1.0))
                                    .margin(const EdgeInsets.symmetric(
                                        horizontal: 6))
                                    .make()
                                    .onTap(() {}),
                              ),
                            ),
                          ],
                        ),
                        10.heightBox,
                        //Quantity Section
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child:
                                  boldText(text: "Quantity", color: fontGrey),
                            ),
                            normalText(text: "${data['p_quantity']} Items", color: fontGrey)
                          ],
                        ),
                        Divider(),
                        20.heightBox,

                        boldText(text: "Description", color: darkGrey),
                        10.heightBox,
                        normalText(
                            text: "${data['p_description']}", color: fontGrey)
                      ],
                    ),
                  ],
                ).box.padding(EdgeInsets.all(8.0)).make(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
