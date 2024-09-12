import 'package:amazon_clone/common_widgets/applogo_widget.dart';
import 'package:amazon_clone/common_widgets/bg_widget.dart';
import 'package:amazon_clone/common_widgets/common_buton.dart';
import 'package:amazon_clone/common_widgets/custom_textfield.dart';
import 'package:amazon_clone/common_widgets/loading_indicator.dart';
import 'package:amazon_clone/consts/consts.dart';
import 'package:amazon_clone/consts/lists.dart';
import 'package:amazon_clone/controller/auth_controller.dart';
import 'package:amazon_clone/screens/auth_screens/new_user_screen.dart';
import 'package:amazon_clone/screens/home_screen/home.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return bgWidget(Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            appLogoWidget(),
            10.heightBox,
            "Log in to $appname".text.fontFamily(bold).white.size(18).make(),
            10.heightBox,
            Obx(
              () => Column(
                children: [
                  customTextField(
                      title: email,
                      hint: emailHint,
                      controller: controller.emailController,
                      isPass: false),
                  5.heightBox,
                  customTextField(
                      title: password,
                      hint: passwordHint,
                      controller: controller.passwordController,
                      isPass: true),
                  5.heightBox,
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: forgetPassword.text.make(),
                    ),
                  ),
                  10.heightBox,
                  controller.isLoading.value
                      ? loadingIndicator()
                      : loginbutton(
                              onPress: () async {
                                controller.isLoading(true);
                                await controller
                                    .loginMethod(context: context)
                                    .then((value) {
                                  if (value != null) {
                                    VxToast.show(context, msg: loginSuccess);
                                    Get.offAll(() => const Home());
                                  } else {
                                    controller.isLoading(false);
                                  }
                                });
                              },
                              bgcolor: redColor,
                              textColor: whiteColor,
                              title: login)
                          .box
                          .width(context.screenWidth - 50)
                          .make(),
                  5.heightBox,
                  createNewAccount.text.color(fontGrey).make(),
                  5.heightBox,
                  loginbutton(
                          onPress: () {
                            Get.to(() => const SignUpScreen());
                          },
                          bgcolor: lightGrey,
                          textColor: redColor,
                          title: signup)
                      .box
                      .width(context.screenWidth - 50)
                      .make(),
                  10.heightBox,
                  loginWith.text.color(fontGrey).make(),
                  5.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                        3,
                        (index) => Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircleAvatar(
                                radius: 25,
                                backgroundColor: lightGrey,
                                child: Image.asset(socialconList[index],
                                    width: 30),
                              ),
                            )),
                  )
                ],
              )
                  .box
                  .white
                  .rounded
                  .padding(const EdgeInsets.all(16))
                  .width(context.screenWidth - 70)
                  .shadowLg
                  .make(),
            )
          ],
        ),
      ),
    ));
  }
}
