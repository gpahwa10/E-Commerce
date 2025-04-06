import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../../consts/consts.dart';
import '../../../routes/app_routes.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final List<Map<String, String>> tabs = [
      {'label': 'Home', 'icon': icHome},
      {'label': 'Wishlist', 'icon': icHeart},
      {'label': 'Cart', 'icon': icCart},
      {'label': 'Categories', 'icon': icCategories},
      {'label': 'Profile', 'icon': icProfile},
    ];
    final selectedIndex = 1;
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.onPrimary,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(tabs.length, (index) {
          final isSelected = selectedIndex == index;
          return GestureDetector(
            onTap: () {
              final label = tabs[index]['label'];
              if (label == 'Home') {
                Get.toNamed(AppRoutes.homeView);
              } else if (label == 'Wishlist') {
                // Get.toNamed();
              }else if (label == 'Cart') {
                Get.toNamed(AppRoutes.cartView);
              }else if (label == 'Categories') {
                Get.toNamed(AppRoutes.categoriesView);
              }else if (label == 'Profile') {
                Get.toNamed(AppRoutes.profileView);
              }
            },
            child: Container(
              width: 60.w,
              height: 55.h,
              decoration: BoxDecoration(
                color: isSelected ? Colors.green : Colors.transparent,
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
                      color: isSelected
                          ? colorScheme.onPrimary
                          : colorScheme.outline,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
