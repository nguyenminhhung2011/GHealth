import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/dailyPlanController/meal_plan/view_meal_controller.dart';

import '../../global_widgets/screen_template.dart';
import '../../routes/route_name.dart';
import '../../template/misc/colors.dart';

class ViewMealScreen extends StatelessWidget {
  ViewMealScreen({Key? key}) : super(key: key);
  final controller = Get.find<ViewMealC>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.mainColor,
        elevation: 1,
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: InkWell(
            onTap: () {
              Get.back();
            },
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.primaryColor1,
              ),
              child: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
              ),
            ),
          ),
        ),
        title: const Text(
          'Meals',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      backgroundColor: AppColors.mainColor,
      body: Obx(
        () => controller.listMeal.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/notfound.png',
                        height: 60, width: 60),
                    const Text(
                      'Meals isn\'t null',
                      style: TextStyle(
                        color: AppColors.primaryColor1,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              )
            : ScreenTemplate(
                child: Column(
                  children: [
                    for (int i = 0; i < controller.listMeal.length; i++)
                      Container(
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        margin: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: ElevatedButton(
                          onPressed: () => Get.toNamed(
                            RouteName.mealDetail,
                            arguments: controller.listMeal[i].toJson(),
                          ),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 0,
                            primary: AppColors.mainColor,
                            onPrimary: Colors.grey.withOpacity(0.05),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Image.network(
                                    controller.listMeal[i].asset,
                                    height: 80,
                                    width: 80,
                                  ),
                                  const SizedBox(width: 5),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          controller.listMeal[i].name,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18),
                                        ),
                                        Text(
                                          '${controller.listMeal[i].kCal} kCal',
                                          style: const TextStyle(
                                              color: Colors.grey,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const Align(
                                    alignment: Alignment.centerRight,
                                    child: Icon(
                                      size: 20,
                                      Icons.arrow_forward_ios_outlined,
                                      color: Colors.black,
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 10),
                              (i == controller.listMeal.length - 1)
                                  ? Container()
                                  : const Divider(color: Colors.black)
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
      ),
    );
  }
}
