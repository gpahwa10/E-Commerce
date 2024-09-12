import 'package:amazon_clone/common_widgets/applogo_widget.dart';
import 'package:amazon_clone/common_widgets/bg_widget.dart';
import 'package:amazon_clone/common_widgets/common_buton.dart';
import 'package:amazon_clone/common_widgets/custom_textfield.dart';
import 'package:amazon_clone/common_widgets/loading_indicator.dart';
import 'package:amazon_clone/consts/consts.dart';
import 'package:amazon_clone/controller/auth_controller.dart';
import 'package:amazon_clone/screens/home_screen/home.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());

  //Text Controllers
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passowrdController = TextEditingController();
  var passwordRetypeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return bgWidget(Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            appLogoWidget(),
            const SizedBox(
              height: 10,
            ),
            "Sign Up to $appname".text.fontFamily(bold).white.size(18).make(),
            10.heightBox,
            Obx(
              () => Column(
                children: [
                  customTextField(
                      title: name,
                      hint: nameHint,
                      controller: nameController,
                      isPass: false),
                  5.heightBox,
                  customTextField(
                      title: email,
                      hint: emailHint,
                      controller: emailController,
                      isPass: false),
                  5.heightBox,
                  customTextField(
                      title: password,
                      hint: passwordHint,
                      controller: passowrdController,
                      isPass: true),
                  5.heightBox,
                  customTextField(
                      title: retypePass,
                      hint: passwordHint,
                      controller: passwordRetypeController,
                      isPass: true),
                  5.heightBox,
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {},
                      child: forgetPassword.text.make(),
                    ),
                  ),
                  5.heightBox,
                  Row(
                    children: [
                      Checkbox(
                          value: isCheck,
                          onChanged: (newValue) {
                            setState(() {
                              isCheck = newValue;
                            });
                          }),
                      10.widthBox,
                      Expanded(
                        child: RichText(
                            text: const TextSpan(children: [
                          TextSpan(
                              text: "I Agree to the ",
                              style: TextStyle(
                                  fontFamily: regular, color: fontGrey)),
                          TextSpan(
                              text: terms,
                              style: TextStyle(
                                  fontFamily: regular, color: redColor)),
                          TextSpan(
                              text: " & ",
                              style: TextStyle(
                                  fontFamily: regular, color: redColor)),
                          TextSpan(
                              text: privacyPolicy,
                              style: TextStyle(
                                  fontFamily: regular, color: redColor))
                        ])),
                      )
                    ],
                  ),
                  5.heightBox,
                  controller.isLoading.value
                      ? loadingIndicator()
                      : loginbutton(onPress: () async {
                          controller.isLoading(true);
                          if (isCheck != false) {
                            try {
                              await controller
                                  .signUpMethod(
                                      email: emailController.text,
                                      passowrd: passowrdController.text,
                                      context: context)
                                  .then((value) {
                                controller.sotreUserData(
                                    name: nameController.text,
                                    email: emailController.text,
                                    passsowrd: passowrdController.text);
                              }).then((value) {
                                VxToast.show(context, msg: loginSuccess);
                                Get.offAll(const Home());
                              });
                            } catch (e) {
                              auth.signOut();
                              VxToast.show(context, msg: e.toString());
                            }
                          } else {
                            controller.isLoading(false);
                          }
                        }, bgcolor:  isCheck == true ? redColor : lightGrey,textColor:  whiteColor,
                             title:  signup)
                          .box
                          .width(context.screenWidth - 50)
                          .make(),
                  5.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      alreadyAcc.text.color(fontGrey).fontFamily(bold).make(),
                      login.text.color(redColor).fontFamily(bold).make()
                    ],
                  ).onTap(() {
                    Get.back();
                  })
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
