import 'package:flutter/material.dart';
import 'package:gold_health/IntroductionScreen.dart';
import 'package:gold_health/res/MyColors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: MyColor.primary,
      ),
      home: IntroductionScreen(),
    );
  }
}
