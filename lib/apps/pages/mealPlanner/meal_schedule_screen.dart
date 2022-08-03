import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gold_health/apps/pages/mealPlanner/widgets/FoodScheduleCard.dart';
import 'package:gold_health/apps/pages/mealPlanner/widgets/MealNutritionCard.dart';
import 'package:gold_health/apps/pages/mealPlanner/widgets/monthScroll.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../global_widgets/screenTemplate.dart';
import '../../template/misc/colors.dart';
import 'mealPlannerScreen.dart';

class MealScheduleScreen extends StatefulWidget {
  const MealScheduleScreen({Key? key}) : super(key: key);

  @override
  State<MealScheduleScreen> createState() => _MealScheduleScreenState();
}

class _MealScheduleScreenState extends State<MealScheduleScreen> {
  DateTime dateTime = DateTime.now();
  final List<String> listMonth = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  final List<String> listDay = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];
  @override
  static int getDaysInMonth(int year, int month) {
    if (month == DateTime.february) {
      final bool isLeapYear =
          (year % 4 == 0) && (year % 100 != 0) || (year % 400 == 0);
      return isLeapYear ? 29 : 28;
    }
    const List<int> daysInMonth = <int>[
      31,
      -1,
      31,
      30,
      31,
      30,
      31,
      31,
      30,
      31,
      30,
      31
    ];
    return daysInMonth[month - 1];
  }

  int noDate = 0;
  int selectDate = 1;
  @override
  void initState() {
    super.initState();
    getDate();
  }

  void getDate() {
    setState(() {
      noDate = getDaysInMonth(dateTime.year, dateTime.month);
    });
  }

  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;
    late FixedExtentScrollController _controller =
        FixedExtentScrollController();

    return ScreenTemplate(
      child: Column(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const AppBarDesign(title: 'Meal Schedule'),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.grey,
                  size: 16,
                ),
              ),
              const SizedBox(width: 5),
              GestureDetector(
                onTap: () {},
                child: Text(
                  '${listMonth[dateTime.month]} ${dateTime.year}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.grey,
                  size: 16,
                ),
              )
            ],
          ),
          SizedBox(
            height: 100,
            width: widthDevice,
            child: ListView(scrollDirection: Axis.horizontal, children: [
              for (int i = 1; i <= noDate; i++)
                InkWell(
                  onTap: () {
                    setState(() {
                      selectDate = i;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 15),
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      gradient: (selectDate == i)
                          ? AppColors.colorGradient
                          : LinearGradient(
                              colors: [
                                Colors.grey.withOpacity(0.1),
                                Colors.grey.withOpacity(0.1),
                              ],
                            ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '${i}/${dateTime.month}',
                          style: TextStyle(
                            color:
                                (selectDate == i) ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          dateTime.year.toString(),
                          style: TextStyle(
                            color:
                                (selectDate == i) ? Colors.white : Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ]),
          ),
          const SizedBox(height: 20),
          // ignore: avoid_unnecessary_containers, sized_box_for_whitespace
          Container(
            width: double.infinity,
            child: Row(
              children: const [
                Text(
                  'Breakfast',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Spacer(),
                Text(
                  '2 meals | 230 calories',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                )
              ],
            ),
          ),
          const SizedBox(height: 15),
          Column(
            children: [
              FoodScheduleCard(
                imagePath: 'assets/images/lunch.png',
                name: 'Honey Pancake',
                time: '07:00am',
                press: () {},
                color: AppColors.primaryColor1.withOpacity(0.2),
              ),
              const SizedBox(height: 10),
              FoodScheduleCard(
                imagePath: 'assets/images/dinner.png',
                name: 'Banh xeo',
                time: '08:00am',
                press: () {},
                color: AppColors.primaryColor2.withOpacity(0.2),
              ),
            ],
          ),
          const SizedBox(height: 15),
          // ignore: sized_box_for_whitespace
          Container(
            width: double.infinity,
            child: Row(
              children: const [
                Text(
                  'Lunch',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Spacer(),
                Text(
                  '2 meals | 500 calories',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                )
              ],
            ),
          ),
          const SizedBox(height: 15),
          Column(
            children: [
              FoodScheduleCard(
                imagePath: 'assets/images/sushi.png',
                name: 'SuShi',
                time: '11:00am',
                press: () {},
                color: AppColors.primaryColor1.withOpacity(0.2),
              ),
              const SizedBox(height: 10),
              FoodScheduleCard(
                imagePath: 'assets/images/break.png',
                name: 'Banh kep',
                time: '11:40am',
                press: () {},
                color: AppColors.primaryColor2.withOpacity(0.2),
              ),
            ],
          ),
          const SizedBox(height: 15),
          // ignore: sized_box_for_whitespace
          Container(
            width: double.infinity,
            child: Row(
              children: const [
                Text(
                  'Snacks',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Spacer(),
                Text(
                  '2 meals | 140 calories',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                )
              ],
            ),
          ),
          const SizedBox(height: 15),
          Column(
            children: [
              FoodScheduleCard(
                imagePath: 'assets/images/eating.png',
                name: 'Com tam',
                time: '14:00pm',
                press: () {},
                color: AppColors.primaryColor1.withOpacity(0.2),
              ),
              const SizedBox(height: 10),
              FoodScheduleCard(
                imagePath: 'assets/images/strach.png',
                name: 'Banh Mi',
                time: '15:40am',
                press: () {},
                color: AppColors.primaryColor2.withOpacity(0.2),
              ),
            ],
          ),
          const SizedBox(height: 15),
          // ignore: sized_box_for_whitespace
          Container(
            width: double.infinity,
            child: Row(
              children: const [
                Text(
                  'Dinner',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Spacer(),
                Text(
                  '2 meals | 180 calories',
                  style: TextStyle(color: Colors.grey, fontSize: 15),
                )
              ],
            ),
          ),
          const SizedBox(height: 15),
          Column(
            children: [
              FoodScheduleCard(
                imagePath: 'assets/images/egg.png',
                name: 'Eggs',
                time: '19:00pm',
                press: () {},
                color: AppColors.primaryColor1.withOpacity(0.2),
              ),
              const SizedBox(height: 10),
              FoodScheduleCard(
                imagePath: 'assets/images/dinner.png',
                name: 'Banh mat ong',
                time: '19:40am',
                press: () {},
                color: AppColors.primaryColor2.withOpacity(0.2),
              ),
            ],
          ),
          const SizedBox(height: 15),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Today Meal Nutritions',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          const SizedBox(height: 15),
          Column(
            children: [
              MealNutritionCard(
                widthDevice: widthDevice,
                imagePath: 'assets/images/calories.png',
                title: 'Calories',
                data: '320 kCal',
                percent: 0.72,
              ),
              MealNutritionCard(
                widthDevice: widthDevice,
                imagePath: 'assets/images/protein.png',
                title: 'Proteins',
                data: '300g',
                percent: 0.43,
              ),
              MealNutritionCard(
                widthDevice: widthDevice,
                imagePath: 'assets/images/trans-fat.png',
                title: 'Fats',
                data: '320g',
                percent: 0.6,
              ),
              MealNutritionCard(
                widthDevice: widthDevice,
                imagePath: 'assets/images/strach.png',
                title: 'Carbo',
                data: '320 kCal',
                percent: 0.2,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildDatePicker() => SizedBox(
        child: CupertinoDatePicker(
          backgroundColor: AppColors.mainColor,
          minimumYear: 2015,
          maximumYear: DateTime.now().year + 1,
          initialDateTime: dateTime,
          mode: CupertinoDatePickerMode.date,
          onDateTimeChanged: (dateTime) =>
              setState(() => this.dateTime = dateTime),
        ),
      );

  Widget buildDatePickerMonthYear() => SizedBox(height: 20);
}
