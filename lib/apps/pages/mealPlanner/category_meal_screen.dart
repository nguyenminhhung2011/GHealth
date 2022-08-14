import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gold_health/apps/global_widgets/ButtonText.dart';
import 'package:gold_health/apps/global_widgets/screenTemplate.dart';
import 'package:gold_health/apps/pages/mealPlanner/widgets/CategoryMealCard.dart';
import 'package:gold_health/apps/pages/mealPlanner/widgets/FoodViewCard.dart';
import 'package:gold_health/apps/pages/mealPlanner/widgets/PopularFoodCard.dart';
import 'package:gold_health/apps/pages/mealPlanner/widgets/SearchContainer.dart';

import '../../template/misc/colors.dart';
import 'mealPlannerScreen.dart';
import 'meal_detail_screen.dart';

class CategoryMealScreen extends StatelessWidget {
  const CategoryMealScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _heightDevice = MediaQuery.of(context).size.height;
    var _widthDevice = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: ScreenTemplate(
        child: Column(
          children: [
            const Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: AppBarDesign(title: 'Beakfast'),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: SearchContainer(widthDevice: _widthDevice),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Category',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontSize: 18,
                      ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  CategoryMealCard(
                    imagePath: 'assets/images/break.png',
                    name: "Salad",
                    press: () {},
                  ),
                  CategoryMealCard(
                    imagePath: 'assets/images/lunch.png',
                    name: "Cake",
                    press: () {},
                  ),
                  CategoryMealCard(
                    imagePath: 'assets/images/dinner.png',
                    name: "Pie",
                    press: () {},
                  ),
                  CategoryMealCard(
                    imagePath: 'assets/images/break.png',
                    name: "Smoothing",
                    press: () {},
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
                  'Recommendation for Diet',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontSize: 18,
                      ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  FoodViewCard(
                    nameFoods: 'Honey Pancak',
                    imagePath: 'assets/images/lunch.png',
                    level: "Easy",
                    time: 30,
                    kCal: 180,
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MealDetailScreen(),
                        ),
                      );
                    },
                    checkCOlor: 0,
                  ),
                  FoodViewCard(
                    nameFoods: 'Canai Breach',
                    imagePath: 'assets/images/dinner.png',
                    level: "Easy",
                    time: 20,
                    kCal: 230,
                    press: () {},
                    checkCOlor: 1,
                  ),
                  FoodViewCard(
                    nameFoods: 'Honey Pancak',
                    imagePath: 'assets/images/lunch.png',
                    level: "Easy",
                    time: 30,
                    kCal: 180,
                    press: () {},
                    checkCOlor: 0,
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
                  'Popular',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontSize: 18,
                      ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  PopularFoodCard(
                    widthDevice: _widthDevice,
                    title: 'Blubery Pancake',
                    time: 30,
                    imagePath: 'assets/images/lunch.png',
                    press: () {},
                    level: 'Medium',
                    kCal: 230,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
