import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/LoginControls.dart';
import 'package:gold_health/apps/global_widgets/buttonIcon.dart';
import 'package:gold_health/apps/global_widgets/passwordField.dart';

import '../../global_widgets/buttonMain.dart';
import '../../global_widgets/texField.dart';
import '../../routes/routeName.dart';
import '../../template/misc/colors.dart';
import '../basic_info_screen/appBarHello.dart';
import '../basic_info_screen/select_gender_screen.dart';

class LogInScreen extends StatelessWidget {
  final logInC = Get.find<LogInC>();
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
              children: [
                AppBarHello(widthDevice: widthDevice),
                Hero(
                  child: Image.asset(
                    'assets/gift/Workout1.gif',
                    height: heightDevice / 3,
                    width: heightDevice / 3,
                  ),
                  tag: 'Image auth',
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Log in to your account',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      'This import will save your training and nutrition progress',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
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
                        control: logInC.emailC,
                        icon: Icons.person,
                      ),
                      const SizedBox(height: 10),
                      PasswordField(
                        hintText: 'Enter your password',
                        labelText: 'Password',
                        control: logInC.passC,
                      ),
                      const SizedBox(height: 10),
                      btnIcon(
                        color: AppColors.primaryColor,
                        press: () {
                          Get.toNamed(RouteName.selectGender);
                        },
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
                      const SizedBox(height: 10),
                      Text(
                        'Except',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: AppColors.primaryColor,
                          fontSize: 10,
                        ),
                      ),
                      const SizedBox(height: 10),
                      btnIcon(
                        color: Colors.white,
                        press: () {},
                        icon: Image.asset(
                          'assets/images/google.png',
                          height: 10,
                          width: 10,
                        ),
                        title: Text(
                          'LogIn with google',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      btnIcon(
                        color: Colors.blue,
                        press: () {},
                        icon: Icon(
                          Icons.facebook,
                          size: 15,
                          color: Colors.white,
                        ),
                        title: Text(
                          'LogIn with facebook',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          Get.toNamed(RouteName.signUp);
                        },
                        child: Hero(
                          child: Text(
                            'Create your account',
                            style: TextStyle(
                              decoration: TextDecoration.underline,
                              color: Colors.grey,
                              fontSize: 10,
                            ),
                          ),
                          tag: 'Create tag',
                        ),
                      )
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
