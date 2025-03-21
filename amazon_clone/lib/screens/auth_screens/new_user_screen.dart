import 'package:amazon_clone/common_widgets/applogo_widget.dart';
import 'package:amazon_clone/common_widgets/bg_widget.dart';
import 'package:amazon_clone/common_widgets/common_buton.dart';
import 'package:amazon_clone/common_widgets/custom_textfield.dart';
import 'package:amazon_clone/common_widgets/loading_indicator.dart';
import 'package:amazon_clone/consts/consts.dart';
import 'package:amazon_clone/screens/auth_screens/controller/auth_controller.dart';
import 'package:amazon_clone/screens/home_screen/home.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../routes/app_routes.dart';

// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({super.key});
//
//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }
//
// class _SignUpScreenState extends State<SignUpScreen> {
//   bool? isCheck = false;
//   var controller = Get.put(AuthController());
//
//   //Text Controllers
//   var nameController = TextEditingController();
//   var emailController = TextEditingController();
//   var passowrdController = TextEditingController();
//   var passwordRetypeController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return bgWidget(Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: SingleChildScrollView(
//         child: Center(
//           child: Column(
//             children: [
//               (context.screenHeight * 0.1).heightBox,
//               appLogoWidget(),
//               const SizedBox(
//                 height: 10,
//               ),
//               "Sign Up to $appname".text.fontFamily(bold).white.size(18).make(),
//               10.heightBox,
//               Obx(
//                 () => Column(
//                   children: [
//                     customTextField(
//                         title: name,
//                         hint: nameHint,
//                         controller: nameController,
//                         isPass: false),
//                     5.heightBox,
//                     customTextField(
//                         title: email,
//                         hint: emailHint,
//                         controller: emailController,
//                         isPass: false),
//                     5.heightBox,
//                     customTextField(
//                         title: password,
//                         hint: passwordHint,
//                         controller: passowrdController,
//                         isPass: true),
//                     5.heightBox,
//                     customTextField(
//                         title: retypePass,
//                         hint: passwordHint,
//                         controller: passwordRetypeController,
//                         isPass: true),
//                     5.heightBox,
//                     Align(
//                       alignment: Alignment.centerRight,
//                       child: TextButton(
//                         onPressed: () {},
//                         child: forgetPassword.text.make(),
//                       ),
//                     ),
//                     5.heightBox,
//                     Row(
//                       children: [
//                         Checkbox(
//                             value: isCheck,
//                             onChanged: (newValue) {
//                               setState(() {
//                                 isCheck = newValue;
//                               });
//                             }),
//                         10.widthBox,
//                         Expanded(
//                           child: RichText(
//                               text: const TextSpan(children: [
//                             TextSpan(
//                                 text: "I Agree to the ",
//                                 style: TextStyle(
//                                     fontFamily: regular, color: fontGrey)),
//                             TextSpan(
//                                 text: terms,
//                                 style: TextStyle(
//                                     fontFamily: regular, color: redColor)),
//                             TextSpan(
//                                 text: " & ",
//                                 style: TextStyle(
//                                     fontFamily: regular, color: redColor)),
//                             TextSpan(
//                                 text: privacyPolicy,
//                                 style: TextStyle(
//                                     fontFamily: regular, color: redColor))
//                           ])),
//                         )
//                       ],
//                     ),
//                     5.heightBox,
//                     controller.isLoading.value
//                         ? loadingIndicator()
//                         : loginbutton(onPress: () async {
//                             controller.isLoading(true);
//                             if (isCheck != false) {
//                               try {
//                                 await controller
//                                     .signUpMethod(
//                                         email: emailController.text,
//                                         passowrd: passowrdController.text,
//                                         context: context)
//                                     .then((value) {
//                                   controller.storeUserData(
//                                       name: nameController.text,
//                                       email: emailController.text,
//                                       passsowrd: passowrdController.text);
//                                 }).then((value) {
//                                   VxToast.show(context, msg: loginSuccess);
//                                   Get.offAll(const Home());
//                                 });
//                               } catch (e) {
//                                 auth.signOut();
//                                 VxToast.show(context, msg: e.toString());
//                               }
//                             } else {
//                               controller.isLoading(false);
//                             }
//                           }, bgcolor:  isCheck == true ? redColor : lightGrey,textColor:  whiteColor,
//                                title:  signup)
//                             .box
//                             .width(context.screenWidth - 50)
//                             .make(),
//                     5.heightBox,
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         alreadyAcc.text.color(fontGrey).fontFamily(bold).make(),
//                         login.text.color(redColor).fontFamily(bold).make()
//                       ],
//                     ).onTap(() {
//                       Get.back();
//                     })
//                   ],
//                 )
//                     .box
//                     .white
//                     .rounded
//                     .padding(const EdgeInsets.all(16))
//                     .width(context.screenWidth - 70)
//                     .shadowLg
//                     .make(),
//               )
//             ],
//           ),
//         ),
//       ),
//     ));
//   }
// }

