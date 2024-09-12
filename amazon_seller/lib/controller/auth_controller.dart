import 'package:amazon_seller/const/const.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthController extends GetxController {
  
  var isLoading = false.obs;
  
  //Text controllers
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  //login Mehtod
  Future<UserCredential?> loginMethod({context}) async {
    UserCredential? userCredential;
    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }

    return userCredential;
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
