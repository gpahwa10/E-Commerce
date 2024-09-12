import 'dart:io';

import 'package:amazon_seller/const/const.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController {
  late QueryDocumentSnapshot snapshotData;
  var profileImgPath = ''.obs;
  var profileImgLink = '';
  var isLoading = false.obs;

  // Text fields
  TextEditingController nameController = TextEditingController();
  TextEditingController oldpassController = TextEditingController();
  TextEditingController newPassController = TextEditingController();

  //shop controllers
  var shopNameController = TextEditingController();
  var shopAddresController = TextEditingController();
  var shopMobileController = TextEditingController();
  var shopWebsiteController = TextEditingController();
  var shopDescriptionController = TextEditingController();

  void changeImage(context) async {
    try {
      final img = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        imageQuality: 70,
      );
      if (img != null) {
        profileImgPath.value = img.path;
      }
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  Future<void> uploadProfileImage() async {
    if (profileImgPath.isNotEmpty) {
      try {
        var filename = basename(profileImgPath.value);
        var destination = 'images/${currentUser!.uid}/$filename';
        Reference ref = FirebaseStorage.instance.ref().child(destination);
        await ref.putFile(File(profileImgPath.value));
        profileImgLink = await ref.getDownloadURL();
      } catch (e) {
        Get.snackbar("Error", "Failed to upload Profile Image: $e");
      }
    }
  }

  updateprofile({name, password, imgURL}) async {
    var store = firestore.collection(vendorsCollection).doc(currentUser!.uid);
    try {
      await store.set({
        'vendor_name': name,
        'password': password,
        'imageUrl': imgURL,
      }, SetOptions(merge: true));
    } catch (e) {
      Get.snackbar("Error", "Failed to update Profile! : $e");
    } finally {
      isLoading(false);
    }
  }

  Future<void> changeAuthPassword(
      {required String email,
      required String password,
      required String newPassword}) async {
    final credentials =
        EmailAuthProvider.credential(email: email, password: password);
    try {
      await currentUser!
          .reauthenticateWithCredential(credentials)
          .then((value) {
        currentUser!.updatePassword(newPassword);
      });
    } catch (e) {
      Get.snackbar("Error", "Updating Password Failed! : $e");
    }
  }

  updateShop({shopName, shopAddress, shopMobile, shopWebsite, shopDesc}) async {
    var store = firestore.collection(vendorsCollection).doc(currentUser!.uid);
    try {
      await store.set({
        'shop_name': shopName,
        'shop_address': shopAddress,
        'shop_mobile': shopMobile,
        'shop_website': shopWebsite,
        'shop_desc': shopDesc
      }, SetOptions(merge: true));
    } catch (e) {
      Get.snackbar("Error", "Failed to update Profile! : $e");
    } finally {
      isLoading(false);
    }
  }
}
