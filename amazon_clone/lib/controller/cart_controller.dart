import 'package:amazon_clone/consts/consts.dart';
import 'package:amazon_clone/controller/home_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var totalP = 0.obs;
  //text controllers fpr shipping details
  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var postalCodeController = TextEditingController();
  var phoneController = TextEditingController();
  var orderCodeController = TextEditingController();
  var paymentIndex = 0.obs;

  var placingOrder = false.obs;

  late dynamic productSnapshot;
  var products = [];
  var vendors =[];
  calculate(data) {
    totalP.value = 0;
    for (var i = 0; i < data.length; i++) {
      totalP.value = totalP.value + int.parse(data[i]['tPrice'].toString());
    }
  }

  changePaymentIndex(index) {
    paymentIndex.value = index;
  }

  palceMyOrder({required orderPaymentMethod, totalAmount}) async {
    placingOrder(true);
    await getProductDeails();
    await firestore.collection(orderCollection).doc().set({
      'order_by': currentUser!.uid,
      'order_by_name': Get.find<HomeController>().username,
      'order_by_email': currentUser!.email,
      'order_by_address': addressController.text,
      'order_by-city': cityController.text,
      'order_by-state': stateController.text,
      'order_by-postalCode': postalCodeController.text,
      'order_by-phone': phoneController.text,
      'shipping_Menthod': "Home Delivery",
      'payment_Method': orderPaymentMethod,
      'order_placed': true,
      'order_code': "26182762837",
      'order_date': '31/07/24',
      'order_confirmed': false,
      'order_delivered': false,
      'order_ondelivery': false,
      'total_amount': totalAmount,
      'orders': FieldValue.arrayUnion(products),
      'vendors':FieldValue.arrayUnion(vendors)
    });
    placingOrder(false);
  }

  getProductDeails() {
    products.clear();
    vendors.clear();
    for (var i = 0; i < productSnapshot.length; i++) {
      products.add({
        'color': productSnapshot[i]['color'],
        'image': productSnapshot[i]['image'],
        'qty': productSnapshot[i]['qty'],
        'title': productSnapshot[i]['title'],
        'vendor_id': productSnapshot[i]['vendor_id'],
        'tPrice': productSnapshot[i]['tPrice']
      });
      vendors.add(productSnapshot[i]['vendor_id']);
    }
  }

  clearCart() {
    for (var i = 0; i < productSnapshot.length; i++) {
      firestore.collection(cartCollection).doc(productSnapshot[i].id).delete();
    }
  }
}
