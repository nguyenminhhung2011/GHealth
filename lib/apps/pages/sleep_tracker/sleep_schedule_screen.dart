import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/global_widgets/screenTemplate.dart';
import 'package:gold_health/apps/pages/dashboard/widgets/button_gradient.dart';
import 'package:gold_health/apps/pages/sleep_tracker/add_alarm_screen.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

// ignore: must_be_immutable
class SleepScheduleScreen extends StatefulWidget {
  SleepScheduleScreen(
      {Key? key, required this.itemBuilder, required this.listSchedule})
      : super(key: key);
  final Widget Function(Map<String, dynamic>, double) itemBuilder;
  RxList<Map<String, dynamic>> listSchedule;
  @override
  State<SleepScheduleScreen> createState() => _SleepScheduleScreenState();
}

class _SleepScheduleScreenState extends State<SleepScheduleScreen> {
  final List<DateTime> listDateTime = [
    for (int i = 1; i <= 30; i++)
      DateTime(2022, 8, 1).subtract(Duration(days: i)),
    for (int i = 0; i <= 30; i++) DateTime(2022, 8, 1).add(Duration(days: i))
  ];

  PageController pageController = PageController();

  late int onFocus = listDateTime.indexWhere((element) =>
      DateFormat().add_yMd().format(element) ==
      DateFormat().add_yMd().format(DateTime.now()));

  Widget _itemBuilder(BuildContext context, int index) {
    return Container(
      alignment: Alignment.center,
      margin: const EdgeInsets.all(10),
      width: 80,
      height: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        gradient: onFocus == index
            ? LinearGradient(colors: [
                Colors.blue[200]!,
                Colors.blue[300]!,
                Colors.blue[400]!
              ])
            : const LinearGradient(
                colors: [
                  Color.fromARGB(255, 233, 237, 240),
                  Color.fromARGB(255, 233, 237, 240),
                ],
              ),
      ),
      child: SizedBox(
        height: 80,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              DateFormat().add_E().format(listDateTime[index]),
              style: TextStyle(
                color: onFocus == index ? Colors.white : Colors.black,
              ),
            ),
            Text(
              DateFormat().add_d().format(listDateTime[index]),
              style: TextStyle(
                color: onFocus == index ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    var heightDevice = MediaQuery.of(context).size.height;
    var widthDevice = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push<void>(
            MaterialPageRoute(
              builder: (context) =>
                  AddAlarmScreen(listSchedule: widget.listSchedule.value),
            ),
          );
        },
        elevation: 5,
        child: Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(colors: [
                Colors.blue[100]!,
                Colors.blue[200]!,
                Colors.blue[300]!
              ])),
          child: const Icon(
            Icons.add_outlined,
            size: 20,
          ),
        ),
      ),
      body: ScreenTemplate(
        child: SafeArea(
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.close,
                        size: 20,
                      ),
                    ),
                    const Text(
                      'Sleep Schedule',
                      style: TextStyle(
                        fontFamily: 'Sen',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.more_horiz),
                    )
                  ],
                ),
                const SizedBox(height: 40),
                Container(
                  height: heightDevice * 0.23,
                  width: widthDevice,
                  padding: const EdgeInsets.all(20),
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: Colors.blue[100]!.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            'Ideal Hours for Sleep',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          RichText(
                            text: const TextSpan(
                              children: [
                                TextSpan(
                                  text: '8',
                                  style: TextStyle(
                                      color: Colors.blueAccent, fontSize: 20),
                                ),
                                TextSpan(
                                  text: 'hours ',
                                  style: TextStyle(
                                      color: Colors.blueAccent, fontSize: 18),
                                ),
                                TextSpan(
                                  text: '30',
                                  style: TextStyle(
                                      color: Colors.blueAccent, fontSize: 20),
                                ),
                                TextSpan(
                                  text: 'minutes',
                                  style: TextStyle(
                                      color: Colors.blueAccent, fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          ButtonGradient(
                            height: 50,
                            width: 130,
                            linearGradient: LinearGradient(colors: [
                              Colors.blue[200]!,
                              Colors.blue[300]!,
                              Colors.blue[400]!
                            ]),
                            onPressed: () {},
                            title: const Text(
                              'Learn More',
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      Expanded(child: Image.asset('assets/images/moon.png')),
                    ],
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    'Your Schedule',
                    style: Theme.of(context)
                        .textTheme
                        .headline5!
                        .copyWith(fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.17,
                  child: ScrollSnapList(
                    itemBuilder: _itemBuilder,
                    background: Colors.blue[200],
                    itemCount: listDateTime.length,
                    itemSize: 100,
                    dispatchScrollNotifications: true,
                    initialIndex: onFocus.toDouble(),
                    scrollPhysics: const ScrollPhysics(),
                    duration: 1000,
                    curve: Curves.linear,
                    onItemFocus: (int index) {
                      setState(() {
                        onFocus = index;
                      });
                      pageController.animateToPage(pageIndex == 0 ? 1 : 0,
                          duration: const Duration(milliseconds: 750),
                          curve: Curves.ease);
                      pageIndex = pageIndex == 0 ? 1 : 0;
                    },
                  ),
                ),
                const SizedBox(height: 15),
                Obx(
                  () => Container(
                    height:
                        widget.listSchedule.value.length.toDouble() * 100 + 70,
                    child: PageView(
                      controller: pageController,
                      children: [
                        SizedBox(
                          height: widget.listSchedule.value.length.toDouble() *
                                  100 +
                              50,
                          width: widthDevice,
                          child: Column(
                            children: [
                              ...(widget.listSchedule.value).map((element) {
                                return widget.itemBuilder(element, widthDevice);
                              }).toList(),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: widget.listSchedule.value.length.toDouble() *
                                  100 +
                              50,
                          width: widthDevice,
                          child: Column(
                            children: [
                              ...(widget.listSchedule.value).map((element) {
                                return widget.itemBuilder(element, widthDevice);
                              }).toList(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: heightDevice * 0.15,
                  width: widthDevice,
                  margin: const EdgeInsets.symmetric(horizontal: 20.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.purple[50]!,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(
                              text: 'You will get ',
                              style:
                                  TextStyle(fontSize: 17, color: Colors.black),
                            ),
                            TextSpan(
                              text: '8',
                              style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                            TextSpan(
                              text: 'hours ',
                              style:
                                  TextStyle(fontSize: 17, color: Colors.black),
                            ),
                            TextSpan(
                              text: '10',
                              style: TextStyle(
                                  fontSize: 19,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                            ),
                            TextSpan(
                              text: 'minutes for tonight',
                              style:
                                  TextStyle(fontSize: 17, color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      LinearPercentIndicator(
                        animationDuration: 800,
                        animation: true,
                        lineHeight: 25,
                        barRadius: const Radius.circular(20),
                        percent: 0.96,
                        progressColor: Colors.purple[300]!,
                        center: const Text(
                          '96%',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
