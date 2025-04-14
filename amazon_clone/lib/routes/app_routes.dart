import 'package:amazon_clone/screens/auth_screens/binding/auth_screen_binding.dart';
import 'package:amazon_clone/screens/auth_screens/forget_password.dart';
import 'package:amazon_clone/screens/auth_screens/login_screen.dart';
import 'package:amazon_clone/screens/auth_screens/new_user_screen.dart';
import 'package:amazon_clone/screens/cart_screen/cart_screen.dart';
import 'package:amazon_clone/screens/cart_screen/shipping_screen.dart';
import 'package:amazon_clone/screens/categories_screen/categories_screen.dart';
import 'package:amazon_clone/screens/home_screen/binding/home_binding.dart';
import 'package:amazon_clone/screens/home_screen/home_screen.dart';
import 'package:amazon_clone/screens/orders_screen/order_screen.dart';
import 'package:amazon_clone/screens/profile%20screen/binding/profile_screen_binding.dart';
import 'package:amazon_clone/screens/splash_screen.dart';
import 'package:amazon_clone/screens/wishlist_screen/wishlist_screen.dart';
import 'package:get/get.dart';

import '../screens/home_screen/home.dart';
import '../screens/profile screen/profile_screen.dart';

class AppRoutes {
  static const String initialRoute = '/';
  static const String login = '/login';
  static const String newUser = '/new_user_register';
  static const String home = '/home';
  static const String homeView = '/homeView';
  static const String forgetPassword = '/forget_password';
  static const String profileView = '/profile_view';
  static const String cartView = '/cart_view';
  static const String categoriesView = '/categories_view';
  static const String wishlistView = '/wishlist_view';
  static const String shippingView = '/shipping_view';
  static const String ordersView = '/orders_view';

  static List<GetPage> routes = [
    GetPage(
      name: initialRoute,
      page: () => const SplashScren(),
    ),
    GetPage(name: login, page: () => LoginScreen(),binding:AuthBinding()),
    GetPage(name: newUser, page: ()=>SignUpScreen(),binding:AuthBinding()),
    GetPage(name: home, page: ()=>Home(),binding:HomeBinding()),
    GetPage(name: homeView, page: ()=>const HomeScreen(),binding: HomeBinding()),
    GetPage(name: forgetPassword, page: ()=>const ForgetPassword()),
    GetPage(name: profileView, page: ()=> const ProfileScreen(),binding: ProfileScreenBinding()),
    GetPage(name: cartView, page: ()=> const CartScreen()),
    GetPage(name: categoriesView, page: ()=> const CategoriesScreen()),
    GetPage(name: shippingView, page: ()=> const ShippingScreen()),
    GetPage(name: ordersView, page: ()=> const OrderScreen()),
  ];
}
