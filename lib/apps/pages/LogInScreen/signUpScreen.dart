import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/LoginControls.dart';
import 'package:gold_health/apps/controls/signUpControls.dart';
import 'package:gold_health/apps/global_widgets/buttonIcon.dart';
import 'package:gold_health/apps/global_widgets/passwordField.dart';
import 'package:gold_health/apps/pages/basic_info_screen/appBarHello.dart';

import '../../global_widgets/buttonMain.dart';
import '../../global_widgets/texField.dart';
import '../../template/misc/colors.dart';

class SignUpScreen extends StatelessWidget {
  final signUpC = Get.find<SignUpC>();
  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppBarHello(widthDevice: widthDevice),
                Hero(
                  child: Image.asset(
                    'assets/gift/Workout1.gif',
                    height: heightDevice / 2,
                    width: heightDevice / 2,
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
                          fontSize: 15,
                        ),
                      ),
                      tag: 'create tag',
                    ),
                    Text(
                      'Let\'s create account to using this app',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
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
                            fontSize: 15,
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
