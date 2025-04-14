import 'dart:io';

import 'package:amazon_clone/common_widgets/common_button.dart';
import 'package:amazon_clone/common_widgets/custom_textfield.dart';
import 'package:amazon_clone/common_widgets/loading_indicator.dart';
import 'package:amazon_clone/consts/consts.dart';
import 'package:amazon_clone/screens/profile%20screen/controller/profile_controller.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;

  const EditProfileScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    final colorScheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: colorScheme.onPrimary,
      appBar: AppBar(
        title: Text('Edit Profile'),
      ),
      body: Obx(
        () => Center(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                color: colorScheme.secondary),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Handle profile image display
                controller.profileImgPath.isEmpty
                    ? (data != null &&
                            data['imageUrl'] != null &&
                            data['imageUrl'].isNotEmpty
                        ? Image.network(
                            data['imageUrl'],
                            width: 100,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make()
                        : Image.asset(
                            imgProfile2,
                            width: 100,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make())
                    : Image.file(
                        File(controller.profileImgPath.value),
                        width: 100,
                        fit: BoxFit.cover,
                      ).box.roundedFull.clip(Clip.antiAlias).make(),
                10.heightBox,
                CommonButton(
                  text: 'Change Image',
                  backgroundColor: colorScheme.primary,
                  onPressed: () {
                    controller.changeImage(context);
                  },
                ),
                const Divider(),
                20.heightBox,
                customTextField(
                    colorScheme: colorScheme,
                    title: name,
                    hint: nameHint,
                    controller: controller.nameController,
                    isPass: false),
                10.heightBox,
                customTextField(
                    colorScheme: colorScheme,
                    title: oldpass,
                    hint: passwordHint,
                    controller: controller.oldpassController,
                    isPass: true),
                10.heightBox,
                customTextField(
                    colorScheme: colorScheme,
                    title: newpass,
                    hint: passwordHint,
                    controller: controller.newPassController,
                    isPass: true),
                20.heightBox,
                controller.isLoading.value
                    ? loadingIndicator()
                    : CommonButton(
                        text: 'Save Changes',
                        onPressed: () async {
                          if (data == null) {
                            VxToast.show(context,
                                msg: "User data not available");
                            return;
                          }

                          controller.isLoading(true);

                          // Handle image upload
                          if (controller.profileImgPath.value.isNotEmpty) {
                            await controller.uploadProfileImage();
                          } else {
                            controller.profileImgLink = data['imageUrl'] ?? '';
                          }

                          // Check if old password matches
                          if (data['password'] ==
                              controller.oldpassController.text) {
                            await controller.changeAuthPassword(
                                email: data['email'] ?? '',
                                password: controller.oldpassController.text,
                                newPassword: controller.newPassController.text);
                            await controller.updateprofile(
                                name: controller.nameController.text,
                                passowrd: controller.newPassController.text,
                                imgURL: controller.profileImgLink);
                            VxToast.show(context, msg: "Profile Updated!");
                          } else {
                            VxToast.show(context,
                                msg: "Incorrect old password");
                            controller.isLoading(false);
                          }
                        },
                        backgroundColor: colorScheme.primary,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
