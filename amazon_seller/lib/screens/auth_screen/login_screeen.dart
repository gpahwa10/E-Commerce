import 'package:amazon_seller/const/const.dart';
import 'package:amazon_seller/controller/auth_controller.dart';
import 'package:amazon_seller/screens/home_screen/home.dart';
import 'package:amazon_seller/widgets/loading_indicator.dart';

import 'package:amazon_seller/widgets/login_button.dart';
import 'package:amazon_seller/widgets/text_styles.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: purpleColor,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                30.heightBox,
                normalText(text: welcome, size: 18.0),
                20.heightBox,
                Row(
                  children: [
                    Image.asset(
                      imgLogo,
                      width: 70,
                      height: 70,
                    )
                        .box
                        .border(color: white)
                        .rounded
                        .padding(const EdgeInsets.all(8))
                        .make(),
                    10.widthBox,
                    boldText(text: appname, size: 22.0)
                  ],
                ),
                40.heightBox,
                normalText(text: loginTo, size: 18.0, color: lightGrey),
                10.heightBox,
                Obx(
                  () => Column(
                    children: [
                      TextFormField(
                        controller: controller.emailController,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.email,
                              color: purpleColor,
                            ),
                            hintText: emailHint,
                            border: InputBorder.none),
                      ),
                      const Divider(
                        color: purpleColor,
                      ),
                      TextFormField(
                        obscureText: true,
                        controller: controller.passwordController,
                        decoration: const InputDecoration(
                            prefixIcon: Icon(
                              Icons.password,
                              color: purpleColor,
                            ),
                            hintText: password,
                            border: InputBorder.none),
                      ),
                      10.heightBox,
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {},
                            child: forgotPassword.text
                                .color(purpleColor)
                                .size(14.0)
                                .make()),
                      ),
                      20.heightBox,
                      SizedBox(
                          width: context.screenWidth - 100,
                          child: controller.isLoading.value
                              ? loadingIndicator()
                              : loginButton(
                                  title: "login",
                                  onPress: () async {
                                    controller.isLoading(true);
                                    await controller
                                        .loginMethod(context: context)
                                        .then((value) {
                                      if (value != null) {
                                        VxToast.show(context, msg: "Login");
                                        controller.isLoading(false);
                                        Get.offAll(const Home());
                                      } else {
                                        controller.isLoading(false);
                                      }
                                    });
                                  }))
                    ],
                  )
                      .box
                      .rounded
                      .color(white)
                      .outerShadowMd
                      .padding(const EdgeInsets.all(8))
                      .make(),
                ),
                10.heightBox,
                Center(child: normalText(text: anyProblem, color: lightGrey))
              ],
            ),
          ),
        ));
  }
}
