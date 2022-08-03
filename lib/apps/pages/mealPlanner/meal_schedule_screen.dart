import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gold_health/apps/pages/mealPlanner/widgets/monthScroll.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

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

    return Scaffold(
      backgroundColor: AppColors.mainColor,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            width: widthDevice,
            height: heightDevice,
            decoration: BoxDecoration(
              color: AppColors.mainColor,
            ),
            child: const Align(
              alignment: Alignment.topCenter,
            ),
          ),
          // ignore: avoid_unnecessary_containers
          Container(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: ListView(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics(),
                ),
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ConstrainedBox(
                        constraints: BoxConstraints(minHeight: heightDevice),
                        child: Container(
                          width: double.maxFinite,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                          ),
                          child: SingleChildScrollView(
                            physics: const NeverScrollableScrollPhysics(),
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
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
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
                                            margin: const EdgeInsets.only(
                                                right: 10),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              gradient: (selectDate == i)
                                                  ? AppColors.colorGradient
                                                  : LinearGradient(
                                                      colors: [
                                                        Colors.grey
                                                            .withOpacity(0.1),
                                                        Colors.grey
                                                            .withOpacity(0.1),
                                                      ],
                                                    ),
                                            ),
                                            child: Column(
                                              children: [
                                                Text(
                                                  '${i}/${dateTime.month}',
                                                  style: TextStyle(
                                                    color: (selectDate == i)
                                                        ? Colors.white
                                                        : Colors.black,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 18,
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                Text(
                                                  dateTime.year.toString(),
                                                  style: TextStyle(
                                                    color: (selectDate == i)
                                                        ? Colors.white
                                                        : Colors.black,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: 16,
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
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 15),
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
                                      color: AppColors.primaryColor1
                                          .withOpacity(0.2),
                                    ),
                                    const SizedBox(height: 10),
                                    FoodScheduleCard(
                                      imagePath: 'assets/images/dinner.png',
                                      name: 'Banh xeo',
                                      time: '08:00am',
                                      press: () {},
                                      color: AppColors.primaryColor2
                                          .withOpacity(0.2),
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
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 15),
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
                                      color: AppColors.primaryColor1
                                          .withOpacity(0.2),
                                    ),
                                    const SizedBox(height: 10),
                                    FoodScheduleCard(
                                      imagePath: 'assets/images/break.png',
                                      name: 'Banh kep',
                                      time: '11:40am',
                                      press: () {},
                                      color: AppColors.primaryColor2
                                          .withOpacity(0.2),
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
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 15),
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
                                      color: AppColors.primaryColor1
                                          .withOpacity(0.2),
                                    ),
                                    const SizedBox(height: 10),
                                    FoodScheduleCard(
                                      imagePath: 'assets/images/strach.png',
                                      name: 'Banh Mi',
                                      time: '15:40am',
                                      press: () {},
                                      color: AppColors.primaryColor2
                                          .withOpacity(0.2),
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
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 15),
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
                                      color: AppColors.primaryColor1
                                          .withOpacity(0.2),
                                    ),
                                    const SizedBox(height: 10),
                                    FoodScheduleCard(
                                      imagePath: 'assets/images/dinner.png',
                                      name: 'Banh mat ong',
                                      time: '19:40am',
                                      press: () {},
                                      color: AppColors.primaryColor2
                                          .withOpacity(0.2),
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
                          ),
                        ),
                      ),
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

class MealNutritionCard extends StatelessWidget {
  const MealNutritionCard({
    Key? key,
    required this.widthDevice,
    required this.percent,
    required this.title,
    required this.imagePath,
    required this.data,
  }) : super(key: key);

  final double widthDevice;
  final double percent;
  final String title;
  final String imagePath;
  final String data;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.mainColor,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            offset: const Offset(2, 3),
            blurRadius: 20,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            offset: const Offset(-2, -3),
            blurRadius: 20,
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              const SizedBox(width: 4),
              Image.asset(
                imagePath,
                height: 20,
                width: 20,
              ),
              const Spacer(),
              Text(
                data,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              )
            ],
          ),
          const SizedBox(height: 10),
          // ignore: sized_box_for_whitespace
          Container(
            width: widthDevice,
            height: 15,
            child: LinearPercentIndicator(
              lineHeight: 40,
              percent: percent,
              progressColor: (percent > 0.5)
                  ? AppColors.primaryColor1
                  : AppColors.primaryColor2,
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

class FoodScheduleCard extends StatelessWidget {
  const FoodScheduleCard({
    Key? key,
    required this.imagePath,
    required this.name,
    required this.time,
    required this.press,
    required this.color,
  }) : super(key: key);
  final String imagePath;
  final String name;
  final String time;
  final Function() press;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: color),
          child: Image.asset(
            height: 60,
            width: 60,
            imagePath,
          ),
        ),
        const SizedBox(width: 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              time,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const Spacer(),
        InkWell(
          borderRadius: BorderRadius.circular(13),
          onTap: press,
          child: Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 1, color: Colors.grey),
            ),
            child: const Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
              size: 17,
            ),
          ),
        ),
      ],
    );
  }
}
