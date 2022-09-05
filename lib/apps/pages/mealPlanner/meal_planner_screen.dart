import 'package:fl_chart/fl_chart.dart';
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
            return Column(
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
                          // controller.Ok();
                          for (var item
                              in controller.mealToday.value['break']) {
                            print(item.name);
                          }
                        },
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
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Text(
                        'Meal Nutritions',
                        style: Theme.of(context).textTheme.headline4!.copyWith(
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
                Obx(
                  () => (controller.listWeekNutrition.isNotEmpty &&
                          controller.listDataNutriPlan.isNotEmpty)
                      ? chartLoading(widthDevice, controller)
                      : const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor1,
                            backgroundColor: Colors.white,
                          ),
                        ),
                ),
                const SizedBox(height: 20),
                Obx(
                  () => (controller.listWeekNutrition.isNotEmpty &&
                          controller.listDataNutriPlan.isNotEmpty)
                      ? listNutriWeekday(controller)
                      : const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor1,
                            backgroundColor: Colors.white,
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
                          'Daily Meal Scheduele',
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const Spacer(),
                        ButtonText(
                          press: () => Get.toNamed(
                            RouteName.mealSchedule,
                            arguments: {
                              'mealPlan': controller.listMealPlan,
                              'allMeal': controller.allMeal,
                              'timeEat': controller.timeEat,
                            },
                          ),
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
                            Get.toNamed(
                              RouteName.dailyNutritionScreen,
                              arguments: {
                                'allMeal': controller.allMeal,
                                'break': controller.listMealBreakFast,
                                'lunch': controller.listMealLunch,
                                'snack': controller.listMealSnack,
                                'dinner': controller.listMealLunch,
                              },
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
                  child: Row(
                    children: [
                      Text(
                        'Today Meals',
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              fontSize: 17,
                            ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: AppColors.primaryColor1,
                        ),
                        child: SizedBox(
                          height: 30,
                          child: DropdownButton<String>(
                            dropdownColor: AppColors.primaryColor1,
                            borderRadius: BorderRadius.circular(15),
                            value: controller.selectPlan.value,
                            elevation: 5,
                            icon: const Icon(Icons.keyboard_arrow_down,
                                color: Colors.white),
                            items: controller.mealPlan
                                .map(
                                  (e) => DropdownMenuItem<String>(
                                    value: e,
                                    child: Text(
                                      e,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                            onChanged: controller.selectPlan,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    // ignore: unnecessary_null_comparison
                    child: controller
                                .mealToday.value[controller.selectPlan.value] ==
                            null
                        ? const Center(
                            child: CircularProgressIndicator(
                                color: AppColors.primaryColor1))
                        : Column(
                            children: [
                              for (int i = 0;
                                  i <
                                      controller
                                          .mealToday
                                          .value[controller.selectPlan.value]
                                          .length;
                                  i++)
                                TodayMealCard(
                                  widthDevice: widthDevice,
                                  title: controller
                                      .mealToday
                                      .value[controller.selectPlan.value][i]
                                      .name,
                                  time:
                                      'Today | ${DateFormat.jm().format(controller.timeEat[controller.planInt])}',
                                  imagePath: controller
                                      .mealToday
                                      .value[controller.selectPlan.value][i]
                                      .asset,
                                  press: () {
                                    Get.toNamed(
                                      RouteName.mealDetail,
                                      arguments: controller.mealToday
                                          .value[controller.selectPlan.value][i]
                                          .toJson(),
                                    );
                                  },
                                ),
                            ],
                          ),
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Find Something to Eat',
                      style: Theme.of(context).textTheme.headline4!.copyWith(
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
                        noFoods: controller.listMealSnack.length,
                        press: () {
                          Get.toNamed(
                            RouteName.categoryMeal,
                            arguments: controller.listMealSnack,
                          );
                        },
                      ),
                      const SizedBox(width: 20),
                    ],
                  ),
                ),
              ],
              // ),
            );
          },
        ),
      ),
    );
  }

  SingleChildScrollView listNutriWeekday(MealPlanController controller) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ControlMealCard(
            header: 'Calories',
            percent: controller.listWeekNutrition[
                    controller.weekdayNutriFocus.value - 2]['kCal'] /
                controller.listDataNutriPlan[
                    controller.weekdayNutriFocus.value - 2]['kCal'],
          ),
          ControlMealCard(
            header: 'Carbs',
            percent: controller.listWeekNutrition[
                    controller.weekdayNutriFocus.value - 2]['carbs'] /
                controller.listDataNutriPlan[
                    controller.weekdayNutriFocus.value - 2]['carbs'],
          ),
          ControlMealCard(
            header: 'Proteins',
            percent: controller.listWeekNutrition[
                    controller.weekdayNutriFocus.value - 2]['pro'] /
                controller.listDataNutriPlan[
                    controller.weekdayNutriFocus.value - 2]['pro'],
          ),
          ControlMealCard(
            header: 'fats',
            percent: controller.listWeekNutrition[
                    controller.weekdayNutriFocus.value - 2]['fats'] /
                controller.listDataNutriPlan[
                    controller.weekdayNutriFocus.value - 2]['fats'],
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }

  Padding chartLoading(double widthDevice, MealPlanController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: SizedBox(
        width: widthDevice,
        height: 200,
        // ignore: avoid_unnecessary_containers
        child: Container(
          child: LineChartOneLine(
            callBack: (FlTouchEvent event, lineTouchResponse) {
              if (!event.isInterestedForInteractions ||
                  lineTouchResponse == null ||
                  lineTouchResponse.lineBarSpots == null) {
                return;
              }
              final value = lineTouchResponse.lineBarSpots![0].x;
              double add = (value == 1.0) ? 8.0 : value;
              controller.updateweekdayNutriFocus(add);
            },
            listData: [
              FlSpot(
                1 * 1.0,
                controller.listWeekNutrition[6]['kCal'] == 0
                    ? 1
                    : (controller.listWeekNutrition[6]['kCal'] >
                            controller.listDataNutriPlan[6]['kCal'])
                        ? 6
                        : (controller.listWeekNutrition[6]['kCal'] /
                            controller.listDataNutriPlan[6]['kCal'] *
                            6),
              ),
              for (int i = 1; i <= 6; i++)
                FlSpot(
                  (i + 1) * 1.0,
                  controller.listWeekNutrition[i - 1]['kCal'] == 0
                      ? 1
                      : (controller.listWeekNutrition[i - 1]['kCal'] >
                              controller.listDataNutriPlan[i - 1]['kCal'])
                          ? 6
                          : (controller.listWeekNutrition[i - 1]['kCal'] /
                              controller.listDataNutriPlan[i - 1]['kCal'] *
                              6),
                ),
            ],
          ),
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
