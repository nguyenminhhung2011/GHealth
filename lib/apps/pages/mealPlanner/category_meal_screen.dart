import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gold_health/apps/global_widgets/ButtonText.dart';

import '../../template/misc/colors.dart';
import 'mealPlannerScreen.dart';

class CategoryMealScreen extends StatelessWidget {
  const CategoryMealScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _heightDevice = MediaQuery.of(context).size.height;
    var _widthDevice = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      extendBody: true,
      body: Stack(
        children: [
          Container(
            width: _widthDevice,
            height: _heightDevice,
            decoration: BoxDecoration(
              color: AppColors.mainColor,
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
                      ConstrainedBox(
                        constraints: BoxConstraints(minHeight: _heightDevice),
                        child: Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                          ),
                          child: SingleChildScrollView(
                            physics: const NeverScrollableScrollPhysics(),
                            child: Column(
                              children: [
                                AppBarDesign(title: 'Beakfast'),
                                const SizedBox(height: 40),
                                SearchContainer(widthDevice: _widthDevice),
                                const SizedBox(height: 30),
                                Align(
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
                                Align(
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
                                        press: () {},
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
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'Popular',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline4!
                                        .copyWith(
                                          fontSize: 18,
                                        ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Column(
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
        ],
      ),
    );
  }
}

class FoodViewCard extends StatelessWidget {
  const FoodViewCard({
    Key? key,
    required this.nameFoods,
    required this.level,
    required this.time,
    required this.kCal,
    required this.press,
    required this.checkCOlor,
    required this.imagePath,
  }) : super(key: key);
  final String nameFoods;
  final String imagePath;
  final String level;
  final int time;
  final int kCal;
  final Function() press;
  final int checkCOlor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: (checkCOlor == 0)
            ? AppColors.primaryColor1.withOpacity(0.2)
            : AppColors.primaryColor2.withOpacity(0.2),
      ),
      child: Column(
        children: [
          Image.asset(
            imagePath,
            width: 130,
            height: 130,
          ),
          Text(
            nameFoods,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w600,
              fontSize: 18,
            ),
          ),
          Text(
            '${level} | ${time}mins | ${kCal}kCal',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 20),
          ButtonText(
            press: press,
            title: 'View',
            color: (checkCOlor == 0)
                ? AppColors.primaryColor1
                : AppColors.primaryColor2,
          )
        ],
      ),
    );
  }
}

class CategoryMealCard extends StatelessWidget {
  const CategoryMealCard({
    Key? key,
    required this.imagePath,
    required this.name,
    required this.press,
  }) : super(key: key);
  final String imagePath;
  final String name;
  final Function() press;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: press,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: AppColors.primaryColor1.withOpacity(0.4)),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.5),
                ),
                child: Image.asset(
                  imagePath,
                  height: 40,
                  width: 40,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                name,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 17,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SearchContainer extends StatelessWidget {
  const SearchContainer({
    Key? key,
    required double widthDevice,
  })  : _widthDevice = widthDevice,
        super(key: key);

  final double _widthDevice;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _widthDevice,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            offset: const Offset(2, 3),
            blurRadius: 20,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            offset: Offset(-2, -3),
            blurRadius: 20,
          )
        ],
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/Search.svg',
            color: Colors.grey,
          ),
          const SizedBox(width: 5),
          Container(
            width: _widthDevice - 150,
            //color: Colors.red,
            child: TextFormField(
              decoration: InputDecoration(
                hintText: 'Search Pancake',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
          ),
          Expanded(
            child: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/icons/Filter.svg',
                color: AppColors.primaryColor1,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PopularFoodCard extends StatelessWidget {
  const PopularFoodCard({
    Key? key,
    required double widthDevice,
    required this.title,
    required this.time,
    required this.imagePath,
    required this.press,
    required this.level,
    required this.kCal,
  })  : _widthDevice = widthDevice,
        super(key: key);

  final double _widthDevice;
  final String title;
  final String level;
  final int time;
  final int kCal;
  final String imagePath;
  final Function() press;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: _widthDevice,
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            offset: const Offset(2, 3),
            blurRadius: 20,
          ),
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            offset: Offset(-2, -3),
            blurRadius: 20,
          )
        ],
      ),
      child: Row(
        children: [
          Image.asset(imagePath, width: 65, height: 65),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '${level} | ${time}mins | ${kCal}kCal',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          Spacer(),
          InkWell(
            borderRadius: BorderRadius.circular(13),
            onTap: press,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 1, color: AppColors.primaryColor1),
              ),
              child: Icon(
                Icons.arrow_forward_ios,
                color: AppColors.primaryColor1,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
