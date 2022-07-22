import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/LoginControls.dart';
import 'package:gold_health/apps/controls/signUpControls.dart';
import 'package:gold_health/apps/global_widgets/buttonIcon.dart';
import 'package:gold_health/apps/global_widgets/passwordField.dart';

import '../../global_widgets/buttonMain.dart';
import '../../global_widgets/texField.dart';
import '../../template/misc/colors.dart';

class SignUpScreen extends StatelessWidget {
  final signUpC = Get.find<SignUpC>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  child: Image.asset(
                    'assets/gift/Workout1.gif',
                    height: 220,
                    width: 220,
                  ),
                  tag: 'Image auth',
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Hero(
                      child: Text(
                        'Create your Account',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      tag: 'create tag',
                    ),
                    Text(
                      'Let\'s create account to using this app',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        offset: Offset(2, 3),
                        blurRadius: 2,
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        offset: Offset(-2, -3),
                        blurRadius: 2,
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      TextFormFieldDesgin(
                        hintText: 'Enter your username',
                        labelText: 'Username',
                        control: signUpC.emailC,
                        icon: Icons.person,
                      ),
                      const SizedBox(height: 10),
                      PasswordField(
                        hintText: 'Enter your password',
                        labelText: 'Password',
                        control: signUpC.passC,
                      ),
                      const SizedBox(height: 10),
                      PasswordField(
                        hintText: 'Enter password again',
                        labelText: 'Re-password',
                        control: signUpC.repassC,
                      ),
                      const SizedBox(height: 20),
                      btnIcon(
                        color: AppColors.primaryColor,
                        press: () {},
                        icon: SizedBox(width: 20),
                        title: Text(
                          'Continue',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
