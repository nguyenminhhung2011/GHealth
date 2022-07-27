import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gold_health/apps/global_widgets/GradientText.dart';
import 'package:gold_health/apps/global_widgets/gradientIcon..dart';
import 'package:gold_health/apps/pages/dashboard/activity_trackerScreen.dart';

import '../../global_widgets/CustomSwitch .dart';
import '../../template/misc/colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool val = true;
  onChange(bool newValue) {
    setState(() {
      val = newValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;
    return Column(
      children: [
        const SizedBox(height: 24),
        Expanded(
          flex: (heightDevice / 20 * 2).round(),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.primaryColor.withOpacity(0.2),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Profile',
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                          fontSize: 18,
                          fontFamily: "Sen",
                        ),
                  ),
                  Spacer(),
                  SizedBox(width: 40),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: (heightDevice / 20 * 4).round(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        width: 70,
                        height: 70,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'assets/images/avatar.png',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Masi Ramezanzade',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            'Lose a Fat Program',
                            style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.w500,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      ButtonIconGradientColor(
                        title: 'Edit',
                        icon: Icons.edit,
                        press: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      InforCard(title: 'Height', data: '180cm'),
                      Spacer(),
                      InforCard(title: 'Weight', data: '65Kg'),
                      Spacer(),
                      InforCard(title: 'Age', data: '22yo'),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: (heightDevice / 20 * 13).round(),
          child: Container(
              child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 20),
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          offset: const Offset(2, 3),
                          blurRadius: 20,
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          offset: Offset(-2, -3),
                          blurRadius: 20,
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Account',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ButtonSvgIcon(
                          title: 'Personal Data',
                          iconPath: 'assets/icons/Profile.svg',
                          press: () {},
                        ),
                        const SizedBox(height: 10),
                        ButtonSvgIcon(
                          title: 'Achievement',
                          iconPath: 'assets/icons/Document.svg',
                          press: () {},
                        ),
                        const SizedBox(height: 10),
                        ButtonSvgIcon(
                          title: 'Activity History',
                          iconPath: 'assets/icons/Graph.svg',
                          press: () {},
                        ),
                        const SizedBox(height: 10),
                        ButtonSvgIcon(
                          title: 'Workout Progress',
                          iconPath: 'assets/icons/Chart.svg',
                          press: () {},
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 20),
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          offset: const Offset(2, 3),
                          blurRadius: 20,
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          offset: Offset(-2, -3),
                          blurRadius: 20,
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Notification',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            GradientIcon(
                              SvgPicture.asset(
                                'assets/icons/Notification.svg',
                                color: Colors.white,
                              ),
                              20,
                              AppColors.colorGradient,
                            ),
                            const SizedBox(width: 10),
                            const Text(
                              'Pop-up Notification',
                              style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 16,
                              ),
                            ),
                            const Spacer(),
                            // CustomSwitch(
                            //   activeColor: AppColors.primaryColor1,
                            //   value: val,
                            //   onChanged: (value) {
                            //     setState(() {
                            //       val = value;
                            //     });
                            //   },
                            //   activeText: '',
                            //   activeTextColor: Colors.black,
                            //   inactiveColor: AppColors.primaryColor1,
                            //   inactiveText: '',
                            //   inactiveTextColor: AppColors.primaryColor2,
                            // ),
                            ToggleButtonIos(val: val),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 20),
                    decoration: BoxDecoration(
                      color: AppColors.mainColor,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          offset: const Offset(2, 3),
                          blurRadius: 20,
                        ),
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          offset: Offset(-2, -3),
                          blurRadius: 20,
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Other',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ButtonSvgIcon(
                          title: 'Contact Us',
                          iconPath: 'assets/icons/Message.svg',
                          press: () {},
                        ),
                        const SizedBox(height: 10),
                        ButtonSvgIcon(
                          title: 'Privacy Policy',
                          iconPath: 'assets/icons/Shield Done.svg',
                          press: () {},
                        ),
                        const SizedBox(height: 10),
                        ButtonSvgIcon(
                          title: 'Settings',
                          iconPath: 'assets/icons/Setting.svg',
                          press: () {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          )),
        )
      ],
    );
  }
}

class ToggleButtonIos extends StatefulWidget {
  ToggleButtonIos({Key? key, required this.val}) : super(key: key);
  bool val;
  @override
  State<ToggleButtonIos> createState() => _ToggleButtonIosState();
}

class _ToggleButtonIosState extends State<ToggleButtonIos> {
  @override
  Widget build(BuildContext context) {
    return CupertinoSwitch(
      activeColor: AppColors.primaryColor1,
      value: widget.val,
      onChanged: (bool value) {
        setState(() {
          widget.val = value;
        });
      },
    );
  }
}

class ButtonSvgIcon extends StatelessWidget {
  final String title;
  final String iconPath;
  final Function() press;
  const ButtonSvgIcon({
    Key? key,
    required this.title,
    required this.iconPath,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15),
      onTap: press,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: Row(
          children: [
            GradientIcon(
              SvgPicture.asset(
                iconPath,
                color: Colors.white,
              ),
              20,
              AppColors.colorGradient,
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_forward_ios_sharp,
              size: 18,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}

class InforCard extends StatelessWidget {
  final String title;
  final String data;
  const InforCard({
    Key? key,
    required this.title,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(2, 3),
            blurRadius: 20,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: Offset(-2, -3),
            blurRadius: 20,
          )
        ],
      ),
      child: Column(
        children: [
          GradientText(
            data,
            gradient: AppColors.colorGradient,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontSize: 17,
            ),
          ),
        ],
      ),
    );
  }
}
