import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:gold_health/apps/pages/IntroListScreen/splashScreen.dart';
import 'package:gold_health/apps/routes/appPages.dart';

import 'apps/routes/routeName.dart';
import 'apps/template/misc/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyB-Vpk9jAOQdpGCdFNHnypbKfLKAohmmb8',
        appId: '1:919952547196:web:01fe16a0e89098efb198f9',
        messagingSenderId: '919952547196',
        projectId: 'gold-health-2246a',
        storageBucket: 'gold-health-2246a.appspot.com',
        authDomain: "gold-health-2246a.firebaseapp.com",
        databaseURL:
            "https://gold-health-2246a-default-rtdb.asia-southeast1.firebasedatabase.app",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.mainColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: "Sen",
        textTheme: const TextTheme(
          //Normal text (info,notice,...)
          headline5: TextStyle(
            color: Colors.black54,
            fontSize: 15,
          ),
          //Title
          headline4: TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          headline6: TextStyle(
            color: Colors.black12,
            fontSize: 18,
          ),
        ),
      ),
      initialRoute: RouteName.splash,
      getPages: AppPages.pages,
      home: const SplashScreen(),
    );
  }
}
