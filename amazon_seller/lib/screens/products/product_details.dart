import 'package:amazon_seller/const/const.dart';
import 'package:amazon_seller/widgets/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductDetails extends StatelessWidget {
  final dynamic data;

  const ProductDetails({Key? key, required this.data}) : super(key: key);@override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGrey,
      appBar: AppBar(
        title: boldText(text: "${data['p_name']}", color: fontGrey, size: 16.0),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image Carousel
            VxSwiper.builder(
              autoPlay: true,
              height: 350,
              aspectRatio: 16 / 9,
              enlargeCenterPage: true,
              itemCount: data['p_images'].length,
              itemBuilder: (context, index) {
                return Image.network(
                  data['p_images'][index],
                  width: double.infinity,
                  fit: BoxFit.cover,
                ).box.rounded.clip(Clip.antiAlias).make();
              },
            ),

            // Product Details Section
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.heightBox,
                  // Product Name
                  boldText(
                      text: "${data['p_name']}", color: fontGrey, size: 20.0),
                  10.heightBox,
                  // Category and Subcategory
                  Row(
                    children: [
                      boldText(
                          text: "${data['p_category']}",
                          color: fontGrey,
                          size: 16.0),
                      10.widthBox,
                      normalText(
                          text:"${data['p_subcategory']}",
                          color: fontGrey,
                          size: 16.0),
                    ],
                  ),
                  10.heightBox,
                  // Rating Section
                  VxRating(
                    onRatingUpdate: (value) {},
                    normalColor: textfieldGrey,
                    selectionColor: golden,
                    count: 5,
                    maxRating: 5,
                    value: double.parse(data['p_rating']),
                    size: 25,
                    stepInt: false,
                  ),
                  10.heightBox,
                  // Price
                  Row(
                    children: [
                      boldText(
                          text:
                          "₹${"${data['p_actual_price']}"}",
                          color: red,
                          size: 22.0),
                      10.widthBox,
                      normalText(
                          text:
                          "Base Price: ₹${"${data['p_base_price']}"}",
                          color: darkGrey,
                          size: 16.0),
                    ],
                  ),
                  20.heightBox,
                  // Color Section
                  if (data['p_colors'] != null && data['p_colors'].isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        boldText(text: "Colors", color: fontGrey),
                        10.heightBox,
                        Wrap(
                          spacing: 8.0,
                          children: List.generate(
                            data['p_colors'].length,
                                (index) => VxBox()
                                .size(40, 40)
                                .roundedFull
                                .color(Color(data['p_colors'][index]))
                                .make(),
                          ),
                        ),
                        20.heightBox,
                      ],
                    ),
                  // Quantity Section
                  Row(
                    children: [
                      SizedBox(
                        width: 100,
                        child: boldText(text: "Quantity", color: fontGrey),
                      ),
                      normalText(
                          text: "${data['p_quantity']} Items",
                          color: fontGrey),
                    ],
                  ),
                  20.heightBox,
                  // Attributes Section
                  if (data['p_attributes'] != null &&
                      data['p_attributes'].isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        boldText(text: "Attributes", color: fontGrey),
                        10.heightBox,
                        ...List.generate(
                          data['p_attributes'].length,
                              (index) => Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: normalText(
                                    text: data['p_attributes'][index]['name'],
                                    color: fontGrey),
                              ),
                              normalText(
                                  text: data['p_attributes'][index]['value'],
                                  color: fontGrey),
                            ],
                          ),
                        ),
                        20.heightBox,
                      ],
                    ),
                  // Description Section
                  boldText(text: "Description", color: darkGrey),
                  10.heightBox,
                  normalText(text: "${data['p_description']}", color: fontGrey),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}