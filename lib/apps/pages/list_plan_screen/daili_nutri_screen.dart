import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:get/get_rx/src/rx_types/rx_types.dart';
// import 'package:gold_health/apps/global_widgets/screenTemplate.dart';
// import 'package:gold_health/apps/pages/mealPlanner/widgets/SearchContainer.dart';
import 'package:intl/intl.dart';

import '../../controls/dailyPlanController/meal_plan/daily_nutrition_controller.dart';
import '../../data/models/Meal.dart';
import '../../template/misc/colors.dart';
import 'add_food_nutri_screen.dart';

class DailyNutriScreen extends StatelessWidget {
  // ignore: prefer_const_constructors_in_immutables
  DailyNutriScreen({Key? key}) : super(key: key);
  //DailyNutritionController controller = Get.find<DailyNutritionController>();
  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;
    DateTime time = DateTime.now();
    return GetBuilder<DailyNutritionController>(
        init: DailyNutritionController(),
        builder: (controller) {
          return Obx(
            () => Scaffold(
              floatingActionButton: InkWell(
                borderRadius: BorderRadius.circular(50),
                onTap: () {
                  Get.bottomSheet(
                    isScrollControlled: true,
                    enterBottomSheetDuration: const Duration(milliseconds: 200),
                    Container(
                      margin: const EdgeInsets.only(top: 50),
                      // ignore: prefer_const_constructors
                      height: heightDevice,
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                        child: AddFoodScreen(),
                      ),
                    ),
                  );
                  controller.update();
                },
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
                  children: [
                    IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: AppColors.primaryColor1,
                      ),
                    ),
                    const SizedBox(width: 2),
                    const Text(
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
                                      (controller.listFoodToday.isEmpty)
                                          ? 0.toString()
                                          : controller.listFoodToday
                                              .fold<int>(0, (sum, e) {
                                              return sum +
                                                  controller.allMeal[e['id']]
                                                          .kCal *
                                                      e["amount"] as int;
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
                            SizedBox(
                              width: widthDevice,
                              child: Row(
                                children:
                                    //  controller.listNutri.value
                                    //     .map(
                                    //       (e) =>
                                    // Expanded(
                                    //         child: Container(
                                    //             padding: const EdgeInsets.all(20),
                                    //             margin: const EdgeInsets.symmetric(
                                    //                 horizontal: 5),
                                    //             decoration: BoxDecoration(
                                    //               color: AppColors.primaryColor1,
                                    //               borderRadius: BorderRadius.circular(20),
                                    //             ),
                                    //             child: Column(
                                    //               children: [
                                    //                 Text(
                                    //                   controller.sumKcal.toString(),
                                    //                   style: const TextStyle(
                                    //                     color: Colors.white,
                                    //                     fontWeight: FontWeight.bold,
                                    //                     fontSize: 15,
                                    //                   ),
                                    //                 ),
                                    //                 const SizedBox(height: 5),
                                    //                 Text(
                                    //                   e['name'],
                                    //                   style: const TextStyle(
                                    //                     color: Colors.white,
                                    //                     fontWeight: FontWeight.bold,
                                    //                   ),
                                    //                 )
                                    //               ],
                                    //             )),
                                    //       ),
                                    //     )
                                    //     .toList(),
                                    [
                                  Expanded(
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
                                            (controller.listFoodToday.isEmpty)
                                                ? 0.toString()
                                                : controller.listFoodToday
                                                    .fold<int>(0, (sum, e) {
                                                    return sum +
                                                        controller
                                                                .allMeal[
                                                                    e['id']]
                                                                .carbs *
                                                            e["amount"] as int;
                                                  }).toString(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          const Text(
                                            'Carbs',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
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
                                            (controller.listFoodToday.isEmpty)
                                                ? 0.toString()
                                                : controller.listFoodToday
                                                    .fold<int>(0, (sum, e) {
                                                    return sum +
                                                        controller
                                                                .allMeal[
                                                                    e['id']]
                                                                .proteins *
                                                            e["amount"] as int;
                                                  }).toString(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          const Text(
                                            'Proteins',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
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
                                            (controller.listFoodToday.isEmpty)
                                                ? 0.toString()
                                                : controller.listFoodToday
                                                    .fold<int>(0, (sum, e) {
                                                    return sum +
                                                        controller
                                                                .allMeal[
                                                                    e['id']]
                                                                .fats *
                                                            e["amount"] as int;
                                                  }).toString(),
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          const Text(
                                            'Fats',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 20),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
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
                                    onTap: () {
                                      print(controller.listFoodToday);
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
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
                          children: controller.listFoodToday
                              .map(
                                (e) => FoodAbsorbed(
                                  meal: controller.allMeal[e['id']],
                                  data: e,
                                ),
                              )
                              .toList(),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}

class FoodAbsorbed extends StatelessWidget {
  const FoodAbsorbed({Key? key, required this.meal, required this.data})
      : super(key: key);
  final Meal meal;
  final Map<String, dynamic> data;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(meal.asset),
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
                          meal.name,
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          data['date'],
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
                          '${meal.kCal * data['amount'] as int} kCal',
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
                          data['time'],
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
    );
  }
}
