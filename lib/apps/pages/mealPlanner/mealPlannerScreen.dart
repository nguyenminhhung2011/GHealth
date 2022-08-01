import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gold_health/apps/global_widgets/list_chart/lineChart1Line.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../template/misc/colors.dart';
import '../dashboard/activity_trackerScreen.dart';

class MealPlannerScreen extends StatelessWidget {
  const MealPlannerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _heightDevice = MediaQuery.of(context).size.height;
    var _widthDevice = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      extendBody: true,
      body: Stack(
        children: [
          Container(
            width: _widthDevice,
            height: _heightDevice,
            decoration: BoxDecoration(
              color: AppColors.mainColor,
            ),
          ),
          Container(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
              ),
              child: ListView(
                physics: BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(minHeight: _heightDevice),
                        child: Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                          ),
                          child: SingleChildScrollView(
                            physics: const NeverScrollableScrollPhysics(),
                            child: Column(
                              children: [
                                AppBar(),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    Text(
                                      'Meal Nutritions',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4!
                                          .copyWith(
                                            fontSize: 17,
                                          ),
                                    ),
                                    Spacer(),
                                    ButtonIconGradientColor(
                                      title: ' Week',
                                      icon: Icons.calendar_month,
                                      press: () {},
                                    )
                                  ],
                                ),
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: _widthDevice,
                                  height: 200,
                                  child: Container(
                                    child: LineChartOneLine(),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      ControlMealCard(
                                          header: 'Calories', percent: 0.82),
                                      const SizedBox(width: 20),
                                      ControlMealCard(
                                          header: 'Sugar', percent: 0.39),
                                      const SizedBox(width: 20),
                                      ControlMealCard(
                                          header: 'Fibre', percent: 0.88),
                                      const SizedBox(width: 20),
                                      ControlMealCard(
                                          header: 'fats', percent: 0.42),
                                      const SizedBox(width: 20),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  width: _widthDevice,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 20, horizontal: 20),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    gradient: LinearGradient(
                                      begin: Alignment.centerLeft,
                                      end: Alignment.centerRight,
                                      colors: [
                                        AppColors.primaryColor1
                                            .withOpacity(0.1),
                                        AppColors.primaryColor2.withOpacity(0.1)
                                      ],
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        'Daily Meal Scheduele',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                        ),
                                      ),
                                      Spacer(),
                                      ButtomText(
                                        press: () {},
                                        title: 'Check',
                                        color: AppColors.primaryColor1,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    Text(
                                      'Today Meals',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4!
                                          .copyWith(
                                            fontSize: 17,
                                          ),
                                    ),
                                    Spacer(),
                                    ButtonIconGradientColor(
                                      title: ' Breakfast',
                                      icon: Icons.keyboard_arrow_down_sharp,
                                      press: () {},
                                    )
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Column(
                                  children: [
                                    TodayMealCard(
                                      widthDevice: _widthDevice,
                                      title: 'Salmin Nigiri',
                                      time: 'Today | 7am',
                                      press: () {},
                                      imagePath: 'assets/images/sushi.png',
                                    ),
                                    const SizedBox(height: 10),
                                    TodayMealCard(
                                      widthDevice: _widthDevice,
                                      title: 'Lowfat Mild',
                                      time: 'Today | 8am',
                                      press: () {},
                                      imagePath: 'assets/images/milk-box.png',
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Find Something to Eat',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(
                                          fontSize: 17,
                                        ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      MealSelect(
                                        imagePath: 'assets/images/break.png',
                                        color: AppColors.primaryColor1
                                            .withOpacity(0.2),
                                        color_btn: AppColors.primaryColor1,
                                        collect: 'Breakfast',
                                        noFoods: 120,
                                        press: () {},
                                      ),
                                      const SizedBox(width: 10),
                                      MealSelect(
                                        imagePath: 'assets/images/lunch.png',
                                        color: AppColors.primaryColor2
                                            .withOpacity(0.2),
                                        color_btn: AppColors.primaryColor2,
                                        collect: 'Lunch',
                                        noFoods: 130,
                                        press: () {},
                                      ),
                                      const SizedBox(width: 15),
                                      MealSelect(
                                        imagePath: 'assets/images/dinner.png',
                                        color: AppColors.primaryColor
                                            .withOpacity(0.2),
                                        color_btn: AppColors.primaryColor,
                                        collect: 'Dinner',
                                        noFoods: 140,
                                        press: () {},
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ControlMealCard extends StatelessWidget {
  const ControlMealCard({
    Key? key,
    required this.header,
    required this.percent,
  }) : super(key: key);
  final String header;
  final double percent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: AppColors.primaryColor1.withOpacity(0.2),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                '${header} ',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${percent * 100}%',
                style: TextStyle(
                  color: (percent > 0.5) ? Colors.green : Colors.red,
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          Container(
            width: 120,
            height: 10,
            child: LinearPercentIndicator(
              lineHeight: 30,
              percent: percent,
              progressColor: (percent > 0.5)
                  ? Colors.green.withOpacity(0.5)
                  : Colors.red.withOpacity(0.5),
              backgroundColor: Colors.grey.withOpacity(0.2),
              animation: true,
              animationDuration: 1000,
              barRadius: const Radius.circular(20),
            ),
          )
        ],
      ),
    );
  }
}

class MealSelect extends StatelessWidget {
  const MealSelect({
    Key? key,
    required this.collect,
    required this.imagePath,
    required this.noFoods,
    required this.press,
    required this.color,
    required this.color_btn,
  }) : super(key: key);
  final String collect;
  final String imagePath;
  final int noFoods;
  final Function() press;
  final Color color;
  final Color color_btn;
  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15),
              topRight: Radius.circular(100),
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15),
            ),
          ),
        ),
        Positioned(
          top: -15,
          left: 80,
          child: Image.asset(
            height: 120,
            width: 120,
            imagePath,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 200,
            padding: const EdgeInsets.only(left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Spacer(),
                Text(
                  collect,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  '${noFoods} + foods',
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 10),
                ButtomText(
                  press: press,
                  title: 'Select',
                  color: color_btn,
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ButtomText extends StatelessWidget {
  const ButtomText({
    Key? key,
    required this.press,
    required this.title,
    required this.color,
  }) : super(key: key);
  final Function() press;
  final String title;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 35,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: color,
      ),
      child: ElevatedButton(
        onPressed: press,
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            primary: Colors.transparent,
            shadowColor: Colors.transparent),
        child: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    );
  }
}

class TodayMealCard extends StatelessWidget {
  const TodayMealCard({
    Key? key,
    required double widthDevice,
    required this.title,
    required this.time,
    required this.imagePath,
    required this.press,
  })  : _widthDevice = widthDevice,
        super(key: key);

  final double _widthDevice;
  final String title;
  final String time;
  final String imagePath;
  final Function() press;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: _widthDevice,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            offset: const Offset(2, 3),
            blurRadius: 20,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            offset: Offset(-2, -3),
            blurRadius: 20,
          )
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage(
                  imagePath,
                ),
              ),
            ),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                time,
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Spacer(),
          InkWell(
            borderRadius: BorderRadius.circular(13),
            onTap: press,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                color: AppColors.primaryColor1.withOpacity(0.2),
              ),
              child: SvgPicture.asset(
                'assets/icons/Notification.svg',
                color: AppColors.primaryColor1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AppBar extends StatelessWidget {
  const AppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primaryColor1.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        Spacer(),
        Text(
          'Meal Planner',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        Spacer(),
        InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primaryColor1.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.more_horiz,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
