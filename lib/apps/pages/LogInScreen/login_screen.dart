import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/login_controller.dart';
import 'package:gold_health/apps/global_widgets/text_field_custom/password_field.dart';

import '../../global_widgets/button_custom/button_icon.dart';
import '../../global_widgets/dialog/error_dialog.dart';
import '../../global_widgets/text_field_custom/text_field.dart';
import '../../routes/route_name.dart';
import '../../template/misc/colors.dart';
import '../basic_info_screen/app_bar_hero.dart';
import '../../controls/auth_controller.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final logInC = Get.find<LogInC>();
  final _authController = Get.find<AuthC>();
  bool isLoading = false;
  @override
  void logIn() async {
    if (logInC.emailC.text.isNotEmpty && logInC.passC.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      final response = await _authController.signInWithEmailAndPassword(
          username: logInC.emailC.text, password: logInC.passC.text);
      if (response != null) {
        Get.offAllNamed(RouteName.dashboardScreen);
      }
      setState(() {
        isLoading = false;
      });
    } else {
      Get.dialog(
        const ErrorDialog(question: 'Log In', title1: 'Field is not null'),
      );
    }
  }

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
              children: [
                AppBarHello(widthDevice: widthDevice),
                Hero(
                  tag: 'Image auth',
                  child: Image.asset(
                    'assets/gift/Workout1.gif',
                    height: heightDevice / 3,
                    width: heightDevice / 3,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
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
                        offset: const Offset(2, 3),
                        blurRadius: 2,
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        offset: const Offset(-2, -3),
                        blurRadius: 2,
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      TextFormFieldDesign(
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
                      (!isLoading)
                          ? btnIcon(
                              color: AppColors.primaryColor,
                              press: () => logIn(),
                              icon: const SizedBox(width: 20),
                              title: const Text(
                                'Continue',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                              ),
                            )
                          : Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    offset: const Offset(2, 3),
                                    blurRadius: 2,
                                  ),
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    offset: const Offset(-2, -3),
                                    blurRadius: 2,
                                  )
                                ],
                              ),
                              child: const Center(
                                child: CircularProgressIndicator(
                                    color: Colors.white),
                              ),
                            ),
                      const SizedBox(height: 10),
                      const Text(
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
                        press: () async {
                          final response =
                              await _authController.signInWithGoogle();
                          final user = response.user;
                          print(user?.displayName);
                          print(user?.email);
                          print(user?.emailVerified);
                        },
                        icon: Image.asset(
                          'assets/images/google.png',
                          height: 13,
                          width: 13,
                        ),
                        title: const Text(
                          'LogIn with google',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      btnIcon(
                        color: Colors.blue,
                        press: () async {
                          final response =
                              await _authController.signInWithFacebook();
                          final user = response?.user;
                          print(user?.displayName);
                          print(user?.email);
                          print(user?.emailVerified);
                        },
                        icon: const Icon(
                          Icons.facebook,
                          size: 18,
                          color: Colors.white,
                        ),
                        title: const Text(
                          'LogIn with facebook',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 20,
                        width: double.infinity,
                        child: Center(
                          child: InkWell(
                            onTap: () {
                              Get.toNamed(RouteName.signUp);
                            },
                            child: const Hero(
                              tag: 'Create tag',
                              child: Text(
                                'Create your account',
                                style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
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
