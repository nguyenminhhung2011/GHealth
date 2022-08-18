import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/data/fake_data.dart';
import 'package:gold_health/apps/global_widgets/button_custom/button_main.dart';

import '../../routes/route_name.dart';
import '../../template/misc/colors.dart';
import '../basic_info_screen/app_bar_hero.dart';

PageController pageController = PageController(initialPage: 0, keepPage: true);
void onButtonTape(int index) {
  pageController.animateToPage(index,
      duration: const Duration(seconds: 1), curve: Curves.fastOutSlowIn);
//  pageController.jumpToPage(index);
}

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;
    List<Widget> listViewIntro = [
      MainPageViewIntro(
        heightDevice: heightDevice,
        gifPath: 'assets/gift/Workout2.gif',
        mainTitle: 'Track Your Goal',
        title:
            'Don\'t worry if you have trouble determining your goals. We can help you determine your goals and track your goals',
      ),
      MainPageViewIntro(
        heightDevice: heightDevice,
        gifPath: 'assets/gift/Workout3.gif',
        mainTitle: 'Get Burn',
        title:
            'Let\'s keep burning, to achive yours goals, it hurts only temporaily, if you give up now you will be in pain forever',
      ),
      MainPageViewIntro(
        heightDevice: heightDevice,
        gifPath: 'assets/gift/Workout1.gif',
        mainTitle: 'Eat Well',
        title:
            'Let\'t start a healthy lifestyle with us, we can determine your diet every day, healthy eating is fun',
      ),
    ];
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15),
        child: Column(
          children: [
            Expanded(
              flex: (heightDevice / 11).round(),
              child: AppBarHello(widthDevice: widthDevice),
            ),
            Expanded(
              flex: (heightDevice / 11 * 8).round(),
              child: PageView.builder(
                controller: pageController,
                onPageChanged: (value) {
                  setState(() {
                    _currentIndex = value;
                  });
                },
                itemBuilder: (context, index) {
                  return listViewIntro[index];
                },
                itemCount: listViewIntro.length,
              ),
            ),
            Expanded(
              flex: (heightDevice / 11 * 0.5).round(),
              child: Column(
                children: [
                  const Spacer(),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: widthDevice / 3),
                    child: SizedBox(
                      height: 10,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => buildIndicator(
                            _currentIndex == index,
                            MediaQuery.of(context).size),
                        itemCount: listViewIntro.length,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            Expanded(
              flex: (heightDevice / 11 * 1).round(),
              child: SizedBox(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      ButtonDesign(
                        title: 'Next',
                        press: () {
                          setState(() {
                            if (_currentIndex == 0) {
                              onButtonTape(1);
                            } else if (_currentIndex == 1) {
                              onButtonTape(2);
                            } else {
                              Get.toNamed(RouteName.logIn);
                            }
                          });
                        },
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          Get.toNamed(RouteName.logIn);
                        },
                        child: const SizedBox(
                          width: double.infinity,
                          height: 20,
                          child: Text(
                            'Skip',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w700,
                              fontSize: 12,
                            ),
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

  Widget buildIndicator(bool isActive, Size size) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 10,
      width: isActive ? 50 : 20,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          //container with border
          color: isActive
              ? AppColors.primaryColor
              : AppColors.primaryColor.withOpacity(0.2),
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          boxShadow: const [
            BoxShadow(
                color: Colors.black38, offset: Offset(2, 3), blurRadius: 3)
          ]),
    );
  }
}

class MainPageViewIntro extends StatelessWidget {
  final String gifPath;
  final String mainTitle;
  final String title;
  const MainPageViewIntro({
    Key? key,
    required this.heightDevice,
    required this.gifPath,
    required this.mainTitle,
    required this.title,
  }) : super(key: key);

  final double heightDevice;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        SizedBox(child: Image.asset(gifPath)),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                mainTitle,
                style: Theme.of(context).textTheme.headline4,
              ),
              Text(
                title,
                style: Theme.of(context).textTheme.headline5,
              ),
            ],
          ),
        ),
        SizedBox(
          height: heightDevice / 20,
        ),
      ],
    );
  }
}
