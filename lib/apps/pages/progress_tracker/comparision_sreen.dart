import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gold_health/apps/pages/mealPlanner/meal_planner_screen.dart';
import 'package:intl/intl.dart';

import '../../global_widgets/screen_template.dart';
import '../../template/misc/colors.dart';
import 'compare_result_screen.dart';

class ComparisionScreen extends StatefulWidget {
  const ComparisionScreen({Key? key}) : super(key: key);

  @override
  State<ComparisionScreen> createState() => _ComparisionScreenState();
}

class _ComparisionScreenState extends State<ComparisionScreen> {
  String iconCalender = 'assets/icons/Calendar.svg';
  DateTime month1 = DateTime.now();
  DateTime month2 = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var widthDevice = MediaQuery.of(context).size.width;
    var heightDevice = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: ScreenTemplate(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Stack(
            children: [
              Column(
                children: [
                  const AppBarDesign(title: 'Comparision'),
                  const SizedBox(height: 20),
                  ButtonSelectCalender(
                    widthDevice: widthDevice,
                    iconCalender: iconCalender,
                    date: DateFormat().add_yMMM().format(month1),
                    month: 1,
                    press: () => showDialogFunction(1),
                  ),
                  const SizedBox(height: 10),
                  ButtonSelectCalender(
                    widthDevice: widthDevice,
                    iconCalender: iconCalender,
                    date: DateFormat().add_yMMM().format(month2),
                    month: 2,
                    press: () => showDialogFunction(2),
                  ),
                ],
              ),
              // ignore: sized_box_for_whitespace
              Container(
                height: heightDevice,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(20),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const CompareResultScreen(),
                            ),
                          );
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: widthDevice,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColors.primaryColor1,
                          ),
                          child: const Text(
                            'Compare',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 60),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  showDialogFunction(int check) {
    DateTime timeTemp = DateTime.now();
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 250,
        color: AppColors.mainColor,
        child: Column(
          children: [
            // ignore: avoid_unnecessary_containers
            SizedBox(
              height: 180,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: (value) {
                  timeTemp = value;
                },
                initialDateTime: DateTime.now(),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          (check == 1) ? month1 = timeTemp : month2 = timeTemp;
                        });
                        Navigator.pop(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: AppColors.primaryColor1),
                        child: const Text(
                          'Done',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ButtonSelectCalender extends StatelessWidget {
  const ButtonSelectCalender({
    Key? key,
    required this.widthDevice,
    required this.iconCalender,
    required this.date,
    required this.month,
    required this.press,
  }) : super(key: key);

  final double widthDevice;
  final String iconCalender;
  final String date;
  final int month;
  final Function() press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: press,
      child: Container(
        width: widthDevice,
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
        decoration: BoxDecoration(
          color: Colors.grey.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            SvgPicture.asset(iconCalender, color: Colors.grey),
            const SizedBox(width: 5),
            Text(
              'Select Month $month',
              style: const TextStyle(color: Colors.grey),
            ),
            const Spacer(),
            Text(
              date,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(width: 2),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
          ],
        ),
      ),
    );
  }
}
