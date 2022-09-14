import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/global_widgets/button_custom/button_text.dart';
import 'package:gold_health/apps/pages/progress_tracker/take_photo_screen.dart';
import 'package:intl/intl.dart';
import '../../controls/progress_controller/progress_controller.dart';
import '../../global_widgets/screen_template.dart';
import '../../template/misc/colors.dart';
import 'comparision_sreen.dart';

class ProgressPhotoScreen extends StatefulWidget {
  const ProgressPhotoScreen({Key? key}) : super(key: key);

  @override
  State<ProgressPhotoScreen> createState() => _ProgressPhotoScreenState();
}

class _ProgressPhotoScreenState extends State<ProgressPhotoScreen> {
  final controller = Get.find<ProgressC>();
  RxList<Map<String, dynamic>> fakeData = [
    {
      'm': "June",
      'd': 2,
      'image': [
        'assets/images/work1.png',
        'assets/images/work2.png',
        'assets/images/work3.png',
        'assets/images/work4.png',
      ],
      'type': 0,
    },
    {
      'm': 'May',
      'd': 5,
      'image': [
        'assets/images/work5.png',
        'assets/images/work6.png',
        'assets/images/work7.png',
        'assets/images/work8.png',
      ],
      'type': 0,
    },
    {
      'm': 'Nov',
      'd': 20,
      'image': [
        'assets/images/work3.png',
        'assets/images/work1.png',
        'assets/images/work8.png',
        'assets/images/work5.png',
      ],
      'type': 0,
    }
  ].obs;

  // final _controllerWorkout = Get.find<WorkoutPlanController>();
  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    // await _controllerWorkout.fetchWorkoutListWithStream();
  }

  @override
  Widget build(BuildContext context) {
    // var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;
    return GetBuilder<ProgressC>(
        init: ProgressC(),
        builder: (controller) => Scaffold(
              backgroundColor: AppColors.mainColor,
              extendBody: true,
              extendBodyBehindAppBar: true,
              floatingActionButton: InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TakePhotoScreen(
                          fakeDta: fakeData,
                        ),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                        shape: BoxShape.circle, color: AppColors.primaryColor1),
                    child: const Icon(Icons.camera_alt, color: Colors.white),
                  )),
              body: ScreenTemplate(
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Progress Photo',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: widthDevice,
                      margin: const EdgeInsets.symmetric(horizontal: 20.0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset('assets/images/calendar.png'),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                'Reminder',
                                style: TextStyle(
                                    color: Colors.red,
                                    fontWeight: FontWeight.w500),
                              ),
                              Text(
                                'Next Photos Fall On July 08',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Align(
                            alignment: Alignment.topCenter,
                            child: IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.close,
                                color: Colors.grey,
                                size: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: widthDevice,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
                      margin: const EdgeInsets.symmetric(horizontal: 20.0),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor1.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Track Your Progress Each',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              RichText(
                                text: const TextSpan(
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 16,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: 'Month with',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    TextSpan(
                                      text: 'Photo',
                                      style: TextStyle(
                                          color: AppColors.primaryColor1),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              Container(
                                height: 38,
                                width: 130,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColors.primaryColor1,
                                ),
                                child: ElevatedButton(
                                  onPressed: () {
                                    for (var item in controller.listProgress) {
                                      print(item.id);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      primary: Colors.transparent,
                                      shadowColor: Colors.transparent),
                                  child: const Text(
                                    'Learn More',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Image.asset(
                              'assets/images/Group.png',
                              width: 80,
                              height: 80,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                    Container(
                      width: widthDevice,
                      margin: const EdgeInsets.symmetric(horizontal: 20.0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 20),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor1.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Row(
                        children: [
                          const Text(
                            'Compare my Photo',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                            ),
                          ),
                          const Spacer(),
                          ButtonText(
                            press: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ComparisionScreen(),
                                ),
                              );
                            },
                            title: 'Compare',
                            color: AppColors.primaryColor1,
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // ignore: avoid_unnecessary_containers, sized_box_for_whitespace
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Row(
                        children: [
                          const Text(
                            'Gallery',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const Spacer(),
                          GestureDetector(
                            onTap: () {},
                            child: const Text(
                              'See more',
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 15),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Obx(
                      () => (controller.listProgress.isNotEmpty)
                          ? Column(
                              children: controller.listProgress.map((e) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20.0),
                                    child: Text(
                                      DateFormat().add_MMMEd().format(e.date),
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 14),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  // ignore: sized_box_for_whitespace
                                  Container(
                                    height: 100,
                                    width: widthDevice,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: e.image.length,
                                      itemBuilder: (context, index) =>
                                          Container(
                                        margin: const EdgeInsets.only(left: 10),
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                              e.image[index],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }).toList())
                          : Container(),
                    )
                  ],
                ),
              ),
            ));
  }
}
