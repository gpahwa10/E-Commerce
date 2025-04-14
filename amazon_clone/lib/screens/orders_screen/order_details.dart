import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:amazon_clone/consts/consts.dart';
import 'package:amazon_clone/screens/orders_screen/components/order_place_details.dart';
import 'package:amazon_clone/screens/orders_screen/components/order_status.dart';

class OrderDetails extends StatelessWidget {
  final dynamic data;
  const OrderDetails({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    // Parse order_date with robust handling
    DateTime orderDate;
    try {
      if (data['order_date'] is String && data['order_date'].isNotEmpty) {
        final possibleFormats = [
          'yyyy-MM-dd', // e.g., 2025-04-13
          'MM/dd/yyyy', // e.g., 04/13/2025
          'dd-MM-yyyy', // e.g., 13-04-2025
          'yyyy-MM-dd HH:mm:ss', // e.g., 2025-04-13 12:00:00
          'yyyy-MM-ddTHH:mm:ssZ', // e.g., 2025-04-13T12:00:00Z
        ];

        DateTime? parsedDate;
        for (var format in possibleFormats) {
          try {
            parsedDate = DateFormat(format).parse(data['order_date']);
            break;
          } catch (_) {
            continue;
          }
        }
        orderDate = parsedDate ?? DateTime.now();
      } else if (data['order_date'] is Timestamp) {
        orderDate = (data['order_date'] as Timestamp).toDate();
      } else {
        orderDate = DateTime.now();
      }
    } catch (e) {
      debugPrint("Error parsing order_date: $e");
      orderDate = DateTime.now();
    }

    // Calculate order summary values
    final orderItems = data['orders'] as List<dynamic>? ?? [];
    double subtotal = 0;
    for (var item in orderItems) {
      subtotal += (item['tPrice'] ?? 0) * (item['qty'] ?? 1);
    }

    // Assume tax is 10% of subtotal
    double tax = subtotal * 0.1;

    // Get discount if available, otherwise 0
    double discount = 0;

    // Formatted currency values
    String subtotalStr = subtotal.toStringAsFixed(2);
    String taxStr = tax.toStringAsFixed(2);
    String discountStr = discount.toStringAsFixed(2);

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: Text(
          "Order Details",
          style: TextStyle(
            color: darkFontGrey,
            fontFamily: semibold,
            fontSize: 20.sp,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            orderStatus(
              color: redColor,
              title: "Placed",
              icon: Icons.done,
              showDone: data['order_placed'] ?? false,
            ),
            orderStatus(
              color: Colors.blue[900]!,
              title: "Confirmed",
              icon: Icons.thumb_up_alt,
              showDone: data['order_confirmed'] ?? false,
            ),
            orderStatus(
              color: Colors.yellow[800]!,
              title: "Delivery",
              icon: Icons.delivery_dining,
              showDone: data['order_ondelivery'] ?? false,
            ),
            orderStatus(
              color: Colors.green[700]!,
              title: "Delivered",
              icon: Icons.done_all_rounded,
              showDone: data['order_delivered'] ?? false,
            ),
            const Divider(),
            SizedBox(height: 10.h),
            Column(
              children: [
                orderPlacedDetails(
                  data,
                  title1: "Order Code",
                  title2: "Shipping Method",
                  titleDetails1: data['order_code'] ?? 'N/A',
                  // Fixed typo in shipping_Menthod
                  titleDetails2: data['shipping_Menthod'] ?? 'N/A',
                ),
                orderPlacedDetails(
                  data,
                  title1: "Order Date",
                  title2: "Payment Method",
                  titleDetails1: DateFormat.yMd().format(orderDate),
                  titleDetails2: data['payment_Method'] ?? 'N/A',
                ),
                orderPlacedDetails(
                  data,
                  title1: "Payment Status",
                  title2: "Delivery Status",
                  titleDetails1: "Unpaid",
                  titleDetails2: getDeliveryStatus(),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Shipping Address",
                            style: TextStyle(
                              fontFamily: semibold,
                              fontSize: 16.sp,
                              color: darkFontGrey,
                            ),
                          ),
                          Text(
                            "Name: ${data['order_by_name'] ?? 'N/A'}",
                            style: TextStyle(fontSize: 14.sp),
                          ),
                          Text(
                            "Email: ${data['order_by_email'] ?? 'N/A'}",
                            style: TextStyle(fontSize: 14.sp),
                          ),
                          Text(
                            "Address: ${data['order_by_address'] ?? 'N/A'}",
                            style: TextStyle(fontSize: 14.sp),
                          ),
                          // Fixed hyphens to underscores for consistency
                          Text(
                            "City: ${data['order_by-city'] ?? data['order_by-city'] ?? 'N/A'}",
                            style: TextStyle(fontSize: 14.sp),
                          ),
                          Text(
                            "State: ${data['order_by-state'] ?? data['order_by-state'] ?? 'N/A'}",
                            style: TextStyle(fontSize: 14.sp),
                          ),
                          Text(
                            "Phone: ${data['order_by-phone'] ?? data['order_by-phone'] ?? 'N/A'}",
                            style: TextStyle(fontSize: 14.sp),
                          ),
                          Text(
                            "Postal Code: ${data['order_by-postalCode'] ?? data['order_by-postalCode'] ?? 'N/A'}",
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
                Container(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal:10.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Total Amount",
                            style: TextStyle(
                              fontFamily: semibold,
                              fontSize: 16.sp,
                              color: darkFontGrey,
                            ),
                          ),
                          Text(
                            "${data['total_amount'] ?? '0'}",
                            style: TextStyle(
                              color: redColor,
                              fontFamily: bold,
                              fontSize: 16.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Divider(),
            SizedBox(height: 10.h),
            Text(
              "Ordered Products",
              style: TextStyle(
                fontSize: 16.sp,
                color: darkFontGrey,
                fontFamily: semibold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10.h),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: data['orders']?.length ?? 0,
              itemBuilder: (context, index) {
                final orderItem = data['orders']?[index];
                if (orderItem == null) {
                  return const SizedBox.shrink();
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    orderPlacedDetails(
                      orderItem,
                      title1: orderItem['title'] ?? 'N/A',
                      title2: (orderItem['tPrice'] ?? 0).toString(),
                      titleDetails1: '${orderItem['qty'] ?? 0}x',
                      titleDetails2: "Refundable",
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Container(
                        height: 20.h,
                        width: 30.w,
                        decoration: BoxDecoration(
                          color: orderItem['color'] != null
                              ? Color(orderItem['color'])
                              : Colors.grey,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: Colors.grey.shade300),
                        ),
                      ),
                    ),
                    const Divider(),
                  ],
                );
              },
            ),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.all(12.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Summary section title
                  Text(
                    "Order Summary",
                    style: TextStyle(
                      fontFamily: semibold,
                      fontSize: 16.sp,
                      color: darkFontGrey,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  // Replaced hardcoded "0" with calculated values
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Sub-Total:",
                        style: TextStyle(
                          fontFamily: semibold,
                          fontSize: 16.sp,
                          color: darkFontGrey,
                        ),
                      ),
                      Text(
                        subtotalStr,
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Tax:",
                        style: TextStyle(
                          fontFamily: semibold,
                          fontSize: 16.sp,
                          color: darkFontGrey,
                        ),
                      ),
                      Text(
                        taxStr,
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Discount:",
                        style: TextStyle(
                          fontFamily: semibold,
                          fontSize: 16.sp,
                          color: darkFontGrey,
                        ),
                      ),
                      Text(
                        discountStr,
                        style: TextStyle(fontSize: 16.sp),
                      ),
                    ],
                  ),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Grand Total:",
                        style: TextStyle(
                          fontFamily: bold,
                          fontSize: 16.sp,
                          color: darkFontGrey,
                        ),
                      ),
                      Text(
                        "${data['total_amount'] ?? '0'}",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontFamily: bold,
                          color: redColor,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  // Helper method to determine delivery status
  String getDeliveryStatus() {
    if (data['order_delivered'] == true) return "Delivered";
    if (data['order_ondelivery'] == true) return "On Delivery";
    if (data['order_confirmed'] == true) return "Confirmed";
    return "Order Placed";
  }
}