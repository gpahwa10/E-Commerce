import 'package:amazon_seller/const/const.dart';
import 'package:amazon_seller/screens/auth_screen/login_screeen.dart';
import 'package:amazon_seller/screens/home_screen/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyCaHzanXZmSipudHiUPC9hp93EBcFDUC6g',
          appId: '1:235721414114:android:3458c0b34f449d7357d5bb',
          messagingSenderId: '235721414114',
          projectId: 'e-mart-eb936',
          storageBucket: 'gs://e-mart-eb936.appspot.com'
          ));
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    checkUser();
    super.initState();
  }

  var isLoggedIn = false;

  checkUser() async {
    auth.authStateChanges().listen((User? user) {
      if (user == null && mounted) {
        isLoggedIn = false;
      } else {
        isLoggedIn = true;
      }
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(backgroundColor: Colors.transparent)),
      home: isLoggedIn ? const Home() : const LoginScreen(),
    );
  }
}