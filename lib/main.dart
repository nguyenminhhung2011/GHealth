import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:gold_health/apps/controls/AuthControls.dart';
import 'package:gold_health/apps/pages/IntroListScreen/splashScreen.dart';
import 'package:gold_health/apps/routes/appPages.dart';
import 'package:gold_health/services/startServices.dart';

import 'apps/routes/routeName.dart';
import 'apps/template/misc/colors.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

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
    ).then((value) {
      Get.put(AuthC());
    });
  } else {
    StartService.instance.init();
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
        textTheme: TextTheme(
          headline1: const TextStyle(
            fontFamily: 'Sen',
            fontSize: 15,
            color: Colors.black38,
          ),
          //For number home_screen
          headline2: TextStyle(
            fontFamily: 'Sen',
            fontSize: 23,
            fontWeight: FontWeight.w600,
            foreground: Paint()
              ..shader = LinearGradient(colors: [
                const Color.fromARGB(255, 199, 231, 247),
                Colors.blue[200]!,
                Colors.blue[300]!,
                Colors.blue[400]!,
                Colors.blue[500]!,
              ]).createShader(
                const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
              ),
          ),

          //For home_screen
          headline3: const TextStyle(
            fontFamily: 'Sen',
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          //Title
          headline4: const TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          //Normal text (info,notice,...)
          headline5: const TextStyle(
            color: Colors.black54,
            fontSize: 15,
          ),

          headline6: const TextStyle(
            color: Colors.black26,
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
