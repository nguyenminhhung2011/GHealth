import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/pages/IntroListScreen/introScreen.dart';

import '../../global_widgets/buttonMain.dart';
import '../../routes/routeName.dart';
import '../../template/misc/colors.dart';
import '../../pages/basic_info_screen/select_gender_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Hero(
                  child: Image.asset(
                    'assets/images/intro.png',
                    height: 200,
                    width: 200,
                  ),
                  tag: 'Splash image'),
              Text.rich(
                TextSpan(
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                  ),
                  children: [
                    const TextSpan(
                      text: 'GHealth ',
                      style: TextStyle(color: AppColors.primaryColor),
                    ),
                    TextSpan(
                      text: 'App',
                      style: TextStyle(color: AppColors.textColor),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              const Text(
                'Everybody Can Train',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 11,
                ),
              ),
              const Spacer(),
              ButtonDesign(
                title: 'Get started',
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => IntroScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
