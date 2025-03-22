import 'package:amazon_clone/consts/consts.dart';
import 'package:amazon_clone/screens/profile%20screen/controller/profile_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../common_widgets/common_dialog.dart';
import '../../routes/app_routes.dart';
import '../../services/firestore_service.dart';

// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // ignore: unused_local_variable
//     var controller = Get.put(ProfileController());
//     FirestoreServices.getCounts();
//     return bgWidget(Scaffold(
//         body: StreamBuilder(
//       stream: FirestoreServices.getUser(currentUser!.uid),
//       builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (!snapshot.hasData) {
//           return loadingIndicator();
//         } else {
//           var data = snapshot.data!.docs[0];
//
//           return SafeArea(
//               child: Column(
//             children: [
//               //edit profile
//               Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: Align(
//                   alignment: Alignment.topRight,
//                   child: const Icon(
//                     Icons.edit,
//                     color: whiteColor,
//                   ).onTap(() {
//                     controller.nameController.text = data['name'];
//                     controller.oldpassController.text = data['password'];
//
//                     Get.to(() => EditProfileScreen(data: data));
//                   }),
//                 ),
//               ),
//               //user details section
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 8.0),
//                 child: Row(
//                   children: [
//                     data['imageUrl'] == ''
//                         ? Image.asset(
//                             imgProfile2,
//                             width: 100,
//                             fit: BoxFit.cover,
//                           ).box.roundedFull.clip(Clip.antiAlias).make()
//                         : Image.network(
//                             data['imageUrl'],
//                             width: 100,
//                             fit: BoxFit.cover,
//                           ).box.roundedFull.clip(Clip.antiAlias).make(),
//                     10.widthBox,
//                     Expanded(
//                         child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         "${data['name']}"
//                             .text
//                             .fontFamily(semibold)
//                             .white
//                             .make(),
//                         "${data['email']}".text.white.make()
//                       ],
//                     )),
//                     OutlinedButton(
//                         style: OutlinedButton.styleFrom(
//                             side: const BorderSide(color: whiteColor)),
//                         onPressed: () async {
//                           await FirebaseAuth.instance.signOut();
//                           final prefs = await SharedPreferences.getInstance();
//                           await prefs.clear();
//                           Get.offAllNamed(AppRoutes.login);
//                         },
//                         child: "Logout".text.white.fontFamily(semibold).make())
//                   ],
//                 ),
//               ),
//               FutureBuilder(
//                   future: FirestoreServices.getCounts(),
//                   builder: ((BuildContext context, AsyncSnapshot snapshot) {
//                     if (!snapshot.hasData) {
//                       return loadingIndicator();
//                     } else {
//                       var cData = snapshot.data;
//                       return Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           detailsTab(
//                               width: context.screenWidth / 3.3,
//                               count: "${cData[0]}".toString(),
//                               title: "in your cart"),
//                           detailsTab(
//                               width: context.screenWidth / 3.3,
//                               count: "${cData[2]}".toString(),
//                               title: "in your wishlist"),
//                           detailsTab(
//                               width: context.screenWidth / 3.3,
//                               count: "${cData[1]}".toString(),
//                               title: "your orders"),
//                         ],
//                       );
//                     }
//                   })),
//               //buttons section
//               ListView.separated(
//                       shrinkWrap: true,
//                       itemBuilder: ((BuildContext context, index) {
//                         return ListTile(
//                           onTap: () {
//                             switch (index) {
//                               case 0:
//                                 Get.to(() => const OrderScreen());
//                                 break;
//                               case 1:
//                                 Get.to(() => const WishlistScreen());
//                                 break;
//                               case 2:
//                                 Get.to(() => const MessageScreen());
//                                 break;
//                             }
//                           },
//                           leading: Image.asset(
//                             profileButtonIconList[index],
//                             width: 22,
//                           ),
//                           title: profileButtonList[index].text.make(),
//                         );
//                       }),
//                       separatorBuilder: ((BuildContext context, index) {
//                         return const Divider(
//                           color: lightGrey,
//                         );
//                       }),
//                       itemCount: profileButtonList.length)
//                   .box
//                   .rounded
//                   .padding(const EdgeInsets.symmetric(horizontal: 16))
//                   .margin(const EdgeInsets.all(12))
//                   .white
//                   .shadowSm
//                   .make()
//                   .box
//                   .color(redColor)
//                   .make()
//             ],
//           ));
//         }
//       },
//     )));
//   }
// }

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final controller = Get.put(ProfileController());
    FirestoreServices.getCounts();
    return Scaffold(
      backgroundColor: colorScheme.onPrimary,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 10.w),
        child: SingleChildScrollView(
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'My Profile',
                  style:
                      TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30.h),
                Row(
                  children: [
                    Container(
                      height: 64.h,
                      width: 64.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colorScheme.primary,
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          imgProfile2,
                          width: 64.w, // Match the container size
                          height: 64.h, // Match the container size
                          fit: BoxFit.cover, // Ensures the image fills the circular space properly
                        ),
                      ),
                    ),

                    SizedBox(
                      width: 10.w,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          controller.name.value,
                          style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 16.sp),
                        ),
                        Text(
                          controller.email.value,
                          style: TextStyle(
                              color: colorScheme.outline,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    const Spacer(),
                    TextButton(
                        onPressed: () async {
                          showLogoutDialog(context,colorScheme);
                        },
                        child: Text("Log out"))
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                profileTabs(colorScheme,controller)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget profileTabs(ColorScheme colorScheme,ProfileController controller) {
    return Column(
      children: [
        ListTile(
          title: Text(
            "My Orders",
            style: TextStyle(
                color: colorScheme.onSecondary,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            "You have ${controller.orderCount} orders",
            style: TextStyle(color: colorScheme.outline, fontSize: 12.sp),
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: colorScheme.outlineVariant,
            size: 34.sp,
          ),
        ),
        Divider(
          color: colorScheme.outlineVariant,
        ),
        ListTile(
          title: Text(
            "Shipping Addresses",
            style: TextStyle(
                color: colorScheme.onSecondary,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            "3 Addresses",
            style: TextStyle(color: colorScheme.outline, fontSize: 12.sp),
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: colorScheme.outlineVariant,
            size: 34.sp,
          ),
        ),
        Divider(
          color: colorScheme.outlineVariant,
        ),
        ListTile(
          title: Text(
            "Payment Methods",
            style: TextStyle(
                color: colorScheme.onSecondary,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            "Already have 12 orders",
            style: TextStyle(color: colorScheme.outline, fontSize: 12.sp),
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: colorScheme.outlineVariant,
            size: 34.sp,
          ),
        ),
        Divider(
          color: colorScheme.outlineVariant,
        ),
        ListTile(
          title: Text(
            "My Reviews",
            style: TextStyle(
                color: colorScheme.onSecondary,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            "Review of 4 items",
            style: TextStyle(color: colorScheme.outline, fontSize: 12.sp),
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: colorScheme.outlineVariant,
            size: 34.sp,
          ),
        ),
        Divider(
          color: colorScheme.outlineVariant,
        ),
        ListTile(
          title: Text(
            "Settings",
            style: TextStyle(
                color: colorScheme.onSecondary,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500),
          ),
          subtitle: Text(
            "Notifications,Password",
            style: TextStyle(color: colorScheme.outline, fontSize: 12.sp),
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: colorScheme.outlineVariant,
            size: 34.sp,
          ),
        ),
      ],
    );
  }

  void showLogoutDialog(BuildContext context, ColorScheme colorScheme) {
    Get.dialog(
      CommonDialog(
        title: 'Sign Out',
        message: 'Are you sure you want to sign out?',
        confirmText: 'Sign Out',
        onConfirm: () async {
          await FirebaseAuth.instance.signOut();
          final prefs = await SharedPreferences.getInstance();
          await prefs.clear();
          Get.offAllNamed(AppRoutes.login);
        },
      ),
    );
  }
}
