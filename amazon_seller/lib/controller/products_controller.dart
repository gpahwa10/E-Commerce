import 'dart:io';

import 'package:amazon_seller/const/const.dart';
import 'package:amazon_seller/controller/home_controller.dart';
import 'package:amazon_seller/models/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProductController extends GetxController {
  var isLoading = false.obs;
  // TextFields Controller
  var pNameController = TextEditingController();
  var pPriceController = TextEditingController();
  var pQuantityController = TextEditingController();
  var pDescriptionController = TextEditingController();

  var categoryList = <String>[].obs;
  var subCategoryList = <String>[].obs;
  List<Category> category = [];
  var pImagesList = RxList<dynamic>.generate(3, (index) => null);
  var pImagesLinks = [];

  var categoryValue = ''.obs;
  var subcategoryValue = ''.obs;
  var selectedColorIndex = 0.obs;

  getCategories() async {
    var data = await rootBundle.loadString('lib/services/category_model.json');
    var cat = categoriModelFromJson(data);
    category = cat.categories;
  }

  populateCategoryList() {
    categoryList.clear();
    for (var item in category) {
      categoryList.add(item.name);
    }
  }

  populateSubCategory(cat) {
    subCategoryList.clear();
    var data = category.where((element) => element.name == cat).toList();

    for (var i = 0; i < data.first.subcategory.length; i++) {
      subCategoryList.add(data.first.subcategory[i]);
    }
  }

  pickImage({index, context}) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 80);
      if (img == null) {
        return;
      } else {
        pImagesList[index] = File(img.path);
      }
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadImages() async {
    pImagesLinks.clear();
    for (var item in pImagesList) {
      if (item != null) {
        var filename = basename(item.path);
        var destination = 'images/vendors/${currentUser!.uid}/$filename';
        Reference ref = FirebaseStorage.instance.ref().child(destination);
        await ref.putFile(item);
        var n = await ref.getDownloadURL();
        pImagesLinks.add(n);
      }
    }
  }

  uploadProduct(context) async {
    var store = firestore.collection(productCollection).doc();
    await store.set({
      'is_featured': false,
      'p_category': categoryValue.value,
      'p_subcategory': subcategoryValue.value,
      'p_colors': FieldValue.arrayUnion([Colors.red.value, Colors.brown.value]),
      'p_images': FieldValue.arrayUnion(pImagesLinks),
      'p_wishlist': FieldValue.arrayUnion([]),
      'p_description': pDescriptionController.text,
      'p_name': pNameController.text,
      'p_price': pPriceController.text,
      'p_quantity': pQuantityController.text,
      'p_seller': Get.find<HomeController>().username,
      'p_rating': '5.0',
      'p_vendorID': currentUser!.uid,
      'featured_id': '',
    });
    isLoading(false);
    VxToast.show(context, msg: "Your Product has been uploaded");
  }

  addFeatured(docID) async {
    await firestore.collection(productCollection).doc(docID).set(
        {'featured_id': currentUser!.uid, "is_featured": true},
        SetOptions(merge: true));
  }

  removeFeatured(docID) async {
    await firestore.collection(productCollection).doc(docID).set(
        {'featured_id': '', "is_featured": false}, SetOptions(merge: true));
  }

  removeProduct(docID)async{
    await firestore.collection(productCollection).doc(docID).delete();
  }
}
