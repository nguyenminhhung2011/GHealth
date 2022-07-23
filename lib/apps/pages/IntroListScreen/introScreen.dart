import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/data/fakeData.dart';
import 'package:gold_health/apps/global_widgets/buttonMain.dart';

import '../../routes/routeName.dart';
import '../../template/misc/colors.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;
    List<Widget> listViewIntro = [
      Container(
        child: Image.asset('assets/gift/Workout2.gif'),
        height: heightDevice * 0.7,
        width: heightDevice * 0.7,
      ),
      Container(
        // color: Colors.red,
        child: Image.asset('assets/gift/Workout3.gif'),
      ),
      Container(
        child: Hero(
          child: Image.asset('assets/gift/Workout1.gif'),
          tag: 'Image auth',
        ),
      ),
    ];
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      // appBar: AppBar(
      //   leading: InkWell(
      //     onTap: () => Navigator.pop(context),
      //     child: Icon(
      //       Icons.arrow_back_ios,
      //       color: Colors.black,
      //     ),
      //   ),
      //   title:
      // ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          children: [
            Expanded(
              flex: (heightDevice / 11).round(),
              child: Row(
                children: [
                  Hero(
                    child: Image.asset(
                      'assets/images/intro.png',
                      height: widthDevice / 10,
                      width: widthDevice / 10,
                    ),
                    tag: 'Splash image',
                  ),
                  const SizedBox(width: 5),
                  Text.rich(
                    TextSpan(
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .copyWith(fontSize: 15),
                      children: [
                        TextSpan(
                          text: 'Hello, I am ',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: 'GHealth',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              flex: (heightDevice / 11 * 8).round(),
              child: PageView.builder(
                itemBuilder: (context, index) {
                  return listViewIntro[index];
                },
                itemCount: listViewIntro.length,
              ),
            ),
            Expanded(
              flex: (heightDevice / 11 * 1).round(),
              child: Container(),
            ),
            Expanded(
              flex: (heightDevice / 11 * 1).round(),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      ButtonDesign(
                          title: 'Next',
                          press: () {
                            Get.toNamed(RouteName.logIn);
                          }),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {},
                        child: Text(
                          'Skip',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
