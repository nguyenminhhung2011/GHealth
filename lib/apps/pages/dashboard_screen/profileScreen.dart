import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gold_health/apps/pages/dashboard_screen/activity_trackerScreen.dart';

import '../../template/misc/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Column(
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
            flex: (heightDevice / 20 * 5).round(),
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
                    )
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: (heightDevice / 20 * 13).round(),
            child: Container(),
          )
        ],
      ),
    );
  }
}
