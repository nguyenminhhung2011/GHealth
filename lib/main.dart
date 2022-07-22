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
      theme: ThemeData(primaryColor: AppColors.mainColor),
      initialRoute: RouteName.splash,
      getPages: AppPages.pages,
      home: SplashCreen(),
    );
  }
}
