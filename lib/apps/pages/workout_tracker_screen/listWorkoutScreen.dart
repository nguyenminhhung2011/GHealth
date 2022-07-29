import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gold_health/apps/pages/workout_tracker_screen/widgets/ExerciseCard.dart';
import 'package:gold_health/apps/pages/workout_tracker_screen/workout_screen.dart';

import '../../data/fakeData.dart';
import '../../template/misc/colors.dart';

class ListWorkoutScreen extends StatelessWidget {
  const ListWorkoutScreen({Key? key}) : super(key: key);

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
            color: AppColors.primaryColor1,
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 80,
                  left: 20,
                  right: 20,
                ),
                child: Image.asset(
                  height: _widthDevice / 1.7,
                  width: _widthDevice / 1.7,
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
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryColor1
                                              .withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/images/clock.png',
                                              height: 40,
                                              width: 40,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              '00:45:00',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        decoration: BoxDecoration(
                                          color: Colors.amber.withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Image.asset(
                                              'assets/images/calories.png',
                                              height: 40,
                                              width: 40,
                                            ),
                                            const SizedBox(width: 5),
                                            Text(
                                              '78 Calories',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Text(
                                  'Preview exercises',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 17,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  height: 0.5,
                                  width: double.infinity,
                                  color: Colors.grey,
                                ),
                                const SizedBox(height: 20),
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
                        color: Colors.white,
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
                        color: Colors.white,
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
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => WorkoutScreen()));
                },
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
