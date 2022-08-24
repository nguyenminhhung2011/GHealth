import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/dailyPlanController/meal_plan/add_food_nutri_controller.dart';
import 'package:gold_health/apps/pages/list_plan_screen/select_amount_food.dart';

import '../../controls/dailyPlanController/meal_plan/daily_nutrition_controller.dart';
import '../../data/models/Meal.dart';
import '../../template/misc/colors.dart';

class AddFoodScreen extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  AddFoodScreen({Key? key}) : super(key: key);

  @override
  State<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  final _controller = Get.put(AddFoddNutriC());

  // List<Map<String, dynamic>> foodTemp = [
  //   {'temp': 0}
  // ];
  // RxMap<String, dynamic> foodData = [];
  @override
  Widget build(BuildContext context) {
    // var widthDevice = MediaQuery.of(context).size.width;
    // var heightDevice = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () {
            _controller.dailyNutriC.clearFoodTemp();
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Add Food',
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              for (var item in _controller.dailyNutriC.allMeal) {
                //   _controller.dailyNutriC.listFoodToday.add(item);
              }
              _controller.dailyNutriC.clearFoodTemp();
              Navigator.pop(context);
            },
            icon: const Icon(Icons.check, color: AppColors.primaryColor1),
          )
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.grey.withOpacity(0.08)),
              child: Row(
                children: [
                  const Icon(Icons.search, color: Colors.black),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Search",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Obx(
            () => Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: RichText(
                  text: TextSpan(
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: "Amount: ",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.9),
                        ),
                      ),
                      TextSpan(
                        text: (_controller.dailyNutriC.foodTemp.length)
                            .toString(),
                        style: const TextStyle(
                          color: AppColors.primaryColor1,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // ignore: avoid_unnecessary_containers
          Obx(
            () => Expanded(
              // height: heightDevice,
              // width: widthDevice,
              child: ListView(
                  physics: const BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  children: [
                    for (int i = 0;
                        i < _controller.dailyNutriC.allMeal.length;
                        i++)
                      _foodSelectCard(
                        _controller.dailyNutriC.foodSelect[i],
                        _controller.dailyNutriC.allMeal[i],
                      )
                  ]
                  // _controller.dailyNutriC.allMeal
                  //     .map(
                  //       (e) => _foodSelectCard(e),
                  //     )
                  //     .toList(),
                  ),
            ),
          )
        ],
      ),
    );
  }

  Padding _foodSelectCard(Map<String, dynamic> selectItem, Meal foodItem) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: InkWell(
        onTap: () async {
          // e['select'] = !e['select'];

          if (!selectItem['select']) {
            await Get.bottomSheet(
              isScrollControlled: true,
              enterBottomSheetDuration: const Duration(milliseconds: 100),
              Container(
                margin: const EdgeInsets.only(top: 100),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                  child: SelectAmountFood(
                      foodItem: foodItem, selectItem: selectItem),
                ),
              ),
            );
          } else {
            setState(() {
              selectItem['select'] = false;
              _controller.dailyNutriC.foodTemp
                  .removeWhere((element) => element['id'] == selectItem['id']);
            });
          }
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              width: 2,
              color: (selectItem['select'])
                  ? AppColors.primaryColor1
                  : Colors.transparent,
            ),
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
                    image: DecorationImage(image: NetworkImage(foodItem.asset)),
                  ),
                ),
                const SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      foodItem.name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    Text(
                      '${foodItem.kCal} kCal / 1 amount',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
                const Spacer(),
                Container(
                  width: 20,
                  height: 20,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 2,
                      color: !(selectItem['select'])
                          ? Colors.grey.withOpacity(0.3)
                          : AppColors.primaryColor1,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (selectItem['select'])
                          ? AppColors.primaryColor1
                          : Colors.transparent,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
