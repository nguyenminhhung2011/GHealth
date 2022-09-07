import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/auth_controller.dart';
import 'package:gold_health/apps/controls/profile_controller.dart';
import 'package:gold_health/apps/global_widgets/gradient_text.dart';
import 'package:gold_health/apps/global_widgets/gradient_icon..dart';
import 'package:gold_health/apps/global_widgets/screen_template.dart';
import 'package:gold_health/apps/global_widgets/text_field_custom/text_field_icon.dart';
import 'package:gold_health/apps/pages/dashboard/contact_us_screen.dart';
import 'package:gold_health/apps/pages/dashboard/setting_screen.dart';
import 'package:gold_health/apps/pages/dashboard/widgets/activity_histor_dialog.dart';
import 'package:gold_health/apps/pages/dashboard/widgets/target_data_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../global_widgets/button_custom/Button_icon_gradient_color.dart';
import '../../global_widgets/toggle_button_ios.dart';
import '../../template/misc/colors.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _controller = Get.find<ProfileC>();
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
      body: Obx(
        () => _controller.user == {}
            ? const Center(
                child:
                    CircularProgressIndicator(color: AppColors.primaryColor1))
            : Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: (_controller.user['avtPath'] != null)
                        ? Image.network(
                            _controller.user['avtPath'],
                            fit: BoxFit.cover,
                            height: Get.mediaQuery.size.height * 0.4,
                            width: double.infinity,
                          )
                        : Image.asset('assets/images/avatar.png'),
                  ),
                  ScreenTemplate(
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
                                      color: AppColors.primaryColor1,
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
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(
                                          fontSize: 20,
                                          fontFamily: "Sen",
                                          color: Colors.white,
                                        ),
                                  ),
                                ),
                                const Spacer(),
                                const SizedBox(width: 40),
                              ],
                            ),
                          ),
                          const SizedBox(height: 60),
                          SizedBox(
                            child: Column(
                              children: [
                                Badge(
                                  position: BadgePosition.topStart(
                                    top: -45,
                                    start:
                                        (Get.mediaQuery.size.width - 40) / 2 -
                                            55,
                                  ),
                                  badgeColor: Colors.white,
                                  padding: const EdgeInsets.all(10),
                                  stackFit: StackFit.passthrough,
                                  elevation: 0,
                                  badgeContent:
                                      (_controller.user['avtPath'] == null)
                                          ? Container(
                                              width: 90,
                                              height: 90,
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: AssetImage(
                                                    'assets/images/avatar.png',
                                                  ),
                                                ),
                                              ),
                                            )
                                          : Container(
                                              width: 90,
                                              height: 90,
                                              decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                    _controller.user['avtPath'],
                                                  ),
                                                ),
                                              ),
                                            ),
                                  child: Container(
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
                                      children: [
                                        const SizedBox(height: 40),
                                        Row(
                                          children: [
                                            const SizedBox(width: 10),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  _controller.user['name'] ??
                                                      "Name",
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                                const Text(
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
                                              press: () async {
                                                int heightValue =
                                                    _controller.user['height'];
                                                int weightValue =
                                                    _controller.user['weight'];
                                                final r = showDialog(
                                                  useRootNavigator: false,
                                                  barrierColor: Colors.black54,
                                                  context: context,
                                                  builder: (context) =>
                                                      DialogEditProfile(
                                                    hegithValue: heightValue,
                                                    weightValue: weightValue,
                                                    controller: _controller,
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 15),
                                        Hero(
                                          tag: 'Basic data tag',
                                          child: Row(
                                            children: [
                                              InforCard(
                                                  title: 'Height',
                                                  data:
                                                      '${_controller.user['height']}cm'),
                                              const Spacer(),
                                              InforCard(
                                                  title: 'Weight',
                                                  data:
                                                      '${_controller.user['weight']}Kg'),
                                              const Spacer(),
                                              const InforCard(
                                                title: 'Age',
                                                data: '${20}yo',
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
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
                                          builder: (context) =>
                                              TargetDataDialog(
                                            currentHeight: _controller
                                                .user['height']
                                                .toDouble(),
                                            currentWeight: _controller
                                                .user['weight']
                                                .toDouble(),
                                            heightTarget: _controller
                                                .user['heightTarget']
                                                .toDouble(),
                                            weightTarget: _controller
                                                .user['weightTarget']
                                                .toDouble(),
                                          ),
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
                                          builder: (context) =>
                                              ActivityHistory(),
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
                                              builder: (context) =>
                                                  const ContactUsScren(),
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
                                              builder: (context) =>
                                                  const SettingScreen(),
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
                                      press: () async {
                                        await AuthC().signOut();
                                      },
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
                ],
              ),
      ),
    );
  }
}

class DialogEditProfile extends StatefulWidget {
  const DialogEditProfile({
    Key? key,
    required this.hegithValue,
    required this.weightValue,
    required this.controller,
  }) : super(key: key);
  final int hegithValue;
  final int weightValue;
  final ProfileC controller;

  @override
  State<DialogEditProfile> createState() => _DialogEditProfileState();
}

class _DialogEditProfileState extends State<DialogEditProfile> {
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  @override
  void initState() {
    super.initState();
    heightController.text = widget.hegithValue.toString();
    weightController.text = widget.weightValue.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: double.infinity,
        height: 300,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Change your BMI',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 20),
            TextFieldNoWithIcon(
              controller: heightController,
              icon: Icons.accessibility_sharp,
              hintText: 'Update Your height',
            ),
            const SizedBox(height: 10),
            TextFieldNoWithIcon(
              controller: weightController,
              icon: Icons.scale,
              hintText: 'Update Your height',
            ),
            const Spacer(),
            Container(
              width: double.infinity,
              // padding: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.primaryColor,
              ),
              child: ElevatedButton(
                onPressed: () async {
                  widget.controller
                      .updateWeight(int.parse(weightController.text));
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  primary: AppColors.primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  alignment: Alignment.center,
                  fixedSize: const Size(double.infinity, 45),
                  elevation: 0,
                ),
                child: const Text(
                  'Update',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
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

class TextFieldNoWithIcon extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final TextEditingController controller;
  const TextFieldNoWithIcon({
    Key? key,
    required this.icon,
    required this.hintText,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        vertical: 5,
        horizontal: 10,
      ),
      decoration: BoxDecoration(
        color: AppColors.mainColor,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 2, color: AppColors.primaryColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(2, 3),
            blurRadius: 10,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(-2, -3),
            blurRadius: 10,
          )
        ],
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.primaryColor,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: TextFormField(
              controller: controller,
              style: const TextStyle(fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: const TextStyle(
                    color: Colors.grey, fontWeight: FontWeight.w400),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
