import 'package:amazon_clone/consts/consts.dart';
import 'package:amazon_clone/routes/app_routes.dart';
import 'package:amazon_clone/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
    apiKey: 'AIzaSyCaHzanXZmSipudHiUPC9hp93EBcFDUC6g',
    appId: '1:235721414114:android:069e34866241c6d857d5bb',
    messagingSenderId: '235721414114',
    projectId: 'e-mart-eb936',
    storageBucket: 'gs://e-mart-eb936.appspot.com',
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
      child: ScreenUtilInit(
        minTextAdapt: true,
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: ThemeMode.light,
          initialRoute: AppRoutes.initialRoute,
          getPages: AppRoutes.routes,
          // home: SplashScren(),
        ),
      ),
    );
  }
}
