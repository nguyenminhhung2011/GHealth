import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/pages/list_plan_screen/select_amount_food.dart';
import '../../controls/dailyPlanController/meal_plan/daily_nutrition_controller.dart';
import '../../template/misc/colors.dart';

class AddFoodScreen extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  AddFoodScreen({Key? key}) : super(key: key);

  @override
  State<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  // final controller = Get.find<DailyNutritionController>();

  // List<Map<String, dynamic>> foodTemp = [
  //   {'temp': 0}
  // ];
  // RxMap<String, dynamic> foodData = [];
  @override
  Widget build(BuildContext context) {
    // var widthDevice = MediaQuery.of(context).size.width;
    // var heightDevice = MediaQuery.of(context).size.height;
    return GetBuilder<DailyNutritionController>(
      init: DailyNutritionController(),
      builder: (controller) {
        return Obx(
          () => Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Theme.of(context).cardColor,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.close, color: Colors.black),
                onPressed: () {
                  controller.clearFoodTemp();
                  controller.searchText = TextEditingController();
                  Navigator.pop(context);
                },
              ),
              title: const Text(
                'Add Food',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
              actions: [
                IconButton(
                  onPressed: () {
                    for (var item in controller.foodTemp) {
                      //   controller.listFoodToday.add(item);
                      // controller.listFoodToday.add(item);
                      controller.addNutriToFirebase(
                          item['id'], item['amount'], item['dateTime']);
                    }
                    controller.clearFoodTemp();
                    controller.update();
                    controller.searchText = TextEditingController();
                    Get.back();
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
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Colors.grey.withOpacity(0.08)),
                    child: Row(
                      children: [
                        const Icon(Icons.search, color: Colors.black),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            controller: controller.searchText,
                            onChanged: (value) {
                              controller.searchMeal(controller.searchText.text);
                            },
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
                const SizedBox(height: 20),
                Obx(
                  () => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        RichText(
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
                                text: (controller.foodTemp.length).toString(),
                                style: const TextStyle(
                                  color: AppColors.primaryColor1,
                                ),
                              ),
                            ],
                          ),
                        ),
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
                ),
                const SizedBox(height: 20),
                // ignore: avoid_unnecessary_containers
                (controller.searchText.text != '')
                    ? controller.listMealSearch.isNotEmpty
                        ? Expanded(
                            child: ListView(
                                physics: const BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics(),
                                ),
                                children: [
                                  for (int index = 0;
                                      index < controller.listMealSearch.length;
                                      index++)
                                    _foodSelectCard(
                                        controller.listMealSearch[index].id),
                                ]
                                // controller.allMeal
                                //     .map(
                                //       (e) => _foodSelectCard(e),
                                //     )
                                //     .toList(),
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
                    : Expanded(
                        child: ListView(
                          physics: const BouncingScrollPhysics(
                            parent: AlwaysScrollableScrollPhysics(),
                          ),
                          children: [
                            for (int i = 0;
                                i <
                                    controller
                                        .mealFindCate
                                        .value[controller.selectPlan.value]
                                        .length;
                                i++)
                              _foodSelectCard(controller.mealFindCate
                                  .value[controller.selectPlan.value][i].id),
                          ],
                          //  [
                          //   for (int index = 0;
                          //       index < controller.allMeal.length;
                          //       index++)
                          // ]
                          // controller.allMeal
                          //     .map(
                          //       (e) => _foodSelectCard(e),
                          //     )
                          //     .toList(),
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }

  GetBuilder<DailyNutritionController> _foodSelectCard(String id) {
    return GetBuilder<DailyNutritionController>(
        init: DailyNutritionController(),
        builder: (controller) {
          return Obx(
            () => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: InkWell(
                onTap: () async {
                  // e['select'] = !e['select'];

                  if (!controller.getFoodSelectFromId(id)['select']) {
                    await Get.bottomSheet(
                      isScrollControlled: true,
                      enterBottomSheetDuration:
                          const Duration(milliseconds: 100),
                      Container(
                        margin: const EdgeInsets.only(top: 100),
                        child: ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          ),
                          child: SelectAmountFood(
                            id: id,
                            // foodItem: controller.allMeal[index],
                            // selectItem: controller.foodSelect[index],
                          ),
                        ),
                      ),
                    );
                  } else {
                    controller.selectFalseandRemoveFoodTemp(id);
                  }
                },
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      width: 2,
                      color: (controller.getFoodSelectFromId(id)['select'])
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 20),
                    child: Row(
                      children: [
                        Image.network(
                          height: 50,
                          width: 80,
                          controller
                              .getMealFromId(id, controller.allMeal)
                              .asset,
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Center(
                              child: CircularProgressIndicator(
                                color: AppColors.primaryColor1,
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes!
                                    : null,
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                controller
                                    .getMealFromId(id, controller.allMeal)
                                    .name,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                ),
                              ),
                              Text(
                                '${controller.getMealFromId(id, controller.allMeal).kCal} kCal / 1 amount',
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                ),
                              )
                            ],
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            width: 20,
                            height: 20,
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 2,
                                color: !(controller
                                        .getFoodSelectFromId(id)['select'])
                                    ? Colors.grey.withOpacity(0.3)
                                    : AppColors.primaryColor1,
                              ),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: (controller
                                        .getFoodSelectFromId(id)['select'])
                                    ? AppColors.primaryColor1
                                    : Colors.transparent,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
