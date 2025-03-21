import 'package:amazon_clone/consts/consts.dart';
import 'package:amazon_clone/routes/app_routes.dart';
import 'package:amazon_clone/screens/auth_screens/controller/auth_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

// class LoginScreen extends StatelessWidget {
//   const LoginScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     var controller = Get.put(AuthController());
//
//     return bgWidget(Scaffold(
//       resizeToAvoidBottomInset: true,
//       body: SingleChildScrollView(
//         child: Center(
//           child: Column(
//             children: [
//               (context.screenHeight * 0.1).heightBox,
//               appLogoWidget(),
//               10.heightBox,
//               "Log in to $appname".text.fontFamily(bold).white.size(18).make(),
//               10.heightBox,
//               Obx(
//                 () => Column(
//                   children: [
//                     customTextField(
//                         title: email,
//                         hint: emailHint,
//                         controller: controller.emailController,
//                         isPass: false),
//                     5.heightBox,
//                     customTextField(
//                         title: password,
//                         hint: passwordHint,
//                         controller: controller.passwordController,
//                         isPass: true),
//                     5.heightBox,
//                     Align(
//                       alignment: Alignment.centerRight,
//                       child: TextButton(
//                         onPressed: () {},
//                         child: forgetPassword.text.make(),
//                       ),
//                     ),
//                     10.heightBox,
//                     controller.isLoading.value
//                         ? loadingIndicator()
//                         : loginbutton(
//                                 onPress: () async {
//                                   controller.isLoading(true);
//                                   await controller
//                                       .loginMethod(context: context)
//                                       .then((value) {
//                                     if (value != null) {
//                                       VxToast.show(context, msg: loginSuccess);
//                                       Get.offAll(() => const Home());
//                                     } else {
//                                       controller.isLoading(false);
//                                     }
//                                   });
//                                 },
//                                 bgcolor: redColor,
//                                 textColor: whiteColor,
//                                 title: login)
//                             .box
//                             .width(context.screenWidth - 50)
//                             .make(),
//                     5.heightBox,
//                     createNewAccount.text.color(fontGrey).make(),
//                     5.heightBox,
//                     loginbutton(
//                             onPress: () {
//                               Get.to(() => const SignUpScreen());
//                             },
//                             bgcolor: lightGrey,
//                             textColor: redColor,
//                             title: signup)
//                         .box
//                         .width(context.screenWidth - 50)
//                         .make(),
//                     10.heightBox,
//                     loginWith.text.color(fontGrey).make(),
//                     5.heightBox,
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: List.generate(
//                           3,
//                           (index) => Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: CircleAvatar(
//                                   radius: 25,
//                                   backgroundColor: lightGrey,
//                                   child: Image.asset(socialconList[index],
//                                       width: 30),
//                                 ),
//                               )),
//                     )
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

class LoginScreen extends GetView<AuthController> {
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
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w400),
                    )),
              ),
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
                        'Login',
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
                    text: "Create an Account? ",
                    style:
                        TextStyle(color: colorScheme.onSurface, fontSize: 16.0),
                    children: [
                      TextSpan(
                          text: "Sign up",
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            color: colorScheme.primary,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Get.toNamed(AppRoutes.newUser);
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
