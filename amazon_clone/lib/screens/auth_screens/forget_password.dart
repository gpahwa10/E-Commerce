import 'package:amazon_clone/screens/auth_screens/controller/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.onPrimary,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new), // iOS-style back arrow
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Forgot Password?",
              style: TextStyle(
                  color: colorScheme.onSecondary,
                  fontSize: 32.sp,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.h),
            Text(
                "Please, enter your email address. You will receive a link to create a new password via email.",
                style: TextStyle(
                    color: colorScheme.onSurfaceVariant, fontSize: 14.sp)),
            SizedBox(height: 20.h),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: colorScheme.onSurfaceVariant.withOpacity(0.6),
                  )),
              child: TextFormField(
                decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Email',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h)),
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w),
              child: controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : GestureDetector(
                      onTap: () {},
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
          ],
        ),
      ),
    );
  }
}
