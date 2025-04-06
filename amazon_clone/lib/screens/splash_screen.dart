import 'package:amazon_clone/common_widgets/applogo_widget.dart';
import 'package:amazon_clone/consts/consts.dart';
import 'package:amazon_clone/routes/app_routes.dart';
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
          Get.offAllNamed(AppRoutes.login);
        } else {
          Get.offAllNamed(AppRoutes.home);

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
