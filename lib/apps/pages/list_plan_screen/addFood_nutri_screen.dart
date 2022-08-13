import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/pages/list_plan_screen/selectAmountFood.dart';

import '../../controls/dailyPlanController/dailyNutritionController.dart';
import '../../template/misc/colors.dart';

class AddFoodScreen extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  AddFoodScreen({Key? key}) : super(key: key);

  @override
  State<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  final _controller = Get.find<DailyNutritionController>();

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
            _controller.clearFoodTemp();
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
              for (var item in _controller.foodTemp) {
                _controller.listFoodToday.add(item);
              }
              _controller.clearFoodTemp();
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
                        text: (_controller.foodTemp.length).toString(),
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
                children: _controller.allFood
                    .map(
                      (e) => _foodSelectCard(e),
                    )
                    .toList(),
              ),
            ),
          )
        ],
      ),
    );
  }

  Padding _foodSelectCard(RxMap<String, dynamic> e) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: InkWell(
        onTap: () async {
          // e['select'] = !e['select'];

          if (!e['select']) {
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
                  child: SelectAmountFood(foodItem: e),
                ),
              ),
            );
          } else {
            setState(() {
              e['select'] = false;
              _controller.foodTemp
                  .removeWhere((element) => element['name'] == e['name']);
            });
          }
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              width: 2,
              color:
                  (e['select']) ? AppColors.primaryColor1 : Colors.transparent,
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
                    image: DecorationImage(
                      image: AssetImage(
                        e['image'],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      e['name'],
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                    Text(
                      '${e['kCal']}kCal/${e['gam']}gam',
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
                      color: !(e['select'])
                          ? Colors.grey.withOpacity(0.3)
                          : AppColors.primaryColor1,
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (e['select'])
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
