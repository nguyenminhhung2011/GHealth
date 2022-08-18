import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/sign_up_controller.dart';
import 'package:gold_health/apps/global_widgets/text_field_custom/password_field.dart';

import '../../global_widgets/button_custom/button_icon.dart';
import '../../global_widgets/text_field_custom/text_field.dart';
import '../../template/misc/colors.dart';
import '../basic_info_screen/app_bar_hero.dart';

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
                  tag: 'Image auth',
                  child: Image.asset(
                    'assets/gift/Workout1.gif',
                    height: heightDevice / 2,
                    width: heightDevice / 2,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Hero(
                      tag: 'create tag',
                      child: Text(
                        'Create your Account',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
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
                        press: () => signUpC.ContinueBtnClick(),
                        icon: const SizedBox(width: 20),
                        title: const Text(
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
