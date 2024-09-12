import 'package:amazon_clone/common_widgets/applogo_widget.dart';
import 'package:amazon_clone/consts/consts.dart';
import 'package:amazon_clone/screens/auth_screens/login_screen.dart';
import 'package:amazon_clone/screens/home_screen/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class SplashScren extends StatefulWidget {
  const SplashScren({super.key});

  @override
  State<SplashScren> createState() => _SplashScrenState();
}

class _SplashScrenState extends State<SplashScren> {
  changeScreen() {
    Future.delayed(const Duration(seconds: 3), () {
      auth.authStateChanges().listen((User? user) {
        if (user == null && mounted) {
          Get.to(() => const LoginScreen());
        } else {
          Get.to(() => const Home());
        }
      });
    });
  }

  @override
  void initState() {
    changeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset(
                icSplashBg,
                width: 300,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            appLogoWidget(),
            const SizedBox(
              height: 20,
            ),
            appname.text.fontFamily(bold).size(22).white.make(),
            appversion.text.fontFamily(regular).white.make(),
          ],
        ),
      ),
    );
  }
}
