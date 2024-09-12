import 'dart:io';
import 'package:amazon_clone/common_widgets/bg_widget.dart';
import 'package:amazon_clone/common_widgets/common_buton.dart';
import 'package:amazon_clone/common_widgets/custom_textfield.dart';
import 'package:amazon_clone/common_widgets/loading_indicator.dart';
import 'package:amazon_clone/consts/consts.dart';
import 'package:amazon_clone/controller/profile_controller.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;

  const EditProfileScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    return bgWidget(Scaffold(
      appBar: AppBar(),
      body: Obx(
        () => SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              //if url and control path are empty
              data['imageUrl'] == '' && controller.profileImgPath.isEmpty
                  ? Image.asset(
                      imgProfile2,
                      width: 100,
                      fit: BoxFit.cover,
                    ).box.roundedFull.clip(Clip.antiAlias).make()

                  //data is not empty but controller path is empty
                  : data['imageUrl'] != '' && controller.profileImgPath.isEmpty
                      ? Image.network(data['imageUrl'],
                              width: 100, fit: BoxFit.cover)
                          .box
                          .roundedFull
                          .clip(Clip.antiAlias)
                          .make()

                      //if both the paths are empty
                      : Image.file(
                          File(controller.profileImgPath.value),
                          width: 100,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make(),
              10.heightBox,
              loginbutton(
                  onPress: () {
                    controller.changeImage(context);
                  },
                  bgcolor: redColor,
                  textColor: whiteColor,
                  title: 'Change'),
              const Divider(),
              20.heightBox,
              customTextField(
                  title: name,
                  hint: nameHint,
                  controller: controller.nameController,
                  isPass: false),
              10.heightBox,
              customTextField(
                  title: oldpass,
                  hint: passwordHint,
                  controller: controller.oldpassController,
                  isPass: true),
              10.heightBox,
              customTextField(
                  title: newpass,
                  hint: passwordHint,
                  controller: controller.newPassController,
                  isPass: true),
              20.heightBox,
              controller.isLoading.value
                  ? loadingIndicator()
                  : SizedBox(
                      width: context.screenWidth - 60,
                      child: loginbutton(
                          onPress: () async {
                            controller.isLoading(true);

                            //if image is not selected
                            if (controller.profileImgPath.value.isNotEmpty) {
                              await controller.uploadProfileImage();
                            } else {
                              controller.profileImgLink = data['imageUrl'];
                            }

                            //check if old password matches from database
                            if (data['password'] ==
                                controller.oldpassController.text) {
                              await controller.changeAuthPassword(
                                  email: data['email'],
                                  password: controller.oldpassController.text,
                                  newPassword:
                                      controller.newPassController.text);
                              await controller.updateprofile(
                                  name: controller.nameController.text,
                                  passowrd: controller.newPassController.text,
                                  imgURL: controller.profileImgLink);
                              VxToast.show(context, msg: "Profile Updated!");
                            } else {
                              VxToast.show(context,
                                  msg: "Failed to update password");
                              controller.isLoading(false);
                            }
                          },
                          bgcolor: redColor,
                          textColor: whiteColor,
                          title: 'Save Changes'))
            ],
          )
              .box
              .white
              .shadowSm
              .rounded
              .padding(const EdgeInsets.all(16))
              .margin(const EdgeInsets.only(top: 50, left: 12, right: 12))
              .make(),
        ),
      ),
    ));
  }
}
