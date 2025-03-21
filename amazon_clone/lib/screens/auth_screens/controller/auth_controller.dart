import 'dart:developer';

import 'package:amazon_clone/consts/consts.dart';
import 'package:amazon_clone/routes/app_routes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../../../consts/prefs.dart';

class AuthController extends GetxController {
  
  var isLoading = false.obs;
  var errorMsg =''.obs;

  //Text controllers
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  var email =''.obs;
  var password =''.obs;

  //login Mehtod
  Future<void> loginMethod() async {
    if(email.isEmpty || password.isEmpty){
      errorMsg('Please enter email and password');
      return;
    }

    isLoading(true);
    errorMsg('');
    try{
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
          email: email.value, password: password.value);

      String? bearer = await userCredential.user!.getIdToken();
      await Prefs.setBearer(bearer!);
      await Prefs.setUserEmail(email.value);
      await Prefs.setUserPassword(password.value);
      log('Logged in successfully, token: $bearer');
      Get.offAllNamed(AppRoutes.home);
    }catch(e){
      log('Error upserting user FCM token: $e');
    }
  }

  //Sign Up Method
  Future<UserCredential?> signUpMethod({email, passowrd, context}) async {
    UserCredential? userCredential;
    try {
      await auth.createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }

    return userCredential;
  }

  //store user data
  storeUserData({name, passsowrd, email}) async {
    DocumentReference store =
        firestore.collection(usersCollection).doc(currentUser!.uid);
    store.set({
      'name': name,
      'password': password,
      'email': email,
      'imageUrl': '',
      'id': currentUser!.uid,
      'cart_count': "00",
      'wishlist_count': "00",
      'order_count': "00",
    });
  }

  //signout Method
  signout(context) async {
    try {
      await auth.signOut();
    } catch (e) {
      VxToast.show(context, msg: e.toString());
    }
  }
}
