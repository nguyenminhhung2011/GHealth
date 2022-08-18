import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gold_health/apps/global_widgets/gradient_text.dart';
import 'package:gold_health/apps/global_widgets/gradient_icon..dart';
import 'package:gold_health/apps/global_widgets/screen_template.dart';
import 'package:gold_health/apps/pages/dashboard/activity_trackerScreen.dart';
import 'package:gold_health/apps/pages/dashboard/contact_us_screen.dart';
import 'package:gold_health/apps/pages/dashboard/setting_screen.dart';
import 'package:gold_health/apps/pages/dashboard/widgets/activity_histor_dialog.dart';
import 'package:gold_health/apps/pages/dashboard/widgets/target_data_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../global_widgets/button_custom/Button_icon_gradient_color.dart';
import '../../global_widgets/toggle_button_ios.dart';
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
    // var heightDevice = MediaQuery.of(context).size.height;
    // var widthDevice = MediaQuery.of(context).size.width;
    return Scaffold(
      body: ScreenTemplate(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              SizedBox(
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
                        child: const Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Hero(
                      tag: 'Hero tag',
                      child: Text(
                        'Profile',
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              fontSize: 18,
                              fontFamily: "Sen",
                            ),
                      ),
                    ),
                    const Spacer(),
                    const SizedBox(width: 40),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 70,
                          height: 70,
                          decoration: const BoxDecoration(
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
                          children: const [
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
                        const Spacer(),
                        ButtonIconGradientColor(
                          title: 'Edit',
                          icon: Icons.edit,
                          press: () {},
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Hero(
                      tag: 'Basic data tag',
                      child: Row(
                        children: const [
                          InforCard(title: 'Height', data: '180cm'),
                          Spacer(),
                          InforCard(title: 'Weight', data: '65Kg'),
                          Spacer(),
                          InforCard(title: 'Age', data: '22yo'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Column(
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
                          offset: const Offset(-2, -3),
                          blurRadius: 20,
                        )
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Account',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(height: 20),
                        ButtonSvgIcon(
                          title: 'Target Data',
                          iconPath: 'assets/icons/Profile.svg',
                          press: () async {
                            await showDialog(
                              useRootNavigator: false,
                              barrierColor: Colors.black54,
                              context: context,
                              builder: (context) => TargetDataDialog(),
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        ButtonSvgIcon(
                          title: 'Activity History',
                          iconPath: 'assets/icons/Graph.svg',
                          press: () async {
                            await showDialog(
                              useRootNavigator: false,
                              barrierColor: Colors.black54,
                              context: context,
                              builder: (context) => ActivityHistory(),
                            );
                          },
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
                          offset: const Offset(-2, -3),
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
                          offset: const Offset(-2, -3),
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
                          press: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ContactUsScren(),
                                ));
                          },
                        ),
                        const SizedBox(height: 10),
                        ButtonSvgIcon(
                          title: 'Settings',
                          iconPath: 'assets/icons/Setting.svg',
                          press: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const SettingScreen(),
                                ));
                          },
                        ),
                        const SizedBox(height: 10),
                        ButtonSvgIcon(
                          title: 'See more',
                          iconPath: 'assets/icons/Document.svg',
                          press: () async {
                            const url =
                                'https://github.com/minhunsocute/GHealth';
                            // ignore: deprecated_member_use
                            if (await canLaunch(url)) {
                              // ignore: deprecated_member_use
                              await launch(url);
                            }
                          },
                        ),
                        const SizedBox(height: 10),
                        ButtonSvgIcon(
                          title: 'Sign Out',
                          iconPath: 'assets/icons/Logout.svg',
                          press: () {},
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              )
            ],
          ),
        ),
      ),
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
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const Spacer(),
            const Icon(
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
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
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