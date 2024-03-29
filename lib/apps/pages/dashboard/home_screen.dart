import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gold_health/apps/global_widgets/screen_template.dart';
import 'package:gold_health/apps/pages/dashboard/today_schedule_screen.dart';
import 'package:gold_health/apps/pages/dashboard/widgets/badge.dart';
import 'package:gold_health/apps/pages/dashboard/widgets/load_height_weight.dart';
import '../../controls/home_screen_controller.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/data/fake_data.dart';
import 'package:gold_health/apps/global_widgets/gradient_text.dart';
import 'package:gold_health/apps/routes/route_name.dart';
import '../../template/misc/colors.dart';
import 'widgets/button_gradient.dart';
import 'package:percent_indicator/percent_indicator.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  RxInt touchedIndex = (-1).obs;
  RxInt touchedIndex1 = (-1).obs;
  RxDouble height_bmi_container = 0.0.obs;
  RxDouble height_slideValue = 20.0.obs;
  RxDouble weight_slideValue = 100.0.obs;
  RxDouble height_process_container = 0.0.obs;

  double value = 0;
  final List<int> _list = [for (int i = 1; i <= 140; i++) i];
  final homeScreenController = Get.find<HomeScreenControl>();
  final double calories = 760;
  final double liters = 8;
  final double caloriesLeft = 230;
  final int footSteps = 1000;
  late RxInt exerciseTime = 0.obs;
  late RxInt exerciseTimeTarget = 1.obs;
  final int sleepTime = 3;
  final int sleepTimeTarget = 8;
  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    exerciseTimeTarget.value = await homeScreenController.getExerciseTimeData();
    exerciseTime.value = await homeScreenController.getExerciseTimeHistory();
  }

  @override
  Widget build(BuildContext context) {
    var widthDevice = MediaQuery.of(context).size.width;
    const double heightOfWaterChart = 100 * 5 - 50;
    return Obx(() => (homeScreenController.user['name'] == null)
        ? const Center(
            child: CircularProgressIndicator(color: AppColors.primaryColor1))
        : Scaffold(
            backgroundColor: AppColors.mainColor,
            body: ScreenTemplate(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ListTile(
                      isThreeLine: true,
                      title: Text(
                        'Welcome back',
                        style: Theme.of(context).textTheme.headline5,
                      ),
                      trailing: Stack(
                        alignment: Alignment.center,
                        children: [
                          IconButton(
                            onPressed: () {
                              Get.toNamed(RouteName.notificationScreen);
                            },
                            icon: Obx(
                              () => SvgPicture.asset(
                                homeScreenController.isNotify
                                    ? 'assets/icons/Notification-Icon_RedDot.svg'
                                    : 'assets/icons/Notification-Icon.svg',
                              ),
                            ),
                          ),
                        ],
                      ),
                      subtitle: Text(
                        homeScreenController.user['name'] ?? " ",
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(fontSize: 24),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: _BMIField(widthDevice),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: _ProcessField(context, widthDevice),
                  ),
                  SizedBox(
                    height: heightOfWaterChart + 80,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Today Target',
                            overflow: TextOverflow.clip,
                            style:
                                Theme.of(context).textTheme.headline4!.copyWith(
                                      fontSize: 20,
                                    ),
                          ),
                        ),
                        const SizedBox(height: 25),
                        SizedBox(
                          height: heightOfWaterChart + 4,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              children: [
                                Expanded(
                                  child: _WaterViewField(
                                      heightOfWaterChart, context),
                                ),
                                const SizedBox(width: 10),
                                Expanded(
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: _ActivityViewField(
                                            context, heightOfWaterChart),
                                      ),
                                      const SizedBox(height: 5),
                                      Expanded(
                                        child: _CaloriesViewField(
                                            context, heightOfWaterChart),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ));
  }

  // ignore: non_constant_identifier_names
  Container _CaloriesViewField(
      BuildContext context, double heightOfWaterChart) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(right: 5),
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 2.0,
            spreadRadius: 0.0,
            offset: Offset(1, 1),
          ),
          BoxShadow(
            color: Colors.black26,
            blurRadius: 2.0,
            spreadRadius: 0.0,
            offset: Offset(-1, -1),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 30,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Calories',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                ),
                IconButton(
                    onPressed: () {
                      print(homeScreenController.kCalBurn.value);
                    },
                    icon: Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 15,
                      color: Colors.grey[400],
                    ))
              ],
            ),
          ),
          GradientText(
            '${homeScreenController.kCalConsume.value - homeScreenController.kCalBurn.value} kCal',
            gradient: AppColors.colorGradient1,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          Expanded(
            child: Center(
              child: Obx(() {
                return PieChart(
                  PieChartData(
                    pieTouchData: PieTouchData(
                      touchCallback: (FlTouchEvent event, pieTouchResponse) {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex1.value = -1;
                          return;
                        }
                        touchedIndex1.value = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      },
                    ),
                    startDegreeOffset: 180,
                    borderData: FlBorderData(
                      show: false,
                    ),
                    sectionsSpace: 1,
                    centerSpaceRadius: 0,
                    sections: [
                      Data(
                          name: 'now',
                          percents: ((homeScreenController.kCalConsume.value +
                                      homeScreenController.kCalBurn.value) !=
                                  0)
                              ? (homeScreenController.kCalBurn.value /
                                      (homeScreenController.kCalConsume.value +
                                          homeScreenController.kCalBurn.value) *
                                      100)
                                  .round()
                                  .toDouble()
                              : 1,
                          color: AppColors.primaryColor2,
                          imagePath: 'assets/images/kCalBurn.png'),
                      Data(
                        name: '',
                        percents: ((homeScreenController.kCalConsume.value +
                                    homeScreenController.kCalBurn.value) !=
                                0)
                            ? (homeScreenController.kCalConsume.value /
                                    (homeScreenController.kCalConsume.value +
                                        homeScreenController.kCalBurn.value) *
                                    100)
                                .round()
                                .toDouble()
                            : 1,
                        color: AppColors.primaryColor1,
                        imagePath: 'assets/images/kcal.png',
                      )
                    ]
                        .asMap()
                        .map<int, PieChartSectionData>((index, data) {
                          final isTouched = index == touchedIndex1.value;

                          return MapEntry(
                            index,
                            PieChartSectionData(
                              color: data.color,
                              value: data.percents,
                              title: (data.name == 'now')
                                  ? '${homeScreenController.kCalBurn.value}kCal Burn'
                                  : '${homeScreenController.kCalConsume.value}kCal \nConsume',
                              radius: isTouched ? 90 : 70,
                              titleStyle: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                              titlePositionPercentageOffset: 0.55,
                              badgeWidget: Badge(
                                data.imagePath,
                                size: isTouched ? 40.0 : 30.0,
                                borderColor: data.color,
                              ),
                              badgePositionPercentageOffset: .98,
                            ),
                          );
                        })
                        .values
                        .toList(),
                  ),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Container _ActivityViewField(
      BuildContext context, double heightOfWaterChart) {
    return Container(
      margin: const EdgeInsets.only(right: 5, bottom: 5),
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 2.0,
            spreadRadius: 0.0,
            offset: Offset(1, 1),
          ),
          BoxShadow(
            color: Colors.black26,
            blurRadius: 2.0,
            spreadRadius: 0.0,
            offset: Offset(-1, -1),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 5,
          ),
          SizedBox(
            height: 22,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Activity',
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                ),
                IconButton(
                    onPressed: () {
                      // createWorkoutNotificationAuto();
                    },
                    icon: Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 15,
                      color: Colors.grey[400],
                    ))
              ],
            ),
          ),
          const SizedBox(height: 5),
          Row(
            children: [
              RichText(
                text: TextSpan(
                  text: 'Step',
                  style: TextStyle(
                    color: Colors.red[300],
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  children: [
                    TextSpan(
                      text: '\n$footSteps',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Sen',
                        fontSize: 12,
                      ),
                    ),
                    const TextSpan(
                      text: ' stp',
                      style: TextStyle(
                        color: Colors.grey,
                        fontFamily: 'Sen',
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: 60,
                margin: const EdgeInsets.only(left: 5, right: 5),
                decoration: const BoxDecoration(
                  border: Border.symmetric(
                    vertical: BorderSide(
                        width: 1, color: Color.fromARGB(255, 192, 191, 191)),
                  ),
                ),
                child: RichText(
                  text: TextSpan(
                    text: 'Exercise',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.green[300]),
                    children: [
                      TextSpan(
                        text: '\n$exerciseTime',
                        style: const TextStyle(
                          fontWeight: FontWeight.w900,
                          color: Colors.black,
                          fontSize: 12,
                        ),
                      ),
                      const TextSpan(
                        text: ' min',
                        style: TextStyle(fontSize: 10, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
              ),
              RichText(
                text: TextSpan(
                  text: 'Sleep',
                  style: TextStyle(
                    color: Colors.blue[300],
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                  children: [
                    TextSpan(
                      text: '\n $sleepTime',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
                      ),
                    ),
                    const TextSpan(
                      text: ' hr',
                      style: TextStyle(fontSize: 10, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Expanded(
              child: Obx(
            () => Center(
              child: CircularPercentIndicator(
                animation: true,
                animationDuration: 600,
                rotateLinearGradient: true,
                radius: 400 / 2 - 140,
                lineWidth: 15.0,
                circularStrokeCap: CircularStrokeCap.round,
                percent: 0.7,
                center: CircularPercentIndicator(
                  animation: true,
                  animationDuration: 600,
                  radius: 400 / 2 - 160,
                  lineWidth: 15.0,
                  percent: (exerciseTime.value > exerciseTimeTarget.value)
                      ? 1
                      : exerciseTime.value.toDouble() /
                          exerciseTimeTarget.value.toDouble(),
                  circularStrokeCap: CircularStrokeCap.round,
                  center: CircularPercentIndicator(
                    animation: true,
                    animationDuration: 600,
                    circularStrokeCap: CircularStrokeCap.round,
                    radius: 400 / 2 - 180,
                    lineWidth: 12.0,
                    percent: 0.8,
                    backgroundColor: const Color.fromARGB(227, 224, 221, 221),
                    progressColor: Colors.blue[300],
                  ),
                  backgroundColor: const Color.fromARGB(227, 224, 221, 221),
                  progressColor: Colors.green[300],
                ),
                backgroundColor: const Color.fromARGB(227, 224, 221, 221),
                progressColor: Colors.red[300],
              ),
            ),
          )),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Container _WaterViewField(double heightOfWaterChart, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 2.0,
            spreadRadius: 0.0,
            offset: Offset(1, 1),
          ),
          BoxShadow(
            color: Colors.black26,
            blurRadius: 2.0,
            spreadRadius: 0.0,
            offset: Offset(-1, -1),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            margin: const EdgeInsets.only(left: 5, right: 5),
            child: RotatedBox(
              quarterTurns: 3,
              child: LinearPercentIndicator(
                addAutomaticKeepAlive: true,
                width: heightOfWaterChart,
                lineHeight: 22.0,
                percent: (homeScreenController.sumWater / 1000) > liters
                    ? (homeScreenController.sumWater / 1000) /
                        (homeScreenController.sumWater / 1000 + 2)
                    : (homeScreenController.sumWater / 1000) / liters,
                backgroundColor: const Color.fromARGB(227, 224, 221, 221),
                progressColor: Colors.blue[300],
                barRadius: const Radius.circular(20),
              ),
            ),
          ),
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(left: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Water',
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 15,
                          color: Colors.grey[400],
                        ),
                      )
                    ],
                  ),
                  Text(
                    '${homeScreenController.sumWater / 1000} Liters',
                    style: Theme.of(context).textTheme.headline2,
                  ),
                  // const SizedBox(height: 7),
                  const Text(
                    'Real time ',
                    style: TextStyle(
                      fontFamily: 'Sen',
                      fontSize: 15,
                      color: Colors.black45,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: homeScreenController.waterViewData.value.map((e) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 12,
                                width: 12,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      Colors.purple[100]!,
                                      const Color.fromARGB(255, 215, 185, 221),
                                      const Color.fromARGB(255, 213, 170, 220),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Text(
                                '${homeScreenController.convertIntHour(e['hour'][0])} - ${homeScreenController.convertIntHour(e['hour'][1])}',
                                style: Theme.of(context).textTheme.headline1,
                              ),
                            ],
                          ),
                          // if (litersProgress[e] != null)
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 5,
                                ),
                                child: DottedLine(
                                  lineThickness: 1.5,
                                  lineLength: 50,
                                  direction: Axis.vertical,
                                  dashLength: 4.5,
                                  dashGradient: [
                                    Colors.purple[100]!,
                                    const Color.fromARGB(255, 209, 159, 218),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 30),
                              GradientText(
                                '${e['data']}ml',
                                gradient: AppColors.colorGradient,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                              )
                            ],
                          )
                        ],
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Container _ProcessField(BuildContext context, double widthDevice) {
    return Container(
      margin: const EdgeInsets.only(top: 25, bottom: 25),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: AppColors.colorContainerTodayTarget,
      ),
      padding: const EdgeInsets.only(top: 20, bottom: 10, left: 10, right: 10),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Today Schedule',
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
              ),
              const Spacer(),
              ButtonGradient(
                height: 40.0,
                width: 90.0,
                linearGradient: LinearGradient(
                  colors: [
                    Colors.blue[200]!,
                    Colors.blue[300]!,
                  ],
                ),
                onPressed: () async {
                  await Get.toNamed(RouteName.todaySchedule);
                },
                title: const Text(
                  'Check',
                  style: TextStyle(
                    fontFamily: 'Sen',
                    fontSize: 12,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Container _BMIField(double widthDevice) {
    return Container(
      padding: const EdgeInsets.only(top: 30, bottom: 10, left: 10, right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: AppColors.colorGradient1,
      ),
      child:
          // (homeScreenController.user['name'] == null)
          //     ? const Center(
          //         child:
          //             CircularProgressIndicator(color: AppColors.primaryColor1))
          //     :
          Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'BMI (Body Mass Index)',
                    style: TextStyle(
                      fontFamily: 'Sen',
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const Text(
                    'You have a normal weight',
                    style: TextStyle(
                      fontFamily: 'Sen',
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ButtonGradient(
                    width: 120,
                    height: 44,
                    linearGradient: LinearGradient(
                      colors: [Colors.purple[100]!, Colors.purple[200]!],
                    ),
                    onPressed: () {
                      height_bmi_container.value =
                          (height_bmi_container.value - 200).abs();
                    },
                    title: const Text(
                      'View More',
                      style: TextStyle(
                        fontFamily: 'Sen',
                        fontSize: 12.5,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: SizedBox(
                  width: 80,
                  height: 80,
                  child: Obx(
                    () => PieChart(
                      PieChartData(
                        pieTouchData: PieTouchData(
                          touchCallback:
                              (FlTouchEvent event, pieTouchResponse) {
                            if (!event.isInterestedForInteractions ||
                                pieTouchResponse == null ||
                                pieTouchResponse.touchedSection == null) {
                              touchedIndex.value = -1;
                              return;
                            }
                            touchedIndex.value = pieTouchResponse
                                .touchedSection!.touchedSectionIndex;
                          },
                        ),
                        startDegreeOffset: 180,
                        borderData: FlBorderData(
                          show: false,
                        ),
                        sectionsSpace: 1,
                        centerSpaceRadius: 0,
                        sections: FakeData.data
                            .asMap()
                            .map<int, PieChartSectionData>((index, data) {
                              final isTouched = index == touchedIndex.value;

                              return MapEntry(
                                index,
                                PieChartSectionData(
                                  color: data.color,
                                  value: data.percents,
                                  title: (data.name == 'now')
                                      ? homeScreenController
                                          .bmi()
                                          .toStringAsFixed(1)
                                      : '',
                                  radius: isTouched ? 80 : 60,
                                  titleStyle: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                  titlePositionPercentageOffset: 0.55,
                                  badgeWidget: Badge(
                                    data.imagePath,
                                    size: isTouched ? 40.0 : 30.0,
                                    borderColor: data.color,
                                  ),
                                  badgePositionPercentageOffset: .98,
                                ),
                              );
                            })
                            .values
                            .toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Obx(
            () => AnimatedContainer(
              curve: Curves.linear,
              height: height_bmi_container.value == 0 ? 0 : 200,
              width: double.infinity,
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Badge(
                            'assets/images/medal.png',
                            size: 30,
                            borderColor: AppColors.primaryColor1,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'BMI: ${homeScreenController.bmi().toStringAsFixed(1)}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          const Text(
                            'Height:  ',
                            style: TextStyle(
                              color: AppColors.primaryColor1,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          LoadHeightWeight(
                            widthDevice: widthDevice,
                            imgePath: 'assets/images/height.png',
                            fData:
                                homeScreenController.user['height'].toDouble(),
                            sData: homeScreenController.user['heightTarget']
                                .toDouble(),
                            color: AppColors.primaryColor1,
                            press: () {},
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(width: 60),
                          Text(
                            '${homeScreenController.user['height']}cm',
                            style: const TextStyle(
                                color: AppColors.primaryColor1,
                                fontWeight: FontWeight.w600),
                          ),
                          const Spacer(),
                          Text(
                            '${homeScreenController.user['heightTarget']}cm',
                            style: const TextStyle(
                                color: AppColors.primaryColor1,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          const Text(
                            'Weight: ',
                            style: TextStyle(
                              color: AppColors.primaryColor2,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          LoadHeightWeight(
                            widthDevice: widthDevice,
                            imgePath: 'assets/images/weight.png',
                            fData:
                                homeScreenController.user['weight'].toDouble(),
                            sData: homeScreenController.user['weightTarget']
                                .toDouble(),
                            color: AppColors.primaryColor2,
                            press: () {},
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const SizedBox(width: 60),
                          Text(
                            '${homeScreenController.user['weight']}kg',
                            style: const TextStyle(
                                color: AppColors.primaryColor2,
                                fontWeight: FontWeight.w600),
                          ),
                          const Spacer(),
                          Text(
                            '${homeScreenController.user['weightTarget']}kg',
                            style: const TextStyle(
                                color: AppColors.primaryColor2,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
