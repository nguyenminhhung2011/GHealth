import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/dailyPlanController/meal_plan/category_meal_controller.dart';
import 'package:gold_health/apps/global_widgets/screen_template.dart';
import 'package:gold_health/apps/pages/mealPlanner/widgets/category_meal_card.dart';
import 'package:gold_health/apps/pages/mealPlanner/widgets/food_view_card.dart';
import 'package:gold_health/apps/pages/mealPlanner/widgets/popular_food_card.dart';
import 'package:gold_health/apps/pages/mealPlanner/widgets/search_container.dart';
import '../../routes/route_name.dart';
import '../../template/misc/colors.dart';
import 'meal_planner_screen.dart';

class CategoryMealScreen extends StatelessWidget {
  CategoryMealScreen({Key? key}) : super(key: key);
  final controller = Get.find<CategoryMealC>();
  @override
  Widget build(BuildContext context) {
    // var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;
    return Obx(
      () => (controller.listMeal.isEmpty)
          ? const Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor1))
          : Scaffold(
              backgroundColor: AppColors.mainColor,
              body: ScreenTemplate(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: AppBarDesign(
                        title: controller.listMeal[0].time == 1
                            ? 'Breakfast'
                            : controller.listMeal[0].time == 2
                                ? 'Lunch'
                                : 'Dinner',
                      ),
                    ),
                    const SizedBox(height: 40),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: SearchContainer(
                        widthDevice: widthDevice,
                        onTextChange: (value) => controller.searchMeal(value),
                        controller: controller.searchController,
                      ),
                    ),
                    const SizedBox(height: 30),
                    (controller.searchController.text != '')
                        ? controller.listMealSearch.isNotEmpty
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Column(
                                  children: controller.listMealSearch
                                      .map(
                                        (e) => PopularFoodCard(
                                          widthDevice: widthDevice,
                                          title: e.name,
                                          time: 30,
                                          imagePath: e.asset,
                                          press: () => Get.toNamed(
                                            RouteName.mealDetail,
                                            arguments: e.toJson(),
                                          ),
                                          kCal: e.kCal,
                                        ),
                                      )
                                      .toList(),
                                ),
                              )
                            : Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset('assets/images/notfound.png',
                                        height: 60, width: 60),
                                    const Text(
                                      'Meal isn\'t found',
                                      style: TextStyle(
                                        color: AppColors.primaryColor1,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                        : Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Category',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(
                                          fontSize: 18,
                                        ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                    children: controller.listCategory
                                        .map(
                                          (e) => CategoryMealCard(
                                            imagePath: e['asset'],
                                            name: e['name'],
                                            press: () => controller
                                                .onClickCategoryCard(e['name']),
                                          ),
                                        )
                                        .toList()),
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Recommendation for Diet',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(
                                          fontSize: 18,
                                        ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    children: [
                                      for (int i = 0;
                                          i < controller.listMeal.length;
                                          i++)
                                        FoodViewCard(
                                          nameFoods:
                                              controller.listMeal[i].name,
                                          imagePath:
                                              controller.listMeal[i].asset,
                                          kCal: controller.listMeal[i].kCal,
                                          press: () => Get.toNamed(
                                            RouteName.mealDetail,
                                            arguments:
                                                controller.listMeal[i].toJson(),
                                          ),
                                          checkCOlor: i % 2,
                                          time: controller.listMeal[i].timeCook,
                                        )
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Popular',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline4!
                                          .copyWith(
                                            fontSize: 18,
                                          ),
                                    ),
                                    InkWell(
                                      onTap: () => Get.toNamed(
                                        RouteName.viewMeal,
                                        arguments: controller.listMeal,
                                      ),
                                      child: Text(
                                        'See More',
                                        style: TextStyle(
                                            color: Colors.grey.withOpacity(0.5),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0),
                                child: Column(
                                  children: [
                                    for (int i = 0;
                                        i < controller.listMeal.length;
                                        i++)
                                      PopularFoodCard(
                                        widthDevice: widthDevice,
                                        title: controller.listMeal[i].name,
                                        time: controller.listMeal[i].timeCook,
                                        imagePath: controller.listMeal[i].asset,
                                        press: () => Get.toNamed(
                                          RouteName.mealDetail,
                                          arguments:
                                              controller.listMeal[i].toJson(),
                                        ),
                                        kCal: controller.listMeal[i].kCal,
                                      ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                  ],
                ),
              ),
            ),
    );
  }
}
