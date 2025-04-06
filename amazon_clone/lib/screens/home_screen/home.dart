import 'package:amazon_clone/common_widgets/exit_dialogue.dart';
import 'package:amazon_clone/consts/consts.dart';
import 'package:amazon_clone/routes/app_routes.dart';
import 'package:amazon_clone/screens/cart_screen/cart_screen.dart';
import 'package:amazon_clone/screens/categories_screen/categories_screen.dart';
import 'package:amazon_clone/screens/home_screen/contoller/home_controller.dart';
import 'package:amazon_clone/screens/home_screen/home_screen.dart';
import 'package:amazon_clone/screens/profile%20screen/profile_screen.dart';
import 'package:amazon_clone/screens/wishlist_screen/wishlist_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Home extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    //init home controller
    var controller = Get.put(HomeController());

    final List<Map<String, String>> tabs = [
      {'label': 'Home', 'icon': icHome},
      {'label': 'Wishlist', 'icon': icHeart},
      {'label': 'Cart', 'icon': icCart},
      {'label': 'Categories', 'icon': icCategories},
      {'label': 'Profile', 'icon': icProfile},
    ];

    var navBody = [
      const HomeScreen(),
      const WishlistScreen(),
      const CartScreen(),
      const CategoriesScreen(),
      const ProfileScreen()
    ];

    return WillPopScope(
      onWillPop: () async {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => exitDialog(context));
        return false;
      },
      child: Scaffold(
        body: Center(
            child:
                Obx(() => navBody.elementAt(controller.currentNavIndex.value))),
        bottomNavigationBar: Obx(
          () => Container(
            color: colorScheme.onPrimary,
            padding: EdgeInsets.symmetric(vertical: 8.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(tabs.length, (index) {
                final isSelected = controller.currentNavIndex.value == index;
                return GestureDetector(
                  onTap: () {
                    controller.currentNavIndex.value = index;
                  },
                  child: Container(
                    width: 60.w,
                    height: 55.h,
                    decoration: BoxDecoration(
                      color:
                          isSelected ? colorScheme.primary : Colors.transparent,
                      shape: BoxShape.circle,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          tabs[index]['icon']!,
                          width: 20.w,
                          height: 20.h,
                          color: isSelected ? Colors.white : Colors.black,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          tabs[index]['label']!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: semibold,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
