import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/workout_plan_controller.dart';
import 'package:gold_health/apps/global_widgets/screen_template.dart';
import 'package:gold_health/apps/pages/list_plan_screen/select_amount_food.dart';
import 'package:gold_health/apps/pages/workout_tracker_screen/widgets/time_custom.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../template/misc/colors.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({Key? key}) : super(key: key);

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  final _controller = Get.find<WorkoutPlanController>();
  late YoutubePlayerController _videoController;
  @override
  void initState() {
    super.initState();
    _videoController = YoutubePlayerController(
      initialVideoId: 'cTN6gS1jC0k',
      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        forceHD: true,
      ),
    );
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;
    double sigmaX = 5.0; // from 0-10
    double sigmaY = 5.0; // from 0-10
    double opacity = 0.1; // from 0-1.0

    return Scaffold(
      backgroundColor: AppColors.mainColor,
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: ScreenTemplate(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.primaryColor1,
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  const Spacer(),
                  InkWell(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.primaryColor1,
                      ),
                      child: const Icon(
                        Icons.more_horiz,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Obx(
                    (() => Text(
                          _controller.listWorkout
                                  .value[_controller.currentWorkoutIndex.value]
                              ['name'],
                          style: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        )),
                  ),
                  const SizedBox(width: 5),
                  const Icon(Icons.check_circle, color: AppColors.primaryColor1)
                ],
              ),
              const SizedBox(height: 10),
              Obx(
                () => Text(
                  // ignore: invalid_use_of_protected_member
                  '${_controller.currentWorkoutIndex.value + 1}/${_controller.listWorkout.value.length} Exercises',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Obx(
                () => SizedBox(
                  width: widthDevice,
                  height: heightDevice * 0.55,
                  child: Stack(
                    children: [
                      Container(
                        width: widthDevice,
                        height: heightDevice * 0.55,
                        decoration: BoxDecoration(color: AppColors.mainColor),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: YoutubePlayer(
                            controller: _videoController,
                            showVideoProgressIndicator: true,
                          ),
                        ),
                      ),
                      (_controller.isReady.value == 1)
                          ? Positioned(
                              top: 0,
                              left: 0,
                              width: widthDevice,
                              height: heightDevice * 0.55,
                              // Note: without ClipRect, the blur region will be expanded to full
                              // size of the Image instead of custom size
                              child: ClipRect(
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(
                                      sigmaX: sigmaX, sigmaY: sigmaY),
                                  child: Container(
                                    color: Colors.black.withOpacity(opacity),
                                    child: Center(
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: AppColors.primaryColor1,
                                        ),
                                        child: const Text(
                                          'Ready',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 17,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ))
                          : Container()
                    ],
                  ),
                ),
              ),
              const Divider(),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  // ignore: prefer_const_constructors
                  Obx(
                    () => Expanded(
                      // ignore: prefer_const_constructors
                      child: CountTImeWorkout(
                        currentAllTime:
                            Duration(seconds: _controller.allTime.value),
                        // ignore: invalid_use_of_protected_member
                        currentTime: Duration(
                            seconds: _controller.listWorkout.value[
                                _controller.currentWorkoutIndex.value]['time']),
                        currentReadyTime: Duration(
                            seconds: _controller.listWorkout.value[_controller
                                .currentWorkoutIndex.value]['ready']),
                        isReady: _controller.isReady.value,
                        onComPleted: () async {
                          if (_controller.isReady.value != 0) {
                            _controller.isReady.value =
                                0 - _controller.isReady.value;
                            if (_controller.isReady.value == 1) {
                              if (_controller.currentWorkoutIndex.value <
                                  _controller.listWorkout.value.length - 1) {
                                _controller.currentWorkoutIndex.value++;
                              } else {
                                _controller.isReady.value = 0;
                                await _showDialogSuccess();
                              }
                            }
                          }
                        },
                      ),
                    ),
                  ),
                  Obx(
                    () => Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            offset: const Offset(2, 3),
                            blurRadius: 10,
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            offset: const Offset(-2, -3),
                            blurRadius: 10,
                          )
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _controller.listWorkout.value[
                                _controller.currentWorkoutIndex.value]['name'],
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Image.asset('assets/images/calories.png',
                                  height: 15, width: 15),
                              RichTextCustom(
                                size: 15,
                                title: 'Calories Burned: ',
                                data: _controller.listWorkout.value[_controller
                                    .currentWorkoutIndex.value]['calo'],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Image.asset('assets/images/duration.png',
                                  height: 15, width: 15),
                              RichTextCustom(
                                size: 15,
                                title: 'Time: ',
                                data: _controller.listWorkout.value[_controller
                                    .currentWorkoutIndex.value]['time'],
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: 40,
                            width: 120,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.primaryColor1,
                            ),
                            child: ElevatedButton(
                              onPressed: () {
                                if (_controller.currentWorkoutIndex.value <
                                    _controller.listWorkout.value.length - 1) {
                                  _controller.currentWorkoutIndex.value++;
                                  _controller.isReady.value = 1;
                                  _controller.allTime += _controller
                                          .listWorkout.value[
                                      _controller.currentWorkoutIndex.value -
                                          1]['time'];
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  primary: Colors.transparent,
                                  shadowColor: Colors.transparent),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Text(
                                    'Skip',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(width: 2),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    color: AppColors.mainColor,
                                    size: 17,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  _showDialogSuccess() async {
    await showDialog(
      useRootNavigator: false,
      context: context,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Stack(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.28,
                      width: double.infinity,
                      child: Image.asset(
                        'assets/images/success.png',
                        fit: BoxFit.cover,
                        color: AppColors.primaryColor1,
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.28,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.check_circle,
                              color: AppColors.primaryColor1,
                              size: 70,
                            ),
                            SizedBox(height: 5),
                            Text(
                              'Complete all workout session',
                              style: TextStyle(
                                color: AppColors.primaryColor1,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const Spacer(),
              Container(
                height: 50,
                width: double.infinity,
                margin: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.primaryColor1,
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      primary: Colors.transparent,
                      shadowColor: Colors.transparent),
                  child: const Text(
                    'Done',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
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
