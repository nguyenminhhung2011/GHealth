import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../global_widgets/buttonMain.dart';
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
              Spacer(),
              Image.asset(
                'assets/images/intro.png',
                height: 200,
                width: 200,
              ),
              Text.rich(
                TextSpan(
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 23,
                  ),
                  children: [
                    TextSpan(
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
              Text(
                'Everybody Can Train',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 11,
                ),
              ),
              Spacer(),
              ButtonDesign(title: 'Get started', press: () {}),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
