import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

import '../../../services/data_service.dart';
import '../../controls/today_schedule_controller.dart';
import '../../template/misc/colors.dart';

class TodayScheduleScreen extends StatelessWidget {
  TodayScheduleScreen({super.key});
  final _controller = Get.find<TodayScheduleC>();

  GlobalKey<ScrollSnapListState> sslKey = GlobalKey();

  Widget _itemBuilder(BuildContext context, int index) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(10),
      width: 78,
      height: 120,
      child: _controller.onFocus == index
          ? Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(10),
              height: 120,
              width: 78,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Colors.white,
              ),
              padding: const EdgeInsets.all(2),
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  Text(
                    DateFormat()
                        .add_E()
                        .format(_controller.listDateTime[index]),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const Spacer(),
                  Container(
                    // padding: const EdgeInsets.all(10),
                    height: 60,
                    width: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.blue[200],
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      DateFormat()
                          .add_d()
                          .format(_controller.listDateTime[index]),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            )
          : Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.all(10),
              width: 80,
              height: 100,
              child: SizedBox(
                height: 60,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      DateFormat()
                          .add_E()
                          .format(_controller.listDateTime[index]),
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      DateFormat()
                          .add_d()
                          .format(_controller.listDateTime[index]),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    var widthDevice = MediaQuery.of(context).size.width;
    var heightDevice = MediaQuery.of(context).size.height;
    return GetBuilder<TodayScheduleC>(
        init: TodayScheduleC(),
        builder: (controller) => Scaffold(
              backgroundColor: Colors.blue[100],
              extendBody: true,
              extendBodyBehindAppBar: true,
              body: Stack(
                children: [
                  Container(
                    width: widthDevice,
                    height: heightDevice,
                    color: Colors.blue[100],
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                    ),
                    child: ListView(
                      physics: const BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Obx(
                              () => SizedBox(
                                height: heightDevice * 0.25,
                                width: widthDevice,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 20),
                                    SizedBox(
                                      height: 156,
                                      width: widthDevice,
                                      child: ScrollSnapList(
                                        itemBuilder: _itemBuilder,
                                        background: Colors.blue[200],
                                        itemCount:
                                            controller.listDateTime.length,
                                        itemSize: 100,
                                        dispatchScrollNotifications: true,
                                        initialIndex:
                                            controller.onFocus.toDouble(),
                                        scrollPhysics: const ScrollPhysics(),
                                        duration: 300,
                                        curve: Curves.linear,
                                        onItemFocus: (int index) {
                                          controller.setFocus(index,
                                              controller.listDateTime[index]);
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            ConstrainedBox(
                              constraints:
                                  BoxConstraints(minHeight: heightDevice * 0.8),
                              child: Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: AppColors.mainColor,
                                  borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20)),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                        width: 65,
                                        height: 7,
                                        decoration: BoxDecoration(
                                          color: AppColors.primaryColor1
                                              .withOpacity(0.3),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      activityField(),
                                      const SizedBox(height: 10),
                                      mealField(controller),
                                      const SizedBox(height: 10),
                                      sleepField(controller),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 40),
                      Row(
                        children: [
                          const SizedBox(width: 10),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              child: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.black54,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Column(
                            children: [
                              Text(
                                DateFormat().add_MMM().format(controller
                                    .listDateTime[controller.onFocus]),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 19,
                                ),
                              ),
                              Text(
                                '${DateFormat('EEEE').format(controller.listDateTime[controller.onFocus])},${controller.listDateTime[controller.onFocus].day}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              for (var item in DataService.instance.mealList) {
                                print(item.asset);
                              }
                              print(DataService.instance.timeEatList);
                              print(DataService.instance.dataNutriPlan);
                              print(_controller.listMealPlan);
                            },
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: const DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                      'https://firebasestorage.googleapis.com/v0/b/gold-health-2246a.appspot.com/o/GroupPics%2FMUtygInuENZyCdxbMqLyUp2bC9p2?alt=media&token=58994961-4228-4abc-ab36-dc5cd7121fc4'),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    offset: const Offset(2, 3),
                                    blurRadius: 20,
                                  ),
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    offset: const Offset(-2, -3),
                                    blurRadius: 20,
                                  )
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      ),
                      const Spacer(),
                    ],
                  )
                ],
              ),
            ));
  }

  Column sleepField(TodayScheduleC controller) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Sleep',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Icon(Icons.more_horiz, color: Colors.grey),
          ],
        ),
        const SizedBox(height: 5),
        ...(DataService.instance.listSleepTime.isNotEmpty)
            ? controller
                .listSleepWithDate(
                    controller.listDateTime[controller.onFocus].weekday)
                .map((e) => SleepCard(bedTime: e.bedTime, alarm: e.alarm))
                .toList()
            : []
      ],
    );
  }

  Column mealField(TodayScheduleC controller) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              'Meal',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            Icon(Icons.more_horiz, color: Colors.grey),
          ],
        ),
        const SizedBox(height: 5),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Breakfast',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 5),
        (controller.mealDate.value['BreakFast'].isEmpty)
            ? const Center(
                child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    color: AppColors.primaryColor1))
            : Column(
                children: [
                  for (var item in controller.mealDate.value['BreakFast'])
                    FoodScheduleCard1(
                      imagePath: item.asset,
                      name: item.name,
                      time: DateFormat.jm()
                          .format(DataService.instance.timeEatList[0]),
                      press: () {},
                      color: AppColors.primaryColor2.withOpacity(0.2),
                    )
                ],
              ),
        const SizedBox(height: 5),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Lunch',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 5),
        (controller.mealDate.value['Lunch'].isEmpty)
            ? const Center(
                child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    color: AppColors.primaryColor1))
            : Column(
                children: [
                  for (var item in controller.mealDate.value['Lunch'])
                    FoodScheduleCard1(
                      imagePath: item.asset,
                      name: item.name,
                      time: DateFormat.jm()
                          .format(DataService.instance.timeEatList[1]),
                      press: () {},
                      color: AppColors.primaryColor1.withOpacity(0.2),
                    )
                ],
              ),
        const SizedBox(height: 5),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Snack',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 5),
        (controller.mealDate.value['Snack'].isEmpty)
            ? const Center(
                child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    color: AppColors.primaryColor1))
            : Column(
                children: [
                  for (var item in controller.mealDate.value['Snack'])
                    FoodScheduleCard1(
                      imagePath: item.asset,
                      name: item.name,
                      time: DateFormat.jm()
                          .format(DataService.instance.timeEatList[2]),
                      press: () {},
                      color: AppColors.primaryColor2.withOpacity(0.2),
                    )
                ],
              ),
        const SizedBox(height: 5),
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Dinner',
            style: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 5),
        (controller.mealDate.value['Dinner'].isEmpty)
            ? const Center(
                child: CircularProgressIndicator(
                    backgroundColor: Colors.white,
                    color: AppColors.primaryColor1))
            : Column(
                children: [
                  for (var item in controller.mealDate.value['Dinner'])
                    FoodScheduleCard1(
                      imagePath: item.asset,
                      name: item.name,
                      time: DateFormat.jm()
                          .format(DataService.instance.timeEatList[3]),
                      press: () {},
                      color: AppColors.primaryColor1.withOpacity(0.2),
                    )
                ],
              ),
      ],
    );
  }

  Obx activityField() {
    return Obx(() => Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  'Activity',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Icon(Icons.more_horiz, color: Colors.grey),
              ],
            ),
            const SizedBox(height: 10),
            ..._controller.schedules.value.entries
                .map((element) => ActiCard(
                      workoutCategory: element.value.workoutCategory,
                      dateTime: element.value.time,
                      duration: element.value.duration,
                    ))
                .toList()
          ],
        ));
  }
}

