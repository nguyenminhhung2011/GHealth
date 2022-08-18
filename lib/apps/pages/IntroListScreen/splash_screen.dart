import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../global_widgets/button_custom/button_main.dart';
import '../../routes/route_name.dart';
import '../../template/misc/colors.dart';

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
                tag: 'Splash image',
                child: Image.asset(
                  'assets/images/intro.png',
                  height: 200,
                  width: 200,
                ),
              ),
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
                  Get.toNamed(RouteName.intro);
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
