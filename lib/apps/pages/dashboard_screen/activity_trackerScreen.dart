import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gold_health/apps/data/fakeData.dart';
import 'package:gold_health/apps/global_widgets/GradientText.dart';
import 'package:gold_health/apps/global_widgets/lineChartWidget.dart';
import 'package:gold_health/apps/pages/dashboard_screen/profileScreen.dart';
import 'package:gold_health/apps/pages/dashboard_screen/widgets/ChartBoard.dart';

import '../../global_widgets/BarChartItem.dart';
import '../../global_widgets/TargetCard.dart';
import '../../global_widgets/actiCard.dart';
import '../../template/misc/colors.dart';

class ActivityTrackerScreen extends StatelessWidget {
  const ActivityTrackerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: SafeArea(
        child: Column(
          children: [
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
                        'Activity Tracker',
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              fontSize: 18,
                              fontFamily: "Sen",
                            ),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileScreen(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: AppColors.primaryColor.withOpacity(0.2),
                          ),
                          child: Icon(
                            Icons.settings,
                            color: Colors.black,
                          ),
                        ),
                      ),
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
                  width: widthDevice,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                    //color: AppColors.primaryColor,
                    borderRadius: BorderRadius.circular(25),
                    gradient: AppColors.colorContainerTodayTarget,
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Container(
                          alignment: Alignment.center,
                          child: Row(children: [
                            Text(
                              'Today Target',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                            Spacer(),
                            InkWell(
                              borderRadius: BorderRadius.circular(15),
                              onTap: () {},
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color:
                                      AppColors.primaryColor.withOpacity(0.2),
                                ),
                                child: Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ]),
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Container(
                          child: Row(
                            children: [
                              TargetCard(
                                imagePath: 'assets/images/cup.png',
                                data: '8L',
                                targetType: 'Water Intake',
                              ),
                              const SizedBox(width: 20),
                              TargetCard(
                                imagePath: 'assets/images/shoes.png',
                                data: '2400',
                                targetType: 'Foot Steps',
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              flex: (heightDevice / 20 * 15).round(),
              child: Container(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Activity Progress',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(
                                          fontSize: 17,
                                        ),
                                  ),
                                  Spacer(),
                                  ButtonIconGradientColor(
                                    title: 'Select Week',
                                    icon: Icons.calendar_month,
                                    press: () {},
                                  )
                                ],
                              ),
                              const SizedBox(height: 20),
                              ChartBoard(
                                  widthDevice: widthDevice,
                                  heightDevice: heightDevice,
                                  week: 'Week 25/7/2022 - 1/8/2022',
                                  title: 'Calories burned: ',
                                  data: '3000Kcal',
                                  color: Colors.white)
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Calories Absorbed',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(
                                          fontSize: 17,
                                        ),
                                  ),
                                  Spacer(),
                                  ButtonIconGradientColor(
                                    title: 'Select Week',
                                    icon: Icons.calendar_month,
                                    press: () {},
                                  )
                                ],
                              ),
                              const SizedBox(height: 20),
                              ChartBoard(
                                widthDevice: widthDevice,
                                heightDevice: heightDevice,
                                week: 'Week 25/7/2022 - 1/8/2022',
                                title: 'Calories Absorbed: ',
                                data: '4000Kcal',
                                color: AppColors.primaryColor2.withOpacity(0.1),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Water consumed',
                                    overflow: TextOverflow.clip,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(
                                          fontSize: 17,
                                        ),
                                  ),
                                  Spacer(),
                                  ButtonIconGradientColor(
                                    title: 'Select Week',
                                    icon: Icons.calendar_month,
                                    press: () {},
                                  )
                                ],
                              ),
                              const SizedBox(height: 20),
                              ChartBoard(
                                widthDevice: widthDevice,
                                heightDevice: heightDevice,
                                week: 'Week 25/7/2022 - 1/8/2022',
                                title: 'Amount of water consumed: ',
                                data: '300ml',
                                color: AppColors.primaryColor1.withOpacity(0.1),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'FootSteps',
                                    overflow: TextOverflow.clip,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(
                                          fontSize: 17,
                                        ),
                                  ),
                                  Spacer(),
                                  ButtonIconGradientColor(
                                    title: 'Select Week',
                                    icon: Icons.calendar_month,
                                    press: () {},
                                  )
                                ],
                              ),
                              const SizedBox(height: 20),
                              ChartBoard(
                                widthDevice: widthDevice,
                                heightDevice: heightDevice,
                                week: 'Week 25/7/2022 - 1/8/2022',
                                title: 'Number of FootSteps: ',
                                data: '300',
                                color: AppColors.mainColor,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Weight Trackers',
                                    overflow: TextOverflow.clip,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(
                                          fontSize: 17,
                                        ),
                                  ),
                                  Spacer(),
                                  ButtonIconGradientColor(
                                    title: 'Select Days',
                                    icon: Icons.calendar_month,
                                    press: () {},
                                  )
                                ],
                              ),
                              const SizedBox(height: 20),
                              Container(
                                width: widthDevice,
                                height: heightDevice / 3,
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  color: AppColors.primaryColor1,
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
                                      'Week 25/7/2022 - 1/8/2022',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Weight(kg):',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16,
                                          ),
                                        ),
                                        Text(
                                          '40',
                                          style: TextStyle(
                                            color: AppColors.primaryColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Expanded(
                                      child: LineChartWidget(),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Latest Activity',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(
                                          fontSize: 17,
                                        ),
                                  ),
                                  Spacer(),
                                  InkWell(
                                    onTap: () {},
                                    child: Text(
                                      'See more',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 17,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 20),
                              Column(
                                children: [
                                  ActiCard(
                                    widthDevice: widthDevice,
                                    imagePath: 'assets/images/drinking.png',
                                    title: 'About 3 minutes ago',
                                    mainTitle: 'Drinking 300ml Water',
                                    press: () {},
                                  ),
                                  ActiCard(
                                    widthDevice: widthDevice,
                                    imagePath: 'assets/images/eating.png',
                                    title: 'About 10 minutes ago',
                                    mainTitle: 'Eat Snack (Fitbar)',
                                    press: () {},
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
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

class ButtonIconGradientColor extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function() press;
  const ButtonIconGradientColor(
      {Key? key, required this.title, required this.icon, required this.press})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: press,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        decoration: BoxDecoration(
          gradient: AppColors.colorGradient,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 5),
            Icon(icon, color: Colors.white),
          ],
        ),
      ),
    );
  }
}

class ChartCalories extends StatelessWidget {
  final double heightOfBar;
  const ChartCalories({Key? key, required this.heightOfBar}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: FakeData.calories.map((e) {
          return Expanded(
            child: BarChartItem(
              heightOfBar: heightOfBar,
              firstData: e['2'],
              seconData: e['1'],
            ),
          );
        }).toList(),
      ),
    );
  }
}
