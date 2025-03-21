import 'package:amazon_clone/screens/auth_screens/binding/auth_screen_binding.dart';
import 'package:amazon_clone/screens/auth_screens/login_screen.dart';
import 'package:amazon_clone/screens/auth_screens/new_user_screen.dart';
import 'package:amazon_clone/screens/home_screen/binding/home_binding.dart';
import 'package:amazon_clone/screens/splash_screen.dart';
import 'package:get/get.dart';

import '../screens/home_screen/home.dart';

class AppRoutes {
  static const String initialRoute = '/';
  static const String login = '/login';
  static const String newUser = '/new_user_register';
  static const String home = '/home';

  static List<GetPage> routes = [
    GetPage(
      name: initialRoute,
      page: () => const SplashScren(),
    ),
    GetPage(name: login, page: () => LoginScreen(),binding:AuthBinding()),
    GetPage(name: newUser, page: ()=>SignUpScreen(),binding:AuthBinding()),
    GetPage(name: home, page: ()=>const Home(),binding:HomeBinding())
  ];
}
