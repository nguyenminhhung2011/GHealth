import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/dailyPlanController/meal_plan/meal_schedule_controller.dart';
import 'package:gold_health/apps/pages/mealPlanner/widgets/food_schedule_card.dart';
import 'package:gold_health/apps/pages/mealPlanner/widgets/meal_nutrition_card.dart';
import 'package:intl/intl.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

import '../../global_widgets/screen_template.dart';
import '../../template/misc/colors.dart';
import 'meal_planner_screen.dart';

class MealScheduleScreen extends StatefulWidget {
  MealScheduleScreen({Key? key}) : super(key: key);
  final _controller = Get.find<MealScheduleC>();
  @override
  State<MealScheduleScreen> createState() => _MealScheduleScreenState();
}

class _MealScheduleScreenState extends State<MealScheduleScreen> {
  DateTime dateTime = DateTime.now();
  var now = DateTime.now().obs;
  Timer? timer;

  GlobalKey<ScrollSnapListState> sslKey = GlobalKey();

  Widget _itemBuilder(BuildContext context, int index) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(10),
      width: 80,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: widget._controller.onFocus == index
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
              DateFormat()
                  .add_E()
                  .format(widget._controller.listDateTime[index]),
              style: TextStyle(
                color: widget._controller.onFocus == index
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            Text(
              DateFormat()
                  .add_d()
                  .format(widget._controller.listDateTime[index]),
              style: TextStyle(
                color: widget._controller.onFocus == index
                    ? Colors.white
                    : Colors.black,
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
    for (int i = 0; i < widget._controller.listDateTime.length; i++) {
      if (DateFormat().add_yMd().format(widget._controller.listDateTime[i]) ==
          DateFormat().add_yMd().format(DateTime.now())) {
        widget._controller.setFocus1(i);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;
    late FixedExtentScrollController _controller =
        FixedExtentScrollController();

    return GetBuilder<MealScheduleC>(
        init: MealScheduleC(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: AppColors.mainColor,
            body: ScreenTemplate(
                child: Obx(
              () => Padding(
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
                            int index = controller.onFocus;
                            controller
                                .focusDegree(controller.listDateTime[index--]);
                            sslKey.currentState!.focusToItem(
                              controller.onFocus,
                            );
                          },
                          icon: Icon(
                            Icons.arrow_back_ios_new_outlined,
                            size: 18,
                            color: Colors.grey[400],
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '${DateFormat().add_MMM().format(controller.listDateTime[controller.onFocus])} ${controller.listDateTime[controller.onFocus].year}',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        const SizedBox(width: 8),
                        IconButton(
                          onPressed: () {
                            int index = controller.onFocus;

                            controller
                                .focusePluss(controller.listDateTime[index++]);
                            sslKey.currentState!
                                .focusToItem(controller.onFocus);
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
                        itemCount: controller.listDateTime.length,
                        itemSize: 100,
                        dispatchScrollNotifications: true,
                        initialIndex: controller.onFocus.toDouble(),
                        scrollPhysics: const ScrollPhysics(),
                        duration: 1000,
                        onItemFocus: (int index) {
                          controller.setFocus(
                              index, controller.listDateTime[index]);
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    // ignore: avoid_unnecessary_containers, sized_box_for_whitespace
                    Container(
                      width: double.infinity,
                      child: Row(
                        children: [
                          const Text(
                            'Breakfast',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${controller.mealDate.value['BreakFast'].length} meals | ${controller.listCalories.value[0]} calories',
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 15),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    (controller.mealDate.value['BreakFast'].isEmpty)
                        ? const Center(
                            child: CircularProgressIndicator(
                                backgroundColor: Colors.white,
                                color: AppColors.primaryColor1))
                        : Column(
                            children: [
                              for (var item
                                  in controller.mealDate.value['BreakFast'])
                                FoodScheduleCard(
                                  imagePath: item.asset,
                                  name: item.name,
                                  time: DateFormat.jm()
                                      .format(controller.timeEat[0]),
                                  press: () {},
                                  color:
                                      AppColors.primaryColor2.withOpacity(0.2),
                                )
                            ],
                          ),
                    const SizedBox(height: 15),
                    // ignore: sized_box_for_whitespace
                    Container(
                      width: double.infinity,
                      child: Row(
                        children: [
                          const Text(
                            'Lunch',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${controller.mealDate.value['Lunch'].length} meals | ${controller.listCalories.value[1]} calories',
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 15),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    (controller.mealDate.value['Lunch'].isEmpty)
                        ? const Center(
                            child: CircularProgressIndicator(
                                backgroundColor: Colors.white,
                                color: AppColors.primaryColor1))
                        : Column(
                            children: [
                              for (var item
                                  in controller.mealDate.value['Lunch'])
                                FoodScheduleCard(
                                  imagePath: item.asset,
                                  name: item.name,
                                  time: DateFormat.jm()
                                      .format(controller.timeEat[1]),
                                  press: () {},
                                  color:
                                      AppColors.primaryColor1.withOpacity(0.2),
                                )
                            ],
                          ),

                    const SizedBox(height: 15),
                    // ignore: sized_box_for_whitespace
                    Container(
                      width: double.infinity,
                      child: Row(
                        children: [
                          const Text(
                            'Snack',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${controller.mealDate.value['Snack'].length} meals | ${controller.listCalories.value[2]} calories',
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 15),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    (controller.mealDate.value['Snack'].isEmpty)
                        ? const Center(
                            child: CircularProgressIndicator(
                                backgroundColor: Colors.white,
                                color: AppColors.primaryColor1))
                        : Column(
                            children: [
                              for (var item
                                  in controller.mealDate.value['Snack'])
                                FoodScheduleCard(
                                  imagePath: item.asset,
                                  name: item.name,
                                  time: DateFormat.jm()
                                      .format(controller.timeEat[2]),
                                  press: () {},
                                  color:
                                      AppColors.primaryColor2.withOpacity(0.2),
                                )
                            ],
                          ),
                    const SizedBox(height: 15),
                    // ignore: sized_box_for_whitespace
                    Container(
                      width: double.infinity,
                      child: Row(
                        children: [
                          const Text(
                            'Dinner',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const Spacer(),
                          Text(
                            '${controller.mealDate.value['Dinner'].length} meals | ${controller.listCalories.value[3]} calories',
                            style: const TextStyle(
                                color: Colors.grey, fontSize: 15),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    (controller.mealDate.value['Dinner'].isEmpty)
                        ? const Center(
                            child: CircularProgressIndicator(
                                backgroundColor: Colors.white,
                                color: AppColors.primaryColor1))
                        : Column(
                            children: [
                              for (var item
                                  in controller.mealDate.value['Dinner'])
                                FoodScheduleCard(
                                  imagePath: item.asset,
                                  name: item.name,
                                  time: DateFormat.jm()
                                      .format(controller.timeEat[3]),
                                  press: () {},
                                  color:
                                      AppColors.primaryColor1.withOpacity(0.2),
                                )
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
                    Obx(
                      () => Column(
                        children: [
                          MealNutritionCard(
                            widthDevice: widthDevice,
                            imagePath: 'assets/images/calories.png',
                            title: 'Calories',
                            data:
                                '${controller.listNutritionConsume.value[0]}/${controller.calories.value} kCal',
                            percent: controller.listNutritionConsume.value[0] /
                                controller.calories.value,
                          ),
                          MealNutritionCard(
                            widthDevice: widthDevice,
                            imagePath: 'assets/images/protein.png',
                            title: 'Proteins',
                            data:
                                '${controller.listNutritionConsume.value[1]}/${controller.proteins.value}g',
                            percent: controller.listNutritionConsume.value[1] /
                                controller.proteins.value,
                          ),
                          MealNutritionCard(
                            widthDevice: widthDevice,
                            imagePath: 'assets/images/trans-fat.png',
                            title: 'Fats',
                            data:
                                '${controller.listNutritionConsume.value[2]}/${controller.fats.value}g',
                            percent: controller.listNutritionConsume.value[2] /
                                controller.fats.value,
                          ),
                          MealNutritionCard(
                            widthDevice: widthDevice,
                            imagePath: 'assets/images/strach.png',
                            title: 'Carbo',
                            data:
                                '${controller.listNutritionConsume.value[3]}/${controller.carbo.value} g',
                            percent: controller.listNutritionConsume.value[3] /
                                controller.carbo.value,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )),
          );
        });
  }

  @override
  void dispose() {
    super.dispose();
    // _calendarController.dispose();
    timer!.cancel();
  }
}
