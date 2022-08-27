import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/dailyPlanController/meal_plan/meal_detail_controller.dart';
import 'package:gold_health/apps/global_widgets/gradient_text.dart';
import 'package:readmore/readmore.dart';

import '../../template/misc/colors.dart';
import '../workout_tracker_screen/widgets/appBar_workout_screen.dart';

class MealDetailScreen extends StatelessWidget {
  MealDetailScreen({Key? key}) : super(key: key);
  final controller = Get.find<MealDetailC>();

  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;

    return Obx(
      () => controller.meal == null
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor1))
          : Scaffold(
              backgroundColor: AppColors.mainColor,
              extendBody: true,
              extendBodyBehindAppBar: true,
              body: Stack(
                children: [
                  Container(
                    width: widthDevice,
                    height: heightDevice,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryColor1,
                    ),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 80,
                          left: 20,
                          right: 20,
                        ),
                        child: Image.network(
                          '${controller.meal['asset']}',
                          fit: BoxFit.fill,
                          height: widthDevice / 1.5,
                          width: widthDevice / 1.5,
                        ),
                      ),
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
                              SizedBox(
                                height: heightDevice * 0.35,
                              ),
                              ConstrainedBox(
                                constraints: BoxConstraints(
                                    minHeight: heightDevice * 0.86),
                                child: Container(
                                  width: double.maxFinite,
                                  padding: const EdgeInsets.symmetric(
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
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 65,
                                          height: 7,
                                          decoration: BoxDecoration(
                                            color: AppColors.primaryColor1
                                                .withOpacity(0.3),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                        ),
                                        const SizedBox(height: 30),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    controller.meal['name'],
                                                    style: const TextStyle(
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  RichText(
                                                    text: const TextSpan(
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontSize: 15),
                                                      children: [
                                                        TextSpan(
                                                          text: 'by ',
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.grey),
                                                        ),
                                                        TextSpan(
                                                          text:
                                                              "Arash Ranjbaran Qadikolaei",
                                                          style: TextStyle(
                                                            color: AppColors
                                                                .primaryColor1,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  color: AppColors.primaryColor1
                                                      .withOpacity(0.2),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Icon(
                                                  Icons.favorite,
                                                  color: Colors.red
                                                      .withOpacity(0.5),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 20),
                                        const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Nutrition',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: [
                                              NutritionCard(
                                                imagePath:
                                                    'assets/images/calories.png',
                                                type: 'kCal',
                                                data: controller.meal['kCal'],
                                              ),
                                              NutritionCard(
                                                imagePath:
                                                    'assets/images/trans-fat.png',
                                                type: 'g fats',
                                                data: controller.meal['fats'],
                                              ),
                                              NutritionCard(
                                                imagePath:
                                                    'assets/images/protein.png',
                                                type: 'g proteins',
                                                data:
                                                    controller.meal['proteins'],
                                              ),
                                              NutritionCard(
                                                imagePath:
                                                    'assets/images/strach.png',
                                                type: 'g Carbs',
                                                data: controller.meal['carbs'],
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        const Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            'Description',
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        ReadMoreText(
                                          controller.meal['description'],
                                          trimLines: 3,
                                          colorClickableText: Colors.pink,
                                          trimMode: TrimMode.Line,
                                          trimCollapsedText: 'Read more',
                                          trimExpandedText: 'Show less',
                                          moreStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.primaryColor1,
                                          ),
                                          lessStyle: const TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.primaryColor1,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        // ignore: sized_box_for_whitespace
                                        Row(
                                          children: [
                                            Image.asset(
                                                'assets/images/duration.png',
                                                height: 40,
                                                width: 40),
                                            const SizedBox(width: 10),
                                            Text(
                                              '${controller.meal['timeCook']} mins to Cook',
                                              style: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16,
                                              ),
                                            )
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        SizedBox(
                                          width: double.infinity,
                                          child: Row(
                                            children: const [
                                              Text(
                                                'Ingredients That you will need',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              Spacer(),
                                              Text(
                                                '4 Items',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 15),
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: const [
                                              IngredientsCard(
                                                imagePath:
                                                    'assets/images/flours.png',
                                                data: '100gr',
                                                name: 'Wheat Flour',
                                              ),
                                              IngredientsCard(
                                                imagePath:
                                                    'assets/images/sugar.png',
                                                data: '3 tbsp',
                                                name: 'Sugar',
                                              ),
                                              IngredientsCard(
                                                imagePath:
                                                    'assets/images/baking-soda.png',
                                                data: '2 tsp',
                                                name: 'Baking Soda',
                                              ),
                                              IngredientsCard(
                                                imagePath:
                                                    'assets/images/egg.png',
                                                data: '2 items',
                                                name: 'Eggs',
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        // ignore: sized_box_for_whitespace
                                        Container(
                                          width: double.infinity,
                                          child: Row(
                                            children: [
                                              const Text(
                                                'Step by Step',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              const Spacer(),
                                              Text(
                                                '${controller.listSteps.length} Steps',
                                                style: TextStyle(
                                                    color: Colors.grey,
                                                    fontSize: 15),
                                              )
                                            ],
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        SizedBox(
                                          width: widthDevice,
                                          child: Row(
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: controller
                                                    .listSteps.value
                                                    .map((e) {
                                                  // ignore: sized_box_for_whitespace
                                                  return Container(
                                                    height: (e['step'] !=
                                                            controller.listSteps
                                                                .length)
                                                        ? 180
                                                        : 180,
                                                    child: Row(
                                                      children: [
                                                        Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Row(
                                                              children: [
                                                                e['step'] > 9
                                                                    ? Text(
                                                                        '${e['step']}',
                                                                        style: const TextStyle(
                                                                            fontWeight: FontWeight
                                                                                .w600,
                                                                            fontSize:
                                                                                18,
                                                                            color: AppColors
                                                                                .primaryColor1))
                                                                    : Text(
                                                                        '0${e['step']}',
                                                                        style: const TextStyle(
                                                                            fontWeight: FontWeight
                                                                                .w600,
                                                                            fontSize:
                                                                                18,
                                                                            color:
                                                                                AppColors.primaryColor1)),
                                                                const SizedBox(
                                                                    width: 5),
                                                                Container(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            5),
                                                                    decoration: BoxDecoration(
                                                                        shape: BoxShape
                                                                            .circle,
                                                                        color: Colors
                                                                            .white,
                                                                        border: Border.all(
                                                                            width:
                                                                                1,
                                                                            color:
                                                                                AppColors.primaryColor1)),
                                                                    child: Container(
                                                                        width: 15,
                                                                        height: 15,
                                                                        decoration: const BoxDecoration(
                                                                          shape:
                                                                              BoxShape.circle,
                                                                          color:
                                                                              AppColors.primaryColor1,
                                                                        ))),
                                                              ],
                                                            ),
                                                            (e['step'] <
                                                                    controller
                                                                        .listSteps
                                                                        .length)
                                                                ? Column(
                                                                    children: [
                                                                      for (int i =
                                                                              0;
                                                                          i < 25;
                                                                          i++)
                                                                        Row(
                                                                          children: [
                                                                            const SizedBox(
                                                                              width: 29,
                                                                            ),
                                                                            Container(
                                                                              height: 6,
                                                                              width: 1,
                                                                              color: (i % 2 != 0) ? AppColors.primaryColor1 : Colors.white,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                    ],
                                                                  )
                                                                : Container(),
                                                          ],
                                                        ),
                                                        const SizedBox(
                                                            width: 20),
                                                        SizedBox(
                                                          width:
                                                              widthDevice - 115,
                                                          child: Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                'Step ${e['step']}',
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .black,
                                                                  fontSize: 18,
                                                                ),
                                                              ),
                                                              Text(
                                                                '${e['s']}',
                                                                style:
                                                                    const TextStyle(
                                                                  color: Colors
                                                                      .grey,
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                            ],
                                          ),
                                        ),
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
                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: AppBarWorkout(title: '', press: () {}),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () {
                          print(controller.meal['asset'].runtimeType);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: widthDevice * 0.6,
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
                                offset: const Offset(-2, -3),
                                blurRadius: 2,
                              )
                            ],
                          ),
                          child: const Text(
                            'Add to Breakfast Meal',
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
                  ),
                ],
              ),
            ),
    );
  }
}

class NutritionCard extends StatelessWidget {
  const NutritionCard({
    Key? key,
    required this.imagePath,
    required this.data,
    required this.type,
  }) : super(key: key);
  final String imagePath;
  final int data;
  final String type;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 16),
      margin: const EdgeInsets.only(right: 12),
      decoration: BoxDecoration(
        color: AppColors.primaryColor1.withOpacity(0.3),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Image.asset(
            imagePath,
            width: 30,
            height: 30,
          ),
          const SizedBox(width: 5),
          Text(
            // ignore: unnecessary_brace_in_string_interps
            '${data}${type}',
            style: const TextStyle(
              color: Colors.black,
              fontSize: 15,
            ),
          )
        ],
      ),
    );
  }
}

class IngredientsCard extends StatelessWidget {
  const IngredientsCard(
      {Key? key,
      required this.imagePath,
      required this.data,
      required this.name})
      : super(key: key);
  final String imagePath;
  final String data;
  final String name;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(28),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.05),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Image.asset(imagePath, width: 60, height: 60),
          ),
          Text(
            name,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
          Text(
            data,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }
}