class SignUpScreen extends GetView<AuthController> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.onPrimary,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 10.w),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Text(
                  'Welcome!\nTo TrendGenX',
                  style: TextStyle(
                      color: colorScheme.onSurface,
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold),
                ),
              ),

              //Name Field
              Container(
                decoration: BoxDecoration(
                    color: colorScheme.outline.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: colorScheme.onSurfaceVariant.withOpacity(0.6),
                    )),
                child: TextFormField(
                  controller: controller.emailController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.person_2_rounded),
                      hintText: 'Name',
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h)),
                  onChanged: (value){controller.email(value);},
                ),
              ),
              SizedBox(
                height: 30.h,
              ),

              //Email Field
              Container(
                decoration: BoxDecoration(
                    color: colorScheme.outline.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: colorScheme.onSurfaceVariant.withOpacity(0.6),
                    )),
                child: TextFormField(
                  controller: controller.emailController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.person_2_rounded),
                      hintText: 'Email',
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h)),
                  onChanged: (value){controller.email(value);},
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              //Password
              Container(
                decoration: BoxDecoration(
                    color: colorScheme.outline.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: colorScheme.onSurfaceVariant.withOpacity(0.6),
                    )),
                child: TextFormField(
                  controller: controller.passwordController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.lock),
                      hintText: 'Password',
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h)),
                  onChanged: (value){controller.password(value);},

                ),
              ),
              SizedBox(height: 30.h,),
              //Confirm Password
              Container(
                decoration: BoxDecoration(
                    color: colorScheme.outline.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(
                      color: colorScheme.onSurfaceVariant.withOpacity(0.6),
                    )),
                child: TextFormField(
                  controller: controller.passwordController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: Icon(Icons.lock),
                      hintText: 'Password',
                      contentPadding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h)),
                  onChanged: (value){controller.password(value);},

                ),
              ),
              SizedBox(height: 30.h,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child:controller.isLoading.value
                    ? const CircularProgressIndicator(): GestureDetector(
                  onTap: () {controller.loginMethod();},
                  child: Container(
                    height: 55.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: colorScheme.primary,
                        borderRadius: BorderRadius.circular(8.r)),
                    child: Center(
                      child: Text(
                        'Sign Up',
                        style: TextStyle(
                            color: colorScheme.onPrimary,
                            fontWeight: FontWeight.w600,
                            fontSize: 18.sp),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20.h),
              Center(child: Text('-OR Continue with-')),
              SizedBox(height: 20.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 44.h,
                    width: 44.w,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colorScheme.onPrimary,
                        border: Border.all(
                            color: colorScheme.onSurface, width: 1)),child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset(icGoogleLogo),
                  ),),
                  SizedBox(
                    width: 20.w,
                  ),
                  Container(
                    height: 44.h,
                    width: 44.w,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colorScheme.onPrimary,
                        border: Border.all(
                            color: colorScheme.onSurface, width: 1)),child: Icon(Icons.phone_android),),
                ],
              ),
              SizedBox(height: 20.h),
              Center(
                child: RichText(
                  text: TextSpan(
                    text: "Already have an Account? ",
                    style:
                    TextStyle(color: colorScheme.onSurface, fontSize: 16.0),
                    children: [
                      TextSpan(
                          text: "Login",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.toNamed(AppRoutes.initialRoute);
                            }),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
