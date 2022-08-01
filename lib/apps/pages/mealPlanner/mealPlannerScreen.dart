import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gold_health/apps/global_widgets/list_chart/lineChart1Line.dart';
import 'package:gold_health/apps/pages/mealPlanner/widgets/ControlMealCard.dart';
import 'package:gold_health/apps/pages/mealPlanner/widgets/MealSelect.dart';
import 'package:gold_health/apps/pages/mealPlanner/widgets/TodayMealCard.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../global_widgets/ButtonText.dart';
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
                                      ButtonText(
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
