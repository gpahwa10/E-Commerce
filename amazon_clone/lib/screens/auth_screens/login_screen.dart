import 'package:amazon_clone/consts/consts.dart';
import 'package:amazon_clone/routes/app_routes.dart';
import 'package:amazon_clone/screens/auth_screens/controller/auth_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

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
                    onPressed: () {Get.toNamed(AppRoutes.forgetPassword);},
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
              Center(
                child: Container(
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
