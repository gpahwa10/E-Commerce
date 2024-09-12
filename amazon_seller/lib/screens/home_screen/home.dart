import 'package:amazon_seller/const/const.dart';
import 'package:amazon_seller/const/images.dart';
import 'package:amazon_seller/controller/home_controller.dart';
import 'package:amazon_seller/screens/dashboard/dashboard_screen.dart';
import 'package:amazon_seller/screens/orders/order_screen.dart';
import 'package:amazon_seller/screens/products/product_screen.dart';
import 'package:amazon_seller/screens/settings/setting_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    var navScreens = [
      const DashboardScreen(),
      const ProductScreen(),
      const OrderScreen(),
      const SettingsScreen()
    ];

    var bottomNavBar = [
      const BottomNavigationBarItem(
          icon: Icon(Icons.home, color: darkGrey, size: 24), label: dashboard),
      BottomNavigationBarItem(
          icon: Image.asset(imgProducts, color: darkGrey, width: 24),
          label: product),
      BottomNavigationBarItem(
          icon: Image.asset(imgOrders, color: darkGrey, width: 24),
          label: orders),
      BottomNavigationBarItem(
          icon: Image.asset(imggGenSettings, color: darkGrey, width: 24),
          label: settings)
    ];

    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          onTap: (index) {
            controller.navIndex.value = index;
          },
          type: BottomNavigationBarType.fixed,currentIndex: controller.navIndex.value,
          items: bottomNavBar,
          selectedItemColor: purpleColor,
          unselectedItemColor: darkGrey,
        ),
      ),
      body: Obx(() =>
          navScreens.elementAt(controller.navIndex.value)),
    );
  }
}