import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:gold_health/apps/global_widgets/screenTemplate.dart';
import 'package:intl/intl.dart';

import '../../template/misc/colors.dart';

class MealPlanScreen extends StatefulWidget {
  const MealPlanScreen({Key? key}) : super(key: key);

  @override
  State<MealPlanScreen> createState() => _MealPlanScreenState();
}

class _MealPlanScreenState extends State<MealPlanScreen> {
  List<String> tabs = [
    "Nutrition",
    "Workout",
    "Water",
    "Step",
    "Fasting",
  ];
  RxList<Map<String, dynamic>> listFood = [
    {
      'image': 'assets/images/lunch.png',
      'name': 'Banh Xeo',
      'kCal': 200,
      'Carbs': 54,
      'Protein': 20,
      'Fat': 20,
      'time': '10:54',
      'date': '20/11/2002',
    },
  ].obs;
  List<Map<String, dynamic>> listNutri = [
    {
      'data': 0,
      'name': 'Carbs',
    },
    {
      'data': 0,
      'name': 'Protein',
    },
    {
      'data': 0,
      'name': 'Fat',
    },
  ];
  DateTime time = DateTime.now();
  @override
  Widget build(BuildContext context) {
    var widthDevice = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: InkWell(
        borderRadius: BorderRadius.circular(50),
        onTap: () {},
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: const BoxDecoration(
            color: AppColors.primaryColor1,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.add, color: Colors.white, size: 25),
        ),
      ),
      backgroundColor: AppColors.mainColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: const [
            Icon(
              Icons.calendar_month,
              color: AppColors.primaryColor1,
            ),
            SizedBox(width: 2),
            Text(
              "Nutrition",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Obx(
                      () => Container(
                        width: 150,
                        height: 150,
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.mainColor,
                          border: Border.all(
                              color: AppColors.primaryColor1, width: 2),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              listFood.fold<int>(0, (sum, element) {
                                return sum + element['kCal'] as int;
                              }).toString(),
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Calories absorbed',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 13,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // ignore: sized_box_for_whitespace
                    Obx(
                      () => Container(
                        width: widthDevice,
                        child: Row(
                          children: listNutri
                              .map(
                                (e) => Expanded(
                                  child: Container(
                                      padding: const EdgeInsets.all(20),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 5),
                                      decoration: BoxDecoration(
                                        color: AppColors.primaryColor1,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            listFood.fold<int>(0,
                                                (sum, element) {
                                              return sum + element[e['name']]
                                                  as int;
                                            }).toString(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            e['name'],
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      )),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        children: [
                          const Text(
                            'History',
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {},
                            child: Container(
                              child: Row(
                                children: [
                                  Text(
                                    DateFormat()
                                        .add_yMMMMd()
                                        .format(time)
                                        .toString(),
                                  ),
                                  const Icon(
                                    Icons.calendar_month,
                                    color: AppColors.primaryColor1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Obx(
                () => Column(
                  children: listFood
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.2),
                                  blurRadius: 5,
                                )
                              ],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 20),
                              child: Row(
                                children: [
                                  Container(
                                    width: 80,
                                    height: 50,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      image: DecorationImage(
                                        image: AssetImage(
                                          e['image'],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              e['name'],
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17,
                                              ),
                                            ),
                                            const Spacer(),
                                            Text(
                                              e['date'],
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12,
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Text(
                                              e['kCal'].toString() + 'kCal',
                                              style: const TextStyle(
                                                color: AppColors.primaryColor1,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                              ),
                                            ),
                                            const Spacer(),
                                            const Icon(
                                              Icons.access_time_rounded,
                                              color: AppColors.primaryColor1,
                                              size: 18,
                                            ),
                                            Text(
                                              e['time'],
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 13,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
