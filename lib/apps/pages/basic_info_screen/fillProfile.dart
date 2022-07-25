import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/fillProfilControls.dart';
import 'package:gold_health/apps/routes/routeName.dart';

import '../../global_widgets/boxData.dart';
import '../../global_widgets/buttonMain.dart';
import '../../global_widgets/textFieldWithIcon.dart';
import '../../global_widgets/textPhoneField.dart';
import '../../template/misc/colors.dart';

class FillProfileScreen extends StatefulWidget {
  const FillProfileScreen({Key? key}) : super(key: key);

  @override
  State<FillProfileScreen> createState() => _FillProfileScreenState();
}

class _FillProfileScreenState extends State<FillProfileScreen> {
  final fillProC = Get.find<FillProfileC>();
  var list = [for (var i = 100; i <= 300; i++) i];
  final TextEditingController c = TextEditingController();
  int height_cm = 100;
  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: AppColors.mailColor,
      body: Container(
        padding:
            const EdgeInsets.only(top: 10, left: 10, right: 10, bottom: 30),
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        height: heightDevice,
        width: widthDevice,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: heightDevice / 20),
            Row(
              children: [
                IconButton(
                  color: Colors.black,
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                Flexible(
                  child: Container(
                    padding: const EdgeInsets.only(right: 40),
                    alignment: Alignment.center,
                    child: Text(
                      'Fill Your Profile',
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(fontSize: 25),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              'Don\'t worry you can always change it later,or you can skip it for now',
              style: Theme.of(context).textTheme.headline5,
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 20),
                      Stack(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: widthDevice / 2.5,
                                height: widthDevice / 2.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image:
                                        AssetImage('assets/images/avatar.png'),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            left: widthDevice / 2 + widthDevice / 10,
                            top: widthDevice / 2.5 - widthDevice / 8,
                            child: InkWell(
                              onTap: () {
                                print('Click');
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Icon(Icons.edit, color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 40),
                      TextFieldWithIcon(
                        hintText: 'Full Name',
                        controller: fillProC.fullName,
                        icon: Icons.account_circle_rounded,
                      ),
                      const SizedBox(height: 20),
                      TextFieldWithIcon(
                        hintText: 'Nick Name',
                        controller: fillProC.nickName,
                        icon: Icons.account_box_outlined,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              print('Click');
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.mainColor,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    offset: const Offset(2, 3),
                                    blurRadius: 10,
                                  ),
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.05),
                                    offset: Offset(-2, -3),
                                    blurRadius: 10,
                                  )
                                ],
                              ),
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/vietnam.png',
                                    height: 50,
                                    width: 50,
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    color: Colors.black,
                                    size: 30,
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          Expanded(
                            child: TextPhoneField(
                              hintText: 'Phone Number',
                              controller: fillProC.phoneNo,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Let\'s fill your profile',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          decoration: TextDecoration.underline,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(child: ButtonDesign1(title: 'Skip', press: () {})),
                  const SizedBox(width: 20),
                  Expanded(
                      child: ButtonDesign(
                          title: 'Next',
                          press: () {
                            Get.toNamed(RouteName.selectGender);
                          })),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
