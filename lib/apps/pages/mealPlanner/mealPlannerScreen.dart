import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gold_health/apps/global_widgets/list_chart/lineChart1Line.dart';
import 'package:gold_health/apps/global_widgets/screenTemplate.dart';
import 'package:gold_health/apps/pages/mealPlanner/widgets/ControlMealCard.dart';
import 'package:gold_health/apps/pages/mealPlanner/widgets/MealSelect.dart';
import 'package:gold_health/apps/pages/mealPlanner/widgets/TodayMealCard.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../../global_widgets/ButtonText.dart';
import '../../template/misc/colors.dart';
import '../dashboard/activity_trackerScreen.dart';
import 'category_meal_screen.dart';
import 'meal_schedule_screen.dart';

class MealPlannerScreen extends StatelessWidget {
  const MealPlannerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: ScreenTemplate(
        child: Column(
          children: [
            const AppBarDesign(title: 'Meal Planner'),
            const SizedBox(height: 20),
            Row(
              children: [
                Text(
                  'Meal Nutritions',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontSize: 17,
                      ),
                ),
                const Spacer(),
                ButtonIconGradientColor(
                  title: ' Week',
                  icon: Icons.calendar_month,
                  press: () {},
                )
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: widthDevice,
              height: 200,
              // ignore: avoid_unnecessary_containers
              child: Container(
                child: const LineChartOneLine(),
              ),
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: const [
                  ControlMealCard(header: 'Calories', percent: 0.82),
                  SizedBox(width: 20),
                  ControlMealCard(header: 'Sugar', percent: 0.39),
                  SizedBox(width: 20),
                  ControlMealCard(header: 'Fibre', percent: 0.88),
                  SizedBox(width: 20),
                  ControlMealCard(header: 'fats', percent: 0.42),
                  SizedBox(width: 20),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: widthDevice,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [
                    AppColors.primaryColor1.withOpacity(0.1),
                    AppColors.primaryColor2.withOpacity(0.1)
                  ],
                ),
              ),
              child: Row(
                children: [
                  const Text(
                    'Daily Meal Scheduele',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const Spacer(),
                  ButtonText(
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MealScheduleScreen(),
                        ),
                      );
                    },
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
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontSize: 17,
                      ),
                ),
                const Spacer(),
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
                  widthDevice: widthDevice,
                  title: 'Salmin Nigiri',
                  time: 'Today | 7am',
                  press: () {},
                  imagePath: 'assets/images/sushi.png',
                ),
                const SizedBox(height: 10),
                TodayMealCard(
                  widthDevice: widthDevice,
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
                style: Theme.of(context).textTheme.headline4!.copyWith(
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
                    color: AppColors.primaryColor1.withOpacity(0.2),
                    color_btn: AppColors.primaryColor1,
                    collect: 'Breakfast',
                    noFoods: 120,
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryMealScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(width: 10),
                  MealSelect(
                    imagePath: 'assets/images/lunch.png',
                    color: AppColors.primaryColor2.withOpacity(0.2),
                    color_btn: AppColors.primaryColor2,
                    collect: 'Lunch',
                    noFoods: 130,
                    press: () {},
                  ),
                  const SizedBox(width: 15),
                  MealSelect(
                    imagePath: 'assets/images/dinner.png',
                    color: AppColors.primaryColor.withOpacity(0.2),
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
    );
  }
}

class AppBarDesign extends StatelessWidget {
  const AppBarDesign({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
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
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        const Spacer(),
        Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primaryColor1.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.more_horiz,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