class SleepCard extends StatelessWidget {
  const SleepCard({
    Key? key,
    required this.bedTime,
    required this.alarm,
  }) : super(key: key);
  final DateTime bedTime;
  final DateTime alarm;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 40,
                width: 40,
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryColor1.withOpacity(0.2),
                ),
                child: Image.asset(
                  'assets/images/bed.png',
                  height: 40,
                  width: 40,
                ),
              ),
              const SizedBox(width: 5),
              Row(
                children: [
                  const Text(
                    'Bed Time: ',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    DateFormat().add_jm().format(bedTime),
                    style: const TextStyle(
                      color: AppColors.primaryColor1,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Image.asset('assets/images/duration.png', height: 35, width: 35),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                height: 40,
                width: 40,
                padding: const EdgeInsets.all(10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryColor2.withOpacity(0.2),
                ),
                child: Image.asset(
                  'assets/images/Icon-Alaarm.png',
                  height: 40,
                  width: 40,
                ),
              ),
              const SizedBox(width: 5),
              Row(
                children: [
                  const Text(
                    'Alarm: ',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    DateFormat().add_jm().format(alarm),
                    style: const TextStyle(
                      color: AppColors.primaryColor1,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Image.asset('assets/images/duration.png', height: 35, width: 35),
            ],
          ),
        ],
      ),
    );
  }
}

final Map<String, String> listImage = {
  'Fullbody': 'assets/images/fullbody.png',
  'Upperbody': 'assets/images/upperbody.png',
  'Abs': 'assets/images/abs.png',
  'Lowebody': 'assets/images/lowebody.png',
  'Cardio': 'assets/images/cardio.png',
  'Hitt': 'assets/images/hitt.png',
};

class ActiCard extends StatelessWidget {
  const ActiCard({
    Key? key,
    required this.workoutCategory,
    required this.dateTime,
    required this.duration,
  }) : super(key: key);
  final String workoutCategory;
  final DateTime dateTime;
  final int duration;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            height: 70,
            width: 70,
            padding: const EdgeInsets.all(10),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryColor1.withOpacity(0.2),
            ),
            child: Image.asset(
              listImage[workoutCategory]!,
              height: 40,
              width: 40,
            ),
          ),
          const SizedBox(width: 5),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$workoutCategory Workout',
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                '${DateFormat().add_jm().format(dateTime)} - $duration min',
                style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.w400,
                    fontSize: 14),
              )
            ],
          ),
          const Spacer(),
          Image.asset('assets/images/kCalBurn.png', height: 35, width: 35),
        ],
      ),
    );
  }
}

class FoodScheduleCard1 extends StatelessWidget {
  const FoodScheduleCard1({
    Key? key,
    required this.imagePath,
    required this.name,
    required this.time,
    required this.press,
    required this.color,
  }) : super(key: key);
  final String imagePath;
  final String name;
  final String time;
  final Function() press;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            height: 70,
            width: 70,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            child: Image.network(
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    color: AppColors.primaryColor1,
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
              height: 60,
              width: 60,
              imagePath,
            ),
          ),
          const SizedBox(width: 5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  time,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Image.asset('assets/images/kcal.png', height: 35, width: 35),
          ),
        ],
      ),
    );
  }
}
