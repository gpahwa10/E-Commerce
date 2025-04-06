import 'package:amazon_clone/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../services/firestore_service.dart';

class CartItemTile extends StatefulWidget {
  final int qty;
  final String id;
  final String title;
  final String image;
  final int tPrice;
  const CartItemTile({super.key, required this.qty, required this.id, required this.title, required this.image, required this.tPrice});

  @override
  State<CartItemTile> createState() => _CartItemTileState();
}

class _CartItemTileState extends State<CartItemTile> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      padding: EdgeInsets.all(12.h),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withOpacity(0.08),
            blurRadius: 8.r,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Product Image
          Hero(
            tag: 'product-${widget.id}',
            child: Container(
              height: 80.h,
              width: 80.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                color: colorScheme.surfaceVariant,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.network(
                  widget.image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(width: 16.w),

          // Product Info and Controls
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 16.sp,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 12.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Price
                    Text(
                      "₹${widget.tPrice}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                        color: colorScheme.primary,
                      ),
                    ),

                    // Quantity Controls
                    Container(
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceVariant,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () {
                              // Decrease quantity function
                              // if (data[index]['qty'] > 1) {
                              //   // FirestoreServices.updateQuantity(
                              //   //     data[index].id,
                              //   //     data[index]['qty'] - 1
                              //   // );
                              // }
                            },
                            child: Container(
                              padding: EdgeInsets.all(8.r),
                              child: Icon(
                                Icons.remove,
                                size: 16.sp,
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                          Container(
                            constraints: BoxConstraints(minWidth: 32.w),
                            padding: EdgeInsets.symmetric(horizontal: 4.w),
                            alignment: Alignment.center,
                            child: Text(
                              widget.qty.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.sp,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              // Increase quantity function
                              // FirestoreServices.updateQuantity(
                              //     data[index].id,
                              //     data[index]['qty'] + 1
                              // );
                            },
                            child: Container(
                              padding: EdgeInsets.all(8.r),
                              child: Icon(
                                Icons.add,
                                size: 16.sp,
                                color: colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Delete Button
          InkWell(
            onTap: () {
              // Show confirmation dialog
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text("Remove Item?"),
                  content: Text("Are you sure you want to remove this item from your cart?"),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("CANCEL"),
                    ),
                    FilledButton(
                      onPressed: () {
                        FirestoreServices.deleteDoc(widget.id);
                        Navigator.pop(context);
                      },
                      child: Text("REMOVE"),
                    ),
                  ],
                ),
              );
            },
            borderRadius: BorderRadius.circular(20.r),
            child: Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorScheme.surfaceVariant,
              ),
              child: Icon(
                Icons.delete_outline,
                color: colorScheme.error,
                size: 22.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
