import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/pages/mealPlanner/widgets/FoodScheduleCard.dart';
import 'package:gold_health/apps/pages/mealPlanner/widgets/MealNutritionCard.dart';
import 'package:intl/intl.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

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
  var now = DateTime.now().obs;
  Timer? timer;
  final List<DateTime> listDateTime = [
    for (int i = 1; i <= 30; i++)
      DateTime(2022, 8, 1).subtract(Duration(days: i)),
    for (int i = 0; i <= 30; i++) DateTime(2022, 8, 1).add(Duration(days: i))
  ];
  GlobalKey<ScrollSnapListState> sslKey = GlobalKey();
  late int onFocus;
  final CalendarController _calendarController = CalendarController();

  Widget _itemBuilder(BuildContext context, int index) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(10),
      width: 80,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: onFocus == index
            ? LinearGradient(colors: [
                Colors.blue[200]!,
                Colors.blue[300]!,
                Colors.blue[400]!
              ])
            : const LinearGradient(
                colors: [
                  Colors.white10,
                  Colors.white10,
                ],
              ),
      ),
      child: SizedBox(
        height: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              DateFormat().add_E().format(listDateTime[index]),
              style: TextStyle(
                color: onFocus == index ? Colors.white : Colors.black,
              ),
            ),
            Text(
              DateFormat().add_d().format(listDateTime[index]),
              style: TextStyle(
                color: onFocus == index ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      now.value = DateTime.now();
    });
    for (int i = 0; i < listDateTime.length; i++) {
      if (DateFormat().add_yMd().format(listDateTime[i]) ==
          DateFormat().add_yMd().format(DateTime.now())) {
        onFocus = i;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;
    late FixedExtentScrollController _controller =
        FixedExtentScrollController();

    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: ScreenTemplate(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const AppBarDesign(title: 'Meal Schedule'),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        onFocus--;
                        sslKey.currentState!.focusToItem(onFocus);
                        _calendarController.displayDate = listDateTime[onFocus];
                      });
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      size: 18,
                      color: Colors.grey[400],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${DateFormat().add_MMM().format(listDateTime[onFocus])} ${listDateTime[onFocus].year}',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        onFocus++;
                        sslKey.currentState!.focusToItem(onFocus);
                        _calendarController.displayDate = listDateTime[onFocus];
                      });
                    },
                    icon: Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 18,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.17,
                child: ScrollSnapList(
                  key: sslKey,
                  itemBuilder: _itemBuilder,
                  background: Colors.blue[200],
                  itemCount: listDateTime.length,
                  itemSize: 100,
                  dispatchScrollNotifications: true,
                  initialIndex: onFocus.toDouble(),
                  scrollPhysics: const ScrollPhysics(),
                  duration: 1000,
                  onItemFocus: (int index) {
                    setState(() {
                      onFocus = index;
                      _calendarController.displayDate = listDateTime[onFocus];
                    });
                  },
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
        ),
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

  @override
  void dispose() {
    super.dispose();
    _calendarController.dispose();
    timer!.cancel();
  }
}
