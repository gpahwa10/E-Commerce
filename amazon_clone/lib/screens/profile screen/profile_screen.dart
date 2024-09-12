import 'package:amazon_clone/common_widgets/bg_widget.dart';
import 'package:amazon_clone/common_widgets/loading_indicator.dart';
import 'package:amazon_clone/consts/consts.dart';
import 'package:amazon_clone/consts/lists.dart';
import 'package:amazon_clone/controller/auth_controller.dart';
import 'package:amazon_clone/controller/profile_controller.dart';
import 'package:amazon_clone/screens/auth_screens/login_screen.dart';
import 'package:amazon_clone/screens/chat_screen/message_screen.dart';
import 'package:amazon_clone/screens/edit_screen.dart';
import 'package:amazon_clone/screens/profile%20screen/components/details_tab.dart';
import 'package:amazon_clone/screens/orders_screen/order_screen.dart';
import 'package:amazon_clone/screens/wishlist_screen/wishlist_screen.dart';
import 'package:amazon_clone/services/firestore_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    var controller = Get.put(ProfileController());
    FirestoreServices.getCounts();
    return bgWidget(Scaffold(
        body: StreamBuilder(
      stream: FirestoreServices.getUser(currentUser!.uid),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return loadingIndicator();
        } else {
          var data = snapshot.data!.docs[0];

          return SafeArea(
              child: Column(
            children: [
              //edit profile
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.topRight,
                  child: const Icon(
                    Icons.edit,
                    color: whiteColor,
                  ).onTap(() {
                    controller.nameController.text = data['name'];
                    controller.oldpassController.text = data['password'];

                    Get.to(() => EditProfileScreen(data: data));
                  }),
                ),
              ),
              //user details section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  children: [
                    data['imageUrl'] == ''
                        ? Image.asset(
                            imgProfile2,
                            width: 100,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make()
                        : Image.network(
                            data['imageUrl'],
                            width: 100,
                            fit: BoxFit.cover,
                          ).box.roundedFull.clip(Clip.antiAlias).make(),
                    10.widthBox,
                    Expanded(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        "${data['name']}"
                            .text
                            .fontFamily(semibold)
                            .white
                            .make(),
                        "${data['email']}".text.white.make()
                      ],
                    )),
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            side: const BorderSide(color: whiteColor)),
                        onPressed: () async {
                          await Get.put(AuthController().signout(context));
                          Get.offAll(() => const LoginScreen());
                        },
                        child: "Logout".text.white.fontFamily(semibold).make())
                  ],
                ),
              ),
              FutureBuilder(
                  future: FirestoreServices.getCounts(),
                  builder: ((BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return loadingIndicator();
                    } else {
                      var cData = snapshot.data;
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          detailsTab(
                              width: context.screenWidth / 3.3,
                              count: "${cData[0]}".toString(),
                              title: "in your cart"),
                          detailsTab(
                              width: context.screenWidth / 3.3,
                              count: "${cData[2]}".toString(),
                              title:  "in your wishlist"),
                          detailsTab(
                              width:  context.screenWidth / 3.3,
                              count:  "${cData[1]}".toString(),
                              title:  "your orders"),
                        ],
                      );
                    }
                  })),
              //buttons section
              ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: ((BuildContext context, index) {
                        return ListTile(
                          onTap: () {
                            switch (index) {
                              case 0:
                                Get.to(() => const OrderScreen());
                                break;
                              case 1:
                                Get.to(() => const WishlistScreen());
                                break;
                              case 2:
                                Get.to(() => const MessageScreen());
                                break;
                            }
                          },
                          leading: Image.asset(
                            profileButtonIconList[index],
                            width: 22,
                          ),
                          title: profileButtonList[index].text.make(),
                        );
                      }),
                      separatorBuilder: ((BuildContext context, index) {
                        return const Divider(
                          color: lightGrey,
                        );
                      }),
                      itemCount: profileButtonList.length)
                  .box
                  .rounded
                  .padding(const EdgeInsets.symmetric(horizontal: 16))
                  .margin(const EdgeInsets.all(12))
                  .white
                  .shadowSm
                  .make()
                  .box
                  .color(redColor)
                  .make()
            ],
          ));
        }
      },
    )));
  }
}
