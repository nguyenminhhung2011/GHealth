import 'dart:async';
import 'dart:ui';

import 'package:better_player/better_player.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/workout_controller/workout_plan_controller.dart';
import 'package:gold_health/apps/global_widgets/screen_template.dart';
import 'package:gold_health/apps/pages/list_plan_screen/select_amount_food.dart';
import 'package:gold_health/apps/pages/workout_tracker_screen/workout_detail2_screen.dart';
import 'package:gold_health/apps/routes/route_name.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:video_player/video_player.dart';
import '../../data/models/workout_model.dart';
import '../../template/misc/colors.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({Key? key}) : super(key: key);
  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen>
    with TickerProviderStateMixin {
  final _workoutPlanController = Get.find<WorkoutPlanController>();

  VideoPlayerController? _videoPlayerController;
  Future<void>? _initializeVideoPlayerFuture;
  AnimationController? _controller;
  List<Exercise> exercises = [];
  List<BetterPlayerDataSource> dataSourceList = [];
  var listIdExercise = Get.arguments as List<String>;

  ///////Tracker exercise////////
  var progress = 0.0.obs;
  var isPlay = false.obs;
  var isAppearFilter = true.obs;
  var isCountDown = false.obs;
  /////////////////////
  RxInt currentWorkoutIndex = 0.obs;
  RxInt allTime = 60.obs;
  RxInt isReady = 1.obs;
  ///////////////////////////////
  ValueNotifier<int> rebuild = ValueNotifier(0);
  ///////////////////////////////
  Future<bool> _prepareExerciseData() async {
    try {
      await Future(
        () async {
          exercises.clear();
          for (var element in listIdExercise) {
            exercises.add(
                _workoutPlanController.exercises.value[element] as Exercise);
          }
          currentWorkoutIndex.listen(
            (val) {
              _initialCountDown();
              _initializeAndPlay();
              //////////////////////////////
              _getToRestPage();
            },
          );
          _initialCountDown();
          _initializeAndPlay();
        },
      );
      return true;
    } catch (e) {
      rethrow;
    }
  }

  var time = 3.obs;
  void _startCountDown() async {
    const duration = Duration(seconds: 1, milliseconds: 100);
    Timer.periodic(duration, (timer) async {
      if (time.value > 0) {
        --time.value;
      } else {
        isAppearFilter.value = false;
        isPlay.value = true;
        _controller?.forward();
        _videoPlayerController?.play();
        timer.cancel();
      }
    });
  }

  void _getToRestPage() async {
    Get.to(
      () => RestScreen(
        videoPlayer: showVideoPlayer(),
        numOfExercise: '${currentWorkoutIndex.value + 1}/${exercises.length}',
        exerciseName: exercises[currentWorkoutIndex.value].exerciseName,
        idExercise: exercises[currentWorkoutIndex.value].idExercise,
        duration: exercises[currentWorkoutIndex.value].duration,
      ),
    )?.then((_) {
      _controller!.forward();
      _videoPlayerController!.play();
    });
  }

  void _initializeAndPlay() {
    if (_videoPlayerController == null) {
      final videoPlayerController = VideoPlayerController.network(
          exercises[currentWorkoutIndex.value].exerciseUrl);
      _videoPlayerController = videoPlayerController;
      ++rebuild.value;
      _initializeVideoPlayerFuture =
          videoPlayerController.initialize().then((_) {
        videoPlayerController.setLooping(true);
        videoPlayerController.pause();
        ++rebuild.value;
      });
      return;
    }
    final videoPlayerController = VideoPlayerController.network(
        exercises[currentWorkoutIndex.value].exerciseUrl);
    var old = _videoPlayerController;
    if (old != null) {
      old.pause();
      _initializeVideoPlayerFuture = null;
    }
    _videoPlayerController = videoPlayerController;
    ++rebuild.value;
    _initializeVideoPlayerFuture = videoPlayerController.initialize().then((_) {
      old?.dispose();
      videoPlayerController.setLooping(true);
      videoPlayerController.pause();
      ++rebuild.value;
    });
  }

  void _initialCountDown() {
    final duration = exercises[currentWorkoutIndex.value].duration;
    final controller = AnimationController(vsync: this, duration: duration);
    var old = _controller;
    if (old != null) {
      old.stop();
      old.dispose();
      old = null;
    }
    _controller = controller;
    progress.value = 0.0;
    _controller!.addListener(() {
      progress.value = _controller!.value;
      if (_controller!.isCompleted) {
        _controller!.stop();
        if (currentWorkoutIndex.value < exercises.length - 1) {
          ++currentWorkoutIndex.value;
        } else if (currentWorkoutIndex.value == exercises.length - 1) {
          _showDialogSuccess();
        }
      }
    });
  }

  Widget showVideoPlayer() {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return AspectRatio(
            aspectRatio: _videoPlayerController!.value.aspectRatio,
            child: VideoPlayer(_videoPlayerController!),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  @override
  void dispose() {
    _controller!.dispose();
    _controller = null;
    // _betterPlayerController!.dispose();
    // _betterPlayerController = null;
    _videoPlayerController?.setLooping(false);
    _videoPlayerController?.pause();
    _videoPlayerController?.dispose();
    _videoPlayerController = null;
    currentWorkoutIndex.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;
    double sigmaX = 5.0; // from 0-10
    double sigmaY = 5.0; // from 0-10
    double opacity = 0.1; // from 0-1.0
    return Stack(
      children: [
        Scaffold(
          backgroundColor: AppColors.mainColor,
          extendBody: true,
          extendBodyBehindAppBar: true,
          body: FutureBuilder(
              future: _prepareExerciseData(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    if (snapshot.data as bool) {
                      return ScreenTemplate(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
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
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
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
                              const SizedBox(height: 20),
                              Container(
                                width: widthDevice,
                                height: heightDevice * 0.5,
                                decoration:
                                    BoxDecoration(color: AppColors.mainColor),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(5),
                                  child: ValueListenableBuilder(
                                    valueListenable: rebuild,
                                    builder: (context, value, child) {
                                      return Hero(
                                        tag:
                                            exercises[currentWorkoutIndex.value]
                                                .idExercise,
                                        child: showVideoPlayer(),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Obx(
                                () => LinearPercentIndicator(
                                  barRadius: const Radius.circular(20),
                                  percent: (currentWorkoutIndex.value + 1) /
                                      exercises.length,
                                  progressColor: Colors.lightBlue[300],
                                  backgroundColor: Colors.blueGrey[50]!,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Obx(() => Text(
                                        exercises[currentWorkoutIndex.value]
                                            .exerciseName,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 23,
                                        ),
                                      )),
                                  const SizedBox(width: 5),
                                  const Icon(Icons.check_circle,
                                      color: AppColors.primaryColor1)
                                ],
                              ),
                              const SizedBox(height: 10),
                              Obx(
                                () => Text(
                                  '${currentWorkoutIndex.value + 1}/${exercises.length} Exercises',
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Obx(
                                    () => CircularPercentIndicator(
                                      center: Text(
                                        style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500),
                                        DateFormat().add_ms().format(
                                              DateTime(
                                                  0,
                                                  0,
                                                  0,
                                                  0,
                                                  0,
                                                  (_controller!.duration! *
                                                          _controller!.value)
                                                      .inSeconds),
                                            ),
                                      ),
                                      circularStrokeCap:
                                          CircularStrokeCap.round,
                                      percent: progress.value,
                                      curve: Curves.linear,
                                      progressColor: Colors.lightBlue[300],
                                      backgroundColor: Colors.blueGrey[50]!,
                                      lineWidth: 15,
                                      radius: Get.mediaQuery.size.width * 0.2,
                                      backgroundWidth: 13,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Container(
                                    width: widthDevice * 0.45,
                                    height: heightDevice * (1.2 / 5),
                                    padding: const EdgeInsets.all(10),
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Obx(() => Expanded(
                                              child: Text(
                                                exercises[currentWorkoutIndex
                                                        .value]
                                                    .exerciseName,
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15,
                                                ),
                                              ),
                                            )),
                                        Row(
                                          children: [
                                            Image.asset(
                                                'assets/images/calories.png',
                                                height: 15,
                                                width: 15),
                                            Obx(() => RichTextCustom(
                                                  size: 15,
                                                  title: ' Calories Burned: ',
                                                  data: exercises[
                                                          currentWorkoutIndex
                                                              .value]
                                                      .caloriesBurn,
                                                )),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Image.asset(
                                                'assets/images/duration.png',
                                                height: 15,
                                                width: 15),
                                            Obx(() => RichTextCustom(
                                                  size: 15,
                                                  title: ' Time: ',
                                                  data: exercises[
                                                          currentWorkoutIndex
                                                              .value]
                                                      .duration
                                                      .inSeconds,
                                                )),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                  height: 40,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color:
                                                        AppColors.primaryColor1,
                                                  ),
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      if (isPlay.value) {
                                                        _controller!.stop();
                                                        _videoPlayerController!
                                                            .pause();
                                                      } else {
                                                        _controller!.forward();
                                                        _videoPlayerController!
                                                            .play();
                                                      }
                                                      isPlay.value =
                                                          !isPlay.value;
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            primary: Colors
                                                                .transparent,
                                                            shadowColor: Colors
                                                                .transparent),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Obx(() => Text(
                                                              isPlay.value
                                                                  ? 'Pause'
                                                                  : 'Resume',
                                                              style:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 14,
                                                              ),
                                                            )),
                                                        const SizedBox(
                                                            width: 2),
                                                        Icon(
                                                          Icons
                                                              .arrow_forward_ios,
                                                          color: AppColors
                                                              .mainColor,
                                                          size: 10,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 10),
                                                Container(
                                                  height: 40,
                                                  width: 100,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color:
                                                        AppColors.primaryColor1,
                                                  ),
                                                  child: ElevatedButton(
                                                    onPressed: () {
                                                      if (currentWorkoutIndex
                                                              .value <
                                                          exercises.length -
                                                              1) {
                                                        currentWorkoutIndex
                                                            .value++;
                                                      }
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                            ),
                                                            primary: Colors
                                                                .transparent,
                                                            shadowColor: Colors
                                                                .transparent),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        const Text(
                                                          'Skip',
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: 14,
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                            width: 2),
                                                        Icon(
                                                          Icons
                                                              .arrow_forward_ios,
                                                          color: AppColors
                                                              .mainColor,
                                                          size: 10,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            InkWell(
                                                onTap: () {
                                                  bool isHelpingMode = true;
                                                  _videoPlayerController
                                                      ?.pause();
                                                  _controller?.stop();
                                                  Get.to(
                                                          () => WorkoutDetail2Screen(
                                                              idExercise: exercises[
                                                                      currentWorkoutIndex
                                                                          .value]
                                                                  .idExercise),
                                                          arguments:
                                                              isHelpingMode)
                                                      ?.then((_) {
                                                    _videoPlayerController
                                                        ?.play();
                                                    _controller?.forward();
                                                  });
                                                },
                                                child: const Icon(
                                                  Icons.help,
                                                  size: 40,
                                                  color:
                                                      AppColors.primaryColor1,
                                                )),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }
                  }
                }
                return const Center(child: CircularProgressIndicator());
              }),
        ),
        Obx(() {
          if (isAppearFilter.value) {
            return SizedBox(
              height: heightDevice,
              width: widthDevice,
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: sigmaX, sigmaY: sigmaY),
                child: isCountDown.value
                    ? Obx(
                        () => Center(
                          child: Material(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: AppColors.primaryColor1,
                              ),
                              child: Text(
                                time.value.toString(),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    : Container(
                        color: Colors.black.withOpacity(opacity),
                        child: GestureDetector(
                          onTap: () {
                            isCountDown.value = true;
                            _startCountDown();
                          },
                          child: Center(
                            child: Material(
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: AppColors.primaryColor1,
                                ),
                                child: const Text(
                                  'Are You Ready ?',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 30,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
              ),
            );
          } else {
            return const SizedBox();
          }
        }),
      ],
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
                    Get.back();
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

class RestScreen extends StatefulWidget {
  const RestScreen({
    Key? key,
    required this.numOfExercise,
    required this.exerciseName,
    required this.duration,
    required this.videoPlayer,
    required this.idExercise,
  }) : super(key: key);
  final String idExercise;
  final String numOfExercise;
  final String exerciseName;
  final Duration duration;
  final Widget videoPlayer;
  @override
  State<RestScreen> createState() => _RestScreenState();
}

class _RestScreenState extends State<RestScreen> {
  late Timer timer;

  var time = 25.obs;
  // late VideoPlayerController _videoPlayerController;

  Future<void> _startTimer() async {
    await Future(() {
      timer = Timer.periodic(
        const Duration(seconds: 1),
        (timer) {
          if (time.value == 0) {
            Future.delayed(
              const Duration(seconds: 1),
              () => Get.back(result: true),
            );
            timer.cancel();
          } else {
            time.value--;
          }
        },
      );
    });
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  @override
  void didChangeDependencies() async {
    await _startTimer();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.blue[400],
      body: SafeArea(
        child: SizedBox(
          height: heightDevice,
          width: widthDevice,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () => Get.back(result: true),
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'REST',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Obx(
                      () => Text(
                        DateFormat()
                            .add_ms()
                            .format(DateTime(0, 0, 0, 0, 0, time.value)),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 35,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: widthDevice,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () => time.value += 20,
                            child: Container(
                              alignment: Alignment.center,
                              width: 100,
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.blue[200],
                              ),
                              child: const Text(
                                '+20s',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                          const SizedBox(width: 50),
                          InkWell(
                            onTap: () => Get.back(result: true),
                            child: Container(
                              alignment: Alignment.center,
                              width: 100,
                              height: 35,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: Colors.white,
                              ),
                              child: const Text(
                                'Skip',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10),
                width: widthDevice,
                child: Text(
                  'Next ${widget.numOfExercise}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 10, right: 10),
                width: widthDevice,
                child: SizedBox(
                  width: widthDevice,
                  child: Row(
                    children: [
                      Text(
                        widget.exerciseName,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),
                      ),
                      const SizedBox(width: 5),
                      const Icon(
                        Icons.question_mark_sharp,
                        color: Colors.white,
                      ),
                      const Spacer(),
                      Text(
                        DateFormat().add_ms().format(
                            DateTime(0, 0, 0, 0, 0, widget.duration.inSeconds)),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                height: heightDevice * (1.5 / 3),
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(30))),
                child: ClipRRect(
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(30)),
                  child: Hero(
                    tag: widget.idExercise,
                    child: widget.videoPlayer,
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
