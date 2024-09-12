import 'package:amazon_clone/consts/consts.dart';
import 'package:amazon_clone/models/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var subcat = [];
  var colorIndex = 0.obs;
  var quantity = 0.obs;
  var totalPrice = 0.obs;
  var isFav = false.obs;

  getSubcategories(title) async {
    subcat.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decoded = categoriModelFromJson(data);
    var s =
        decoded.categories.where((element) => element.name == title).toList();

    for (var e in s[0].subcategory) {
      subcat.add(e);
    }
  }

  changeColorIndex(index) {
    colorIndex = index;
  }

  increaseQuantity(totalQuantity) {
    if (quantity.value < totalQuantity) {
      quantity.value++;
    }
  }

  decreaseQuantity() {
    if (quantity.value > 0) {
      quantity.value--;
    }
  }

  calculateTotalAmount(price) {
    totalPrice.value = price * quantity.value;
  }

  resetValues() {
    totalPrice.value = 0;
    quantity.value = 0;
    colorIndex.value = 0;
  }

  addToCart(
      {title, image, sellerName, color, qty, tPrice, context,vendorID}) async {
    try {
      await FirebaseFirestore.instance.collection(cartCollection).add({
        'title': title,
        'image': image,
        'sellerName': sellerName,
        'color': color,
        'vendor_id':vendorID,
        'qty': qty,
        'tPrice': tPrice,
        'added_by': currentUser!.uid
      });
      VxToast.show(context, msg: "Item Added to cart successfully!");
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  addToWishlist(docID,context) async {
    await firestore.collection(productCollection).doc(docID).set({
      'p_wishlist': FieldValue.arrayUnion([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(true);
    VxToast.show(context, msg: "Item added to wishlist!");

  }

  removeFromWishlist(docID,context) async {
    await firestore.collection(productCollection).doc(docID).set({
      'p_wishlist': FieldValue.arrayRemove([currentUser!.uid])
    }, SetOptions(merge: true));

    isFav(false);

    VxToast.show(context, msg: "Item removed from wishlist!");
  }

  checkIfFav(data) async {
    if (data['p_wishlist'].contains(currentUser!.uid)) {
      isFav(true);
    } else {
      isFav(false);
    }
  }
}
