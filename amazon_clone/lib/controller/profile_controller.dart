import 'dart:io';

import 'package:amazon_clone/consts/consts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController {
  var profileImgPath = ''.obs;
  var profileImgLink = '';
  var isLoading = false.obs;
  //textfields
  var nameController = TextEditingController();
  var oldpassController = TextEditingController();
  var newPassController = TextEditingController();

  void changeImage(context) async {
    try {
      final img = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 70);
      if (img == null) {
        return;
      } else {
        profileImgPath.value = img.path;
      }
    } on PlatformException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }

  uploadProfileImage() async {
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

  updateprofile({name, passowrd, imgURL}) async {
    var store = firestore.collection(usersCollection).doc(currentUser!.uid);
    try {
      await store.set({'name': name, 'password': password, 'imageUrl': imgURL},
          SetOptions(merge: true));
      // VxToast.show(context, msg: "Profile Updated Successfully!");
    } catch (e) {
      Get.snackbar("Error", "Failed to update Profile! : $e");
    } finally {
      isLoading(false);
    }
  }

  changeAuthPassword({email, password, newPassword}) async {
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
}
