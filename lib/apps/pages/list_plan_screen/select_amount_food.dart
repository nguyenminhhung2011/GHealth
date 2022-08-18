import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controls/dailyPlanController/daily_nutrition_controller.dart';
import '../../template/misc/colors.dart';

// ignore: must_be_immutable
class SelectAmountFood extends StatefulWidget {
  SelectAmountFood({
    Key? key,
    required this.foodItem,
  }) : super(key: key);
  RxMap<String, dynamic> foodItem;
  @override
  State<SelectAmountFood> createState() => _SelectAmountFoodState();
}

class _SelectAmountFoodState extends State<SelectAmountFood> {
  double slideValue = 0;
  final _controller = Get.find<DailyNutritionController>();
  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              widget.foodItem['select'] = true;
              _controller.foodTemp.add(
                {
                  'image': widget.foodItem['image'],
                  'name': widget.foodItem['name'],
                  'kCal': ((widget.foodItem['kCal'] / widget.foodItem['gam']) *
                          slideValue)
                      .round(),
                  'Carbs':
                      ((widget.foodItem['Carbs'] / widget.foodItem['gam']) *
                              slideValue)
                          .round(),
                  'Protein':
                      ((widget.foodItem['Protein'] / widget.foodItem['gam']) *
                              slideValue)
                          .round(),
                  'Fat': ((widget.foodItem['Fat'] / widget.foodItem['gam']) *
                          slideValue)
                      .round(),
                  'time': '${DateTime.now().hour}:${DateTime.now().minute}',
                  'date':
                      '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                },
              );

              Navigator.pop(context);
            },
            icon: const Icon(Icons.check, color: AppColors.primaryColor1),
          )
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        children: [
          //const SizedBox(height: 20),
          Align(
            alignment: Alignment.center,
            child: Text(
              widget.foodItem['name'],
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 23,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/banhxeo.png',
              height: widthDevice / 2,
              width: widthDevice / 2,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RichTextCustom(
                size: 23,
                title: 'Calories: ',
                data: ((widget.foodItem['kCal'] / widget.foodItem['gam']) *
                        slideValue)
                    .round(),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichTextCustom(
                    size: 18,
                    title: 'Carbs: ',
                    data: ((widget.foodItem['Carbs'] / widget.foodItem['gam']) *
                            slideValue)
                        .round(),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: 20,
                    width: 0.5,
                    color: Colors.grey,
                  ),
                  RichTextCustom(
                    size: 18,
                    title: 'Protein: ',
                    data:
                        ((widget.foodItem['Protein'] / widget.foodItem['gam']) *
                                slideValue)
                            .round(),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    height: 20,
                    width: 0.5,
                    color: Colors.grey,
                  ),
                  RichTextCustom(
                    size: 18,
                    title: 'Fats: ',
                    data: ((widget.foodItem['Fat'] / widget.foodItem['gam']) *
                            slideValue)
                        .round(),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Text(
                      '${slideValue.toInt().toString()} g',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              ),
              Slider(
                value: slideValue,
                min: 0,
                max: 1000,
                divisions: 95,
                activeColor: AppColors.primaryColor1,
                inactiveColor: Colors.grey.withOpacity(0.2),
                onChanged: (value) {
                  setState(() {
                    slideValue = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Slide the slider to customize the amount of ingredients',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 17,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

class RichTextCustom extends StatelessWidget {
  const RichTextCustom(
      {Key? key, required this.size, required this.title, required this.data})
      : super(key: key);
  final double size;
  final String title;
  final int data;
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: size),
        children: [
          TextSpan(text: title, style: const TextStyle(color: Colors.black)),
          TextSpan(
              text: data.toString(),
              style: const TextStyle(color: AppColors.primaryColor1)),
        ],
      ),
    );
  }
}
