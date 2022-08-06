import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../template/misc/colors.dart';
import '../mealPlanner/widgets/SearchContainer.dart';

class AddFoodScreen extends StatefulWidget {
  AddFoodScreen({Key? key, required this.listFood}) : super(key: key);
  RxList<Map<String, dynamic>> listFood;

  @override
  State<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  final List<Map<String, dynamic>> allFood = [
    {
      'name': 'Banh xeo',
      'image': 'assets/images/break.png',
      'kCal': 800,
      'gam': 400,
      'Carbs': 54,
      'Protein': 20,
      'Fat': 20,
      'select': false,
    },
    {
      'name': 'Banh Kep',
      'image': 'assets/images/lunch.png',
      'kCal': 900,
      'gam': 450,
      'Carbs': 54,
      'Protein': 20,
      'Fat': 20,
      'select': false,
    },
    {
      'name': 'Banh beo',
      'image': 'assets/images/dinner.png',
      'kCal': 1000,
      'gam': 500,
      'Carbs': 54,
      'Protein': 20,
      'Fat': 20,
      'select': false,
    },
  ];
  final List<Map<String, dynamic>> foodTemp = [];
  @override
  Widget build(BuildContext context) {
    var widthDevice = MediaQuery.of(context).size.width;
    var heightDevice = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).cardColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.pop(context),
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
              for (var item in foodTemp) {
                widget.listFood.add(item);
              }
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
          Padding(
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
                    const TextSpan(
                      text: "22",
                      style: TextStyle(
                        color: AppColors.primaryColor1,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // ignore: avoid_unnecessary_containers
          Expanded(
            // height: heightDevice,
            // width: widthDevice,
            child: ListView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              children: allFood
                  .map(
                    (e) => _foodSelectCard(e),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Padding _foodSelectCard(Map<String, dynamic> e) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: InkWell(
        onTap: () {
          setState(() {
            e['select'] = !e['select'];
            (e['select'])
                ? foodTemp.add(
                    {
                      'image': e['image'],
                      'name': e['name'],
                      'kCal': e['kCal'],
                      'Carbs': e['Carbs'],
                      'Protein': e['Protein'],
                      'Fat': e['Fat'],
                      'time': '${DateTime.now().hour}:${DateTime.now().minute}',
                      'date':
                          '${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
                    },
                  )
                : foodTemp.removeWhere((ele) => ele['name'] == e['name']);
          });
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
                      '${e['kCal']}/${e['gam']}',
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
