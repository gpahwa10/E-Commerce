import 'package:amazon_seller/const/const.dart';
import 'package:amazon_seller/controller/auth_controller.dart';
import 'package:amazon_seller/controller/profile_controller.dart';
import 'package:amazon_seller/screens/auth_screen/login_screeen.dart';
import 'package:amazon_seller/screens/settings/edit_profile.dart';
import 'package:amazon_seller/screens/message_screen/messages_screen.dart';
import 'package:amazon_seller/screens/settings/shop_settings_screen.dart';
import 'package:amazon_seller/services/store_services.dart';
import 'package:amazon_seller/widgets/loading_indicator.dart';
import 'package:amazon_seller/widgets/text_styles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());

    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        title: boldText(text: settings, size: 16.0),
        actions: [
          IconButton(
              onPressed: () {
                Get.to(() => EditProfile(
                      username: controller.snapshotData['vendor_name'],
                    ));
              },
              icon: const Icon(
                Icons.edit,
                color: white,
                size: 25,
              )),
          IconButton(
              onPressed: () async {
                await Get.find<AuthController>().signout(context);
                Get.offAll(const LoginScreen());
              },
              icon: const Icon(
                Icons.power_settings_new,
                color: white,
                size: 25,
              ))
        ],
      ),
      body: FutureBuilder(
          future: StoreServices.getProfile(uid: currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return loadingIndicator(circleColor: white);
            } else {
              controller.snapshotData = snapshot.data!.docs[0];

              return Column(
                children: [
                  ListTile(
                    leading: controller.snapshotData['imageUrl'] == ''
                        ? Image.asset(
                            imgProduct,
                            width: 100,
                          ).box.roundedFull.clip(Clip.antiAlias).make()
                        : Image.network(controller.snapshotData['imageUrl'],
                                width: 100)
                            .box
                            .roundedFull
                            .clip(Clip.antiAlias)
                            .make(),
                    title: boldText(
                        text: "${controller.snapshotData['vendor_name']}"),
                    subtitle:
                        normalText(text: "${controller.snapshotData['email']}"),
                  ),
                  const Divider(),
                  10.heightBox,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: List.generate(
                          2,
                          (index) => ListTile(
                                onTap: () {
                                  switch (index) {
                                    case 0:
                                      Get.to(() => const ShopSettings());
                                      break;
                                    case 1:
                                      Get.to(() => const MessageScreen());
                                  }
                                },
                                leading: Icon(
                                  settingsIcons[index],
                                  color: white,
                                ),
                                title: normalText(text: settingsTitles[index]),
                              )),
                    ),
                  )
                ],
              );
            }
          }),
    );
  }
}

// else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//               return Center(child: boldText(text: "No Data Found"));
//             } 