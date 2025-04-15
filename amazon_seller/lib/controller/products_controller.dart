import 'dart:io';

import 'package:amazon_seller/const/const.dart';
import 'package:amazon_seller/controller/home_controller.dart';
import 'package:amazon_seller/models/category_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductController extends GetxController {
  var isLoading = false.obs;

  // TextFields Controllers
  var pNameController = TextEditingController();
  var pActualPriceController = TextEditingController();
  var pBasePriceController = TextEditingController();
  var pQuantityController= TextEditingController();
  var pDescriptionController = TextEditingController();

  // Category and Subcategory
  var categoryList = <String>[].obs;
  var subCategoryList = <String>[].obs;
  List<Category> category = [];
  var categoryValue = ''.obs;
  var subcategoryValue = ''.obs;

  // Product Images
  var pImagesList = RxList<dynamic>.generate(3, (index) => null);
  var pImagesLinks = [];

  // Product Colors
  var selectedColorIndices = <int>[].obs;

  // Product Attributes
  var productAttributes = <Map<String, TextEditingController>>[].obs;

  @override
  void onInit() {
    super.onInit();
    getCategories();
    // Initialize with one attribute field
    addProductAttribute();
  }

  // --- Category and Subcategory ---
  getCategories() async {
    var data = await rootBundle.loadString('lib/services/category_model.json');
    var cat = categoriModelFromJson(data);
    category = cat.categories;
    populateCategoryList();
  }populateCategoryList() {
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

  // --- Product Images ---
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

  // --- Product Colors ---
  void toggleColorSelection(int index) {
    if (selectedColorIndices.contains(index)) {
      selectedColorIndices.remove(index);
    } else {
      selectedColorIndices.add(index);
    }
  }

  // --- Product Attributes ---
  void addProductAttribute() {
    productAttributes.add({
      'nameController': TextEditingController(),
      'valueController': TextEditingController(),
    });
  }

  void removeProductAttribute(Map<String, TextEditingController> attribute) {
    productAttributes.remove(attribute);
    attribute['nameController']!.dispose();
    attribute['valueController']!.dispose();
  }

  // --- Upload Product ---
  uploadProduct(context) async {
    isLoading(true);
    List<int> selectedColors = selectedColorIndices
        .map((index) => Vx.randomColor.value)
        .toList(); // Convert selected indices to color values

    List<Map<String, String>> attributes = productAttributes.map((attribute) {
      return {
        'name': attribute['nameController']!.text,
        'value': attribute['valueController']!.text,
      };
    }).toList();

    var store = firestore.collection(productCollection).doc();
    await store.set({
      'is_featured': false,
      'p_category': categoryValue.value,
      'p_subcategory': subcategoryValue.value,
      'p_colors': FieldValue.arrayUnion(selectedColors),
      'p_images': FieldValue.arrayUnion(pImagesLinks),
      'p_wishlist': FieldValue.arrayUnion([]),
      'p_description': pDescriptionController.text,
      'p_name': pNameController.text,
      'p_actual_price': pActualPriceController.text,
      'p_base_price': pBasePriceController.text,
      'p_quantity': pQuantityController.text,
      'p_seller': Get.find<HomeController>().username,
      'p_rating': '5.0',
      'p_vendorID': currentUser!.uid,
      'featured_id': '',
      'p_attributes': attributes,
    });
    isLoading(false);
    VxToast.show(context, msg: "Your Product has been uploaded");
    clearControllers();
  }

  // --- Featured Products ---
  addFeatured(docID) async {
    await firestore.collection(productCollection).doc(docID).set(
        {'featured_id': currentUser!.uid, "is_featured": true},
        SetOptions(merge: true));
  }

  removeFeatured(docID) async {
    await firestore.collection(productCollection).doc(docID).set(
        {'featured_id': '', "is_featured": false}, SetOptions(merge: true));
  }

  // ---Remove Product ---
  removeProduct(docID) async {
    await firestore.collection(productCollection).doc(docID).delete();
  }

  // --- Clear Controllers ---
  void clearControllers() {
    pNameController.clear();
    pActualPriceController.clear();
    pBasePriceController.clear();
    pQuantityController.clear();
    pDescriptionController.clear();
    categoryValue.value = '';
    subcategoryValue.value = '';
    pImagesList.value = List.generate(3, (index) => null);
    pImagesLinks.clear();
    selectedColorIndices.clear();
    for (var attribute in productAttributes) {
      attribute['nameController']!.clear();
      attribute['valueController']!.clear();
    }
  }
}