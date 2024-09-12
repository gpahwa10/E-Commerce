import 'package:amazon_seller/const/const.dart';

class StoreServices {
  static getProfile({uid}) {
    return firestore
        .collection(vendorsCollection)
        .where('id', isEqualTo: uid)
        .get();
  }

  static getMessages({uid}) {
    return firestore
        .collection(chatCollection)
        .where('toID', isEqualTo: uid)
        .snapshots();
  }
  
  static getOrders({uid}){
    return firestore.collection(orderCollection).where('vendors',arrayContains: uid).snapshots();
  }
  static getProducts({uid}){
    return firestore.collection(productCollection).where('p_vendorID',isEqualTo: uid).snapshots();
  }

  // static popularProducts(uid){
  //   return firestore.collection(productCollection).where('[p_vendorID',isEqualTo: uid).orderBy('p_wishlist'.length);
  // }
}


