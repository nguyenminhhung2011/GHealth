import 'dart:ui';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gold_health/apps/data/fakeData.dart';
import 'package:gold_health/apps/global_widgets/ToggleButtonIos.dart';
import 'package:gold_health/apps/pages/workout_tracker_screen/widgets/CategoriesWorkoutCard.dart';
import 'package:gold_health/apps/pages/workout_tracker_screen/widgets/UpComingWorkoutContainerd.dart';

import '../../global_widgets/GradientText.dart';
import '../../global_widgets/RowText_Seemore.dart';
import '../../template/misc/colors.dart';
import '../dashboard/widgets/button_gradient.dart';

class WorkoutDetailScreen extends StatelessWidget {
  const WorkoutDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _heightDevice = MediaQuery.of(context).size.height;
    var _widthDevice = MediaQuery.of(context).size.width;
    bool val = true;
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Container(
            width: _widthDevice,
            height: _heightDevice,
            decoration: BoxDecoration(
              color: AppColors.primaryColor1,
            ),
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  left: 20,
                  right: 20,
                ),
                child: Image.asset(
                  'assets/images/yoga.png',
                ),
              ),
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
                      SizedBox(
                        height: _heightDevice * 0.35,
                        width: _widthDevice,
                      ),
                      ConstrainedBox(
                        constraints:
                            BoxConstraints(minHeight: _heightDevice * 0.86),
                        child: Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(50),
                              topRight: Radius.circular(50),
                            ),
                          ),
                          child: SingleChildScrollView(
                            physics: const NeverScrollableScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 65,
                                  height: 7,
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor1
                                        .withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                ),
                                const SizedBox(height: 30),
                                Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Fullbody Workout',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Text(
                                          '11 Exercises | 32 mins | 320 Calories Burn',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 15,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: AppColors.primaryColor1
                                              .withOpacity(0.2),
                                        ),
                                        child: Icon(
                                          Icons.favorite,
                                          color: Colors.red.withOpacity(0.5),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Column(
                                  children: [
                                    InkWell(
                                      //borderRadius: BorderRadius.circular(20),
                                      onTap: () {},
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 18),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: AppColors.primaryColor1
                                              .withOpacity(0.3),
                                        ),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                                'assets/icons/Calendar.svg',
                                                color: Colors.grey),
                                            const SizedBox(width: 5),
                                            Text(
                                              'Schedule Workout',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Spacer(),
                                            Text(
                                              '5/27,09:00 AM',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            Icon(
                                              Icons.arrow_forward_ios_sharp,
                                              color: Colors.grey,
                                              size: 15,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    InkWell(
                                      onTap: () {},
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 18),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          color: AppColors.primaryColor2
                                              .withOpacity(0.3),
                                        ),
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                                'assets/icons/Swap.svg',
                                                color: Colors.grey),
                                            const SizedBox(width: 5),
                                            Text(
                                              'Difficulity',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            Spacer(),
                                            Text(
                                              'Beginer',
                                              style: TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(width: 5),
                                            Icon(
                                              Icons.arrow_forward_ios_sharp,
                                              color: Colors.grey,
                                              size: 15,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  children: [
                                    Text(
                                      'You \'ll Need',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      '5 Items',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 15),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      ToolsCard(
                                        widthDevice: _widthDevice,
                                        imagePath:
                                            'assets/images/jump-rope.png',
                                        title: 'Jump Rope',
                                      ),
                                      ToolsCard(
                                        widthDevice: _widthDevice,
                                        imagePath:
                                            'assets/images/plastic-bottle.png',
                                        title: 'Plastic Bottle',
                                      ),
                                      ToolsCard(
                                        widthDevice: _widthDevice,
                                        imagePath: 'assets/images/barbel.png',
                                        title: 'Barbel',
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 30),
                                Row(
                                  children: [
                                    Text(
                                      'Exercises',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                      ),
                                    ),
                                    Spacer(),
                                    Text(
                                      '3 Sets',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Set 1',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                Column(
                                  children: FakeData.list_set.map((e) {
                                    return ExerciseCard(
                                      widthDevice: _widthDevice,
                                      e: e,
                                    );
                                  }).toList(),
                                )
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
          Column(
            children: [
              const SizedBox(height: 40),
              Row(
                children: [
                  const SizedBox(width: 10),
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.primaryColor1,
                            Colors.grey.withOpacity(0.1),
                          ],
                        ),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  Spacer(),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            AppColors.primaryColor1,
                            Colors.grey.withOpacity(0.1),
                          ],
                        ),
                      ),
                      child: Icon(
                        Icons.more_horiz,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
              Spacer(),
              InkWell(
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  width: _widthDevice * 0.6,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.primaryColor1,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        offset: const Offset(2, 3),
                        blurRadius: 2,
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        offset: Offset(-2, -3),
                        blurRadius: 2,
                      )
                    ],
                  ),
                  child: Text(
                    'Start Workout',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 30),
            ],
          )
        ],
      ),
    );
  }
}

class ExerciseCard extends StatelessWidget {
  const ExerciseCard({
    Key? key,
    required double widthDevice,
    required this.e,
  })  : _widthDevice = widthDevice,
        super(key: key);

  final double _widthDevice;
  final Map<String, dynamic> e;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Row(
          children: [
            Container(
              height: _widthDevice / 6,
              width: _widthDevice / 6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    e["image"],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 5),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  e["name"],
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                Text(
                  '00:${e["time"]}s',
                  style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            Spacer(),
            InkWell(
              onTap: () {},
              child: Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(width: 1, color: Colors.grey),
                ),
                child:
                    Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 17),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ToolsCard extends StatelessWidget {
  const ToolsCard({
    Key? key,
    required double widthDevice,
    required this.imagePath,
    required this.title,
  })  : _widthDevice = widthDevice,
        super(key: key);

  final double _widthDevice;
  final String imagePath;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            height: _widthDevice / 3,
            width: _widthDevice / 3,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey.withOpacity(0.1),
            ),
            child: Image.asset(
              imagePath,
            ),
          ),
          Text(
            title,
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }
}