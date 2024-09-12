import 'package:amazon_clone/consts/consts.dart';
import 'package:amazon_clone/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

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
    //changing MaterialApp to GetMaterialApp
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(
          iconTheme: const IconThemeData(color: darkFontGrey),
          scaffoldBackgroundColor: Colors.transparent,
          appBarTheme: const AppBarTheme(color: Colors.transparent),
          fontFamily: regular),
      home: const SplashScren(),
    );
  }
}
