import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../template/misc/colors.dart';

class WorkoutScreen extends StatelessWidget {
  const WorkoutScreen({Key? key}) : super(key: key);

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
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.primaryColor1,
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
                        height: _heightDevice * 0.08,
                        width: _widthDevice,
                      ),
                      ConstrainedBox(
                        constraints:
                            BoxConstraints(minHeight: _heightDevice * 0.95),
                        child: Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
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
                                Text(
                                  '2/120 Exercises',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  width: _widthDevice,
                                  height: _heightDevice * 0.6,
                                  decoration: BoxDecoration(),
                                  child: Image.asset(
                                    'assets/gift/Workout2.gif',
                                  ),
                                ),
                                Container(
                                  width: _widthDevice,
                                  height: 0.5,
                                  color: Colors.grey,
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  children: [],
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
              const SizedBox(height: 50),
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
                  Text(
                    'Warm Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
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
            ],
          )
        ],
      ),
    );
  }
}
