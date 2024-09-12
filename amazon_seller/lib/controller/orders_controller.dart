import 'package:amazon_seller/const/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrdersController extends GetxController {
  var orders = [];
  var confirmed = false.obs;
  var outForDelivery = false.obs;
  var delivered = false.obs;
  var shipped = false.obs;
  getOrders(data) {
    orders.clear();
    for (var item in data['orders']) {
      if (item['vendor_id'] == currentUser!.uid) {
        orders.add(item);
      }
    }
  }

  changeStatus({title, status, docID}) async {
    var store = firestore.collection(orderCollection).doc(docID);
    await store.set({title: status}, SetOptions(merge: true));
  }
}
