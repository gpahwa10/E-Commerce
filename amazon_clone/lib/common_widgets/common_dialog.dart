import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'common_button.dart';

class CommonDialog extends StatelessWidget {
  final String title;
  final String message;
  final String? subMessage;
  final String confirmText;
  final VoidCallback? onConfirm;
  final bool showCloseButton;
  final Color? backgroundColor;
  final Color? contentBackgroundColor;

  const CommonDialog({
    super.key,
    required this.title,
    required this.message,
    this.subMessage,
    required this.confirmText,
    this.onConfirm,
    this.showCloseButton = true,
    this.backgroundColor,
    this.contentBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: Dialog(
        backgroundColor: Colors.transparent,
        insetPadding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 8.h),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 14.h),
          decoration: BoxDecoration(
            color: backgroundColor ?? Theme.of(context).colorScheme.onPrimary,
            borderRadius: BorderRadius.circular(18.r),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.8),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (showCloseButton)
                    GestureDetector(
                      onTap: () => Get.back(result: false),
                      // Return false on close
                      child: Container(
                        width: 25,
                        height: 25,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                            color: Theme.of(context).colorScheme.error,
                            width: 2,
                          ),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.close,
                          color: Theme.of(context).colorScheme.error,
                          size: 16.sp,
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(height: 8.h),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: contentBackgroundColor ??
                      Theme.of(context).colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurface,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 4),
                    if (subMessage != null)
                      Text(
                        subMessage ?? '',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.6),
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(height: 8.h),
              CommonButton(
                text: confirmText,
                onPressed: onConfirm ?? () => Get.back(result: true),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
