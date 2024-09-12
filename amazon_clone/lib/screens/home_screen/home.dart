import 'package:amazon_clone/common_widgets/exit_dialogue.dart';
import 'package:amazon_clone/consts/consts.dart';
import 'package:amazon_clone/controller/home_controller.dart';
import 'package:amazon_clone/screens/cart_screen/cart_screen.dart';
import 'package:amazon_clone/screens/categories_screen/categories_screen.dart';
import 'package:amazon_clone/screens/home_screen/home_screen.dart';
import 'package:amazon_clone/screens/profile%20screen/profile_screen.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    //init home controller
    var controller = Get.put(HomeController());

    // ignore: non_constant_identifier_names
    var NavBarItem = [
      BottomNavigationBarItem(
          icon: Image.asset(icHome, width: 26), label: "Home"),
      BottomNavigationBarItem(
          icon: Image.asset(icCategories, width: 26), label: "Categories"),
      BottomNavigationBarItem(
          icon: Image.asset(icCart, width: 26), label: "Cart"),
      BottomNavigationBarItem(
          icon: Image.asset(icProfile, width: 26), label: "Profile"),
    ];

    var navBody = [
      const HomeScreen(),
      const CategoriesScreen(),
      const CartScreen(),
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
          () => BottomNavigationBar(
            currentIndex: controller.currentNavIndex.value,
            selectedItemColor: redColor,
            selectedLabelStyle: const TextStyle(fontFamily: semibold),
            items: NavBarItem,
            type: BottomNavigationBarType.fixed,
            backgroundColor: whiteColor,
            onTap: (value) {
              controller.currentNavIndex.value = value;
            },
          ),
        ),
      ),
    );
  }
}
