import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/meal_plan_controller.dart';
import 'package:gold_health/apps/global_widgets/list_chart/line_chart1_line.dart';
import 'package:gold_health/apps/global_widgets/screen_template.dart';
import 'package:gold_health/apps/pages/mealPlanner/widgets/control_meal_card.dart';
import 'package:gold_health/apps/pages/mealPlanner/widgets/meal_select.dart';
import 'package:gold_health/apps/pages/mealPlanner/widgets/today_meal_card.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../global_widgets/button_custom/Button_icon_gradient_color.dart';
import '../../global_widgets/button_custom/button_text.dart';
import '../../routes/route_name.dart';
import '../../template/misc/colors.dart';
import 'meal_schedule_screen.dart';

class MealPlannerScreen extends StatelessWidget {
  MealPlannerScreen({Key? key}) : super(key: key);
  final controller = Get.put(MealPlanController());
  @override
  Widget build(BuildContext context) {
    //var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;

    List<String> tabs = [
      'Nutrition',
      'Workout',
      'Foot step',
      'Water',
      'Fasting',
      'Sleep',
    ];
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: ScreenTemplate(
        child: GetBuilder<MealPlanController>(
          init: MealPlanController(),
          builder: (controller) {
            return Obx(
              () => (controller == null)
                  ? const Center(
                      child: CircularProgressIndicator(
                          color: AppColors.primaryColor1),
                    )
                  : Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: () async {
                                  int? newIndex;
                                  await _showDialogMethod(
                                    context: context,
                                    tabs: tabs,
                                    onselectedTabs: (value) {
                                      newIndex = value;
                                    },
                                    done: () {
                                      print(newIndex);
                                      if (newIndex != null) {
                                        controller.changeTab(newIndex ?? 0);
                                      }
                                      Navigator.pop(context);
                                    },
                                  );
                                },
                                child: Row(
                                  children: const [
                                    Text(
                                      'Meal Planner',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Icon(
                                      Icons.keyboard_arrow_down_outlined,
                                      color: Colors.black,
                                      size: 24,
                                    )
                                  ],
                                ),
                              ),
                              const Spacer(),
                              InkWell(
                                onTap: () {
                                  controller.Ok();
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryColor1
                                        .withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(
                                    Icons.more_horiz,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: [
                              Text(
                                'Meal Nutritions',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline4!
                                    .copyWith(
                                      fontSize: 17,
                                    ),
                              ),
                              const Spacer(),
                              ButtonIconGradientColor(
                                title: ' Week',
                                icon: Icons.calendar_month,
                                press: () async {
                                  await _showDatePicker(context: context);
                                },
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: [
                              Text(
                                DateFormat()
                                    .add_yMMMMd()
                                    .format(controller.startDate.value)
                                    .toString(),
                                style: const TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              ),
                              const Text(
                                ' - ',
                                style: TextStyle(
                                    color: AppColors.primaryColor1,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              ),
                              Text(
                                DateFormat()
                                    .add_yMMMMd()
                                    .format(controller.finishDate.value)
                                    .toString(),
                                style: const TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: SizedBox(
                            width: widthDevice,
                            height: 200,
                            // ignore: avoid_unnecessary_containers
                            child: Container(
                              child: const LineChartOneLine(),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: const [
                              ControlMealCard(
                                  header: 'Calories', percent: 0.82),
                              ControlMealCard(header: 'Carbs', percent: 0.39),
                              ControlMealCard(
                                  header: 'Proteins', percent: 0.88),
                              ControlMealCard(header: 'fats', percent: 0.42),
                              SizedBox(width: 20),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(
                            width: widthDevice,
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  AppColors.primaryColor1.withOpacity(0.1),
                                  AppColors.primaryColor2.withOpacity(0.1)
                                ],
                              ),
                            ),
                            child: Row(
                              children: [
                                const Text(
                                  'Daily Meal Scheduele',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const Spacer(),
                                ButtonText(
                                  press: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const MealScheduleScreen(),
                                      ),
                                    );
                                  },
                                  title: 'Check',
                                  color: AppColors.primaryColor1,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Container(
                            width: widthDevice,
                            padding: const EdgeInsets.symmetric(
                                vertical: 20, horizontal: 20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  AppColors.primaryColor1.withOpacity(0.1),
                                  AppColors.primaryColor2.withOpacity(0.1)
                                ],
                              ),
                            ),
                            child: Row(
                              children: [
                                const Text(
                                  'Amount of food absorbed',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                const Spacer(),
                                ButtonText(
                                  press: () {
                                    Get.toNamed(RouteName.dailyNutritionScreen,
                                        arguments: controller.listMealToday);
                                  },
                                  title: 'Check',
                                  color: AppColors.primaryColor1,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Row(
                            children: [
                              Obx(
                                () => Text(
                                  'Today Meals ${controller.listMealToday.length}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4!
                                      .copyWith(
                                        fontSize: 17,
                                      ),
                                ),
                              ),
                              const Spacer(),
                              ButtonIconGradientColor(
                                title: ' Breakfast',
                                icon: Icons.keyboard_arrow_down_sharp,
                                press: () {
                                  // for(var item in controller.dateController.selectedDates!){

                                  // }
                                  controller.allDateBetWeen.value =
                                      controller.getListDateBetWeenRange();
                                  for (var item
                                      in controller.allDateBetWeen.value) {
                                    print(item.toString() +
                                        ' ' +
                                        item.weekday.toString());
                                  }
                                },
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: controller.listMealToday.isEmpty
                              ? const Center(
                                  child: CircularProgressIndicator(
                                      color: AppColors.primaryColor))
                              : Column(
                                  children: [
                                    for (int i = 0;
                                        i <
                                            controller.listMealToday.length -
                                                30;
                                        i++)
                                      TodayMealCard(
                                        widthDevice: widthDevice,
                                        title: controller.listMealToday[i].name,
                                        time: 'Today | 3am',
                                        imagePath:
                                            controller.listMealToday[i].asset,
                                        press: () {
                                          Get.toNamed(
                                            RouteName.mealDetail,
                                            arguments: controller
                                                .listMealToday[i]
                                                .toJson(),
                                          );
                                        },
                                      ),
                                  ],
                                ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Find Something to Eat',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline4!
                                  .copyWith(
                                    fontSize: 17,
                                  ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              MealSelect(
                                imagePath: 'assets/images/break.png',
                                color: AppColors.primaryColor1.withOpacity(0.2),
                                color_btn: AppColors.primaryColor1,
                                collect: 'Breakfast',
                                noFoods: controller.listMealBreakFast.length,
                                press: () {
                                  Get.toNamed(
                                    RouteName.categoryMeal,
                                    arguments: controller.listMealBreakFast,
                                  );
                                },
                              ),
                              const SizedBox(width: 10),
                              MealSelect(
                                imagePath: 'assets/images/lunch.png',
                                color: AppColors.primaryColor2.withOpacity(0.2),
                                color_btn: AppColors.primaryColor2,
                                collect: 'Lunch/Dinner',
                                noFoods: controller.listMealLunch.length,
                                press: () {
                                  Get.toNamed(
                                    RouteName.categoryMeal,
                                    arguments: controller.listMealLunch,
                                  );
                                },
                              ),
                              const SizedBox(width: 15),
                              MealSelect(
                                imagePath: 'assets/images/snack.png',
                                color: AppColors.primaryColor.withOpacity(0.2),
                                color_btn: AppColors.primaryColor,
                                collect: 'Snack/Smooth',
                                noFoods: controller.listMealDinner.length,
                                press: () {
                                  Get.toNamed(
                                    RouteName.categoryMeal,
                                    arguments: controller.listMealDinner,
                                  );
                                },
                              ),
                              const SizedBox(width: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
            );
          },
        ),
      ),
    );
  }

  _showDatePicker({required BuildContext context}) async {
    await showDialog(
      useRootNavigator: false,
      barrierColor: Colors.black54,
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(10),
          height: 430,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: AppColors.mainColor,
          ),
          child: Column(
            children: [
              Card(
                elevation: 2,
                child: SfDateRangePicker(
                  selectionTextStyle:
                      const TextStyle(fontWeight: FontWeight.bold),
                  rangeTextStyle: const TextStyle(fontWeight: FontWeight.bold),
                  headerStyle: const DateRangePickerHeaderStyle(
                    backgroundColor: AppColors.primaryColor1,
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  monthCellStyle: const DateRangePickerMonthCellStyle(
                    textStyle: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  selectionColor: AppColors.primaryColor1,
                  rangeSelectionColor: AppColors.primaryColor1,
                  todayHighlightColor: AppColors.primaryColor1,
                  controller: controller.dateController,
                  view: DateRangePickerView.month,
                  selectionMode: DateRangePickerSelectionMode.range,
                  onSelectionChanged: controller.selectionChanged,
                  monthViewSettings: const DateRangePickerMonthViewSettings(
                      enableSwipeSelection: false),
                ),
              ),
              const Spacer(),
              Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: AppColors.primaryColor1,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    controller.selectDateDoneClick();
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      primary: Colors.transparent,
                      shadowColor: Colors.transparent),
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
            ],
          ),
        ),
      ),
    );
  }

  _showDialogMethod({
    required BuildContext context,
    required List<String> tabs,
    required Function(int)? onselectedTabs,
    required Function() done,
  }) async {
    await showDialog(
      useRootNavigator: false,
      barrierColor: Colors.black54,
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            alignment: Alignment.center,
            height: 300,
            width: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.mainColor,
              //   color: Colors.transparent,
            ),
            child: Column(
              children: [
                Container(
                  height: 200,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: CupertinoPicker(
                    onSelectedItemChanged: onselectedTabs,
                    selectionOverlay: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            width: 3, color: AppColors.primaryColor1),
                      ),
                    ),
                    itemExtent: 50,
                    diameterRatio: 1.2,
                    children: [
                      for (var item in tabs)
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            item,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        )
                    ],
                  ),
                ),
                const Spacer(),
                Container(
                  margin: const EdgeInsets.all(10),
                  height: 50,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.primaryColor1,
                  ),
                  child: ElevatedButton(
                    onPressed: done,
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        primary: Colors.transparent,
                        shadowColor: Colors.transparent),
                    child: const Text(
                      'Done',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class AppBarDesign extends StatelessWidget {
  const AppBarDesign({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primaryColor1.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
        ),
        const Spacer(),
        Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        const Spacer(),
        InkWell(
          onTap: () {},
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.primaryColor1.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.more_horiz,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
