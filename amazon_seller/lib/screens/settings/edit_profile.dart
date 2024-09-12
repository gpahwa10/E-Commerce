import 'dart:io';

import 'package:amazon_seller/const/const.dart';
import 'package:amazon_seller/controller/profile_controller.dart';
import 'package:amazon_seller/widgets/custom_textfield.dart';
import 'package:amazon_seller/widgets/loading_indicator.dart';
import 'package:amazon_seller/widgets/text_styles.dart';

class EditProfile extends StatefulWidget {
  final String? username;
  const EditProfile({super.key, this.username});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  var controller = Get.find<ProfileController>();

  @override
  void initState() {
    // TODO: implement initState
    controller.nameController.text = widget.username!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: purpleColor,
        appBar: AppBar(
          title: boldText(text: editProfile, size: 16.0),
          actions: [
            controller.isLoading.value
                ? loadingIndicator()
                : TextButton(
                    onPressed: () async {
                      try {
                        controller.isLoading(true);

                        // If image is not selected
                        if (controller.profileImgPath.value.isNotEmpty) {
                          await controller.uploadProfileImage();
                        } else {
                          controller.profileImgLink =
                              controller.snapshotData['imageUrl'];
                        }

                        // If old password matches the database
                        if (controller.snapshotData['password'] ==
                            controller.oldpassController.text) {
                          await controller.changeAuthPassword(
                              email: controller.snapshotData['email'],
                              password: controller.oldpassController.text,
                              newPassword: controller.newPassController.text);

                          print("ssss"+controller.nameController.text);
                          await controller.updateprofile(
                              imgURL: controller.profileImgLink,
                              name: controller.nameController.text,
                              password: controller.newPassController.text);
                          VxToast.show(context, msg: "Profile Updated");
                        } else if (controller
                                .oldpassController.text.isEmptyOrNull &&
                            controller.newPassController.text.isEmptyOrNull) {

                          print("ssss"+controller.nameController.text);
                          await controller.updateprofile(
                              imgURL: controller.profileImgLink,
                              name: controller.nameController.text,
                              password: controller.snapshotData['password']);
                          VxToast.show(context, msg: "Profile Updated");
                        }
                      } catch (e) {
                        VxToast.show(context,
                            msg: "Failed to update profile: $e");
                      } finally {
                        controller.isLoading(false);
                      }
                      print(currentUser!.uid);
                    },
                    child: normalText(text: save),
                  )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              // Image handling
              controller.snapshotData['imageUrl'] == '' &&
                      controller.profileImgPath.isEmpty
                  ? Image.asset(
                      imgProduct,
                      width: 100,
                      fit: BoxFit.cover,
                    ).box.width(150).roundedFull.clip(Clip.antiAlias).make()
                  : controller.snapshotData['imageUrl'] != '' &&
                          controller.profileImgPath.isEmpty
                      ? Image.network(controller.snapshotData['imageUrl']!,
                              width: 100, fit: BoxFit.cover)
                          .box
                          .width(150)
                          .roundedFull
                          .clip(Clip.antiAlias)
                          .make()
                      : Image.file(
                          File(controller.profileImgPath.value),
                          width: 100,
                          fit: BoxFit.cover,
                        )
                          .box
                          .width(150)
                          .roundedFull
                          .clip(Clip.antiAlias)
                          .make(),

              20.heightBox,
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: white),
                onPressed: () {
                  controller.changeImage(context);
                },
                child: normalText(text: "Change Image", color: fontGrey),
              ),
              10.heightBox,
              const Divider(
                color: white,
              ),
              10.heightBox,
              customTextField(
                label: name,
                hint: "Username of the user",
                isDescription: false,
                controller: controller.nameController,
              ),
              10.heightBox,
              Align(
                  alignment: Alignment.centerLeft,
                  child: boldText(text: "Change Your Password")),
              10.heightBox,
              customTextField(
                label: password,
                hint: passHint,
                isDescription: false,
                controller: controller.oldpassController,
              ),
              10.heightBox,
              customTextField(
                label: conPass,
                hint: conRePass,
                isDescription: false,
                controller: controller.newPassController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
