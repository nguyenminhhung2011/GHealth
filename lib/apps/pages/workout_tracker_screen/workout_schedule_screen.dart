import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/controls/workout_controller/workout_plan_controller.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import '../../template/misc/colors.dart';
import 'package:intl/intl.dart';
import './add_schedule_screen.dart';

import '../dashboard/widgets/button_gradient.dart';

class WorkoutScheduleScreen extends StatefulWidget {
  const WorkoutScheduleScreen({Key? key}) : super(key: key);

  @override
  State<WorkoutScheduleScreen> createState() => _WorkoutScheduleScreenState();
}

class _WorkoutScheduleScreenState extends State<WorkoutScheduleScreen> {
  final _workoutPlanController = Get.find<WorkoutPlanController>();
  Rx<DateTime> now = DateTime.now().obs;
  late final Timer? timer = Timer.periodic(const Duration(seconds: 1), (timer) {
    now.value = DateTime.now();
  });
  final List<DateTime> listDateTime = [
    for (int i = 1; i <= 10; i++) DateTime.now().subtract(Duration(days: i)),
    for (int i = 0; i <= 10; i++) DateTime.now().add(Duration(days: i))
  ];
  GlobalKey<ScrollSnapListState> sslKey = GlobalKey();
  late int onFocus = listDateTime.indexWhere((element) =>
      DateFormat().add_yMd().format(element) ==
      DateFormat().add_yMd().format(DateTime.now()));
  final CalendarController _calendarController = CalendarController();
  late RxList<Meeting> meetings = _workoutPlanController.schedules.value.entries
      .map(
        (schedule) => Meeting(
          eventName: schedule.value.workoutCategory,
          from: schedule.value.time,
          to: schedule.value.time.add(const Duration(hours: 1)),
          background: Colors.black,
          isAllDay: false,
        ),
      )
      .toList()
      .obs;

  bool _initState = true;

  Widget _itemBuilder(BuildContext context, int index) {
    return CustomItemBuilder(
      index: index,
      onFocus: onFocus,
      listDateTime: listDateTime,
    );
  }

  Widget _scheduleBuilder(
      BuildContext context, CalendarAppointmentDetails details) {
    final Meeting meeting = details.appointments.first;

    return Obx(
      () => CustomScheduleComponent(now: now.value, meeting: meeting),
    );
  }

  void addMeeting(Meeting value) {
    setState(() {
      meetings.add(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => AddScheduleScreen(dateTime: listDateTime[onFocus]),
              arguments: addMeeting);
        },
        child: Container(
          height: 60,
          width: 60,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              colors: [
                AppColors.primaryColor1,
                AppColors.primaryColor1,
              ],
            ),
          ),
          child: const Icon(
            Icons.add_outlined,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  Text(
                    'Workout Schedule',
                    style: Theme.of(context)
                        .textTheme
                        .headline4!
                        .copyWith(fontSize: 20),
                  ),
                  InkWell(
                    onTap: Get.back,
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
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () {
                      setState(() {
                        onFocus--;
                        sslKey.currentState!.focusToItem(onFocus);
                        _calendarController.displayDate = listDateTime[onFocus];
                      });
                    },
                    icon: Icon(
                      Icons.arrow_back_ios_new_outlined,
                      size: 18,
                      color: Colors.grey[400],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '${DateFormat().add_MMM().format(listDateTime[onFocus])} ${listDateTime[onFocus].year}',
                    style: Theme.of(context).textTheme.headline5,
                  ),
                  const SizedBox(width: 8),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        onFocus++;
                        sslKey.currentState!.focusToItem(onFocus);
                        _calendarController.displayDate = listDateTime[onFocus];
                      });
                    },
                    icon: Icon(
                      Icons.arrow_forward_ios_outlined,
                      size: 18,
                      color: Colors.grey[400],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: Get.mediaQuery.size.height * 0.17,
                child: ScrollSnapList(
                  key: sslKey,
                  itemBuilder: _itemBuilder,
                  background: Colors.blue[200],
                  itemCount: listDateTime.length,
                  itemSize: 100,
                  dispatchScrollNotifications: true,
                  initialIndex: onFocus.toDouble(),
                  scrollPhysics: const ScrollPhysics(),
                  duration: 1000,
                  onItemFocus: (int index) async {
                    setState(() {
                      onFocus = index;
                      _calendarController.displayDate = listDateTime[onFocus];
                    });
                  },
                ),
              ),
              SizedBox(
                height: Get.mediaQuery.size.height + 100,
                child: SfCalendar(
                  initialDisplayDate: listDateTime[onFocus],
                  controller: _calendarController,
                  viewNavigationMode: ViewNavigationMode.none,
                  allowAppointmentResize: true,
                  view: CalendarView.day,
                  headerHeight: 0,
                  viewHeaderHeight: 0,
                  dataSource: MeetingDataSource(meetings.value),
                  appointmentBuilder: _scheduleBuilder,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _calendarController.dispose();
    timer!.cancel();
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments![index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments![index].to;
  }

  @override
  String getSubject(int index) {
    return appointments![index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments![index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments![index].isAllDay;
  }
}

class Meeting {
  Meeting(
      {required this.eventName,
      required this.from,
      required this.to,
      required this.background,
      required this.isAllDay});

  String eventName;
  DateTime from;
  DateTime to;
  Color background;
  bool isAllDay;
}

class CustomItemBuilder extends StatelessWidget {
  const CustomItemBuilder(
      {super.key,
      required this.index,
      required this.onFocus,
      required this.listDateTime});
  final int index;
  final int onFocus;
  final List<DateTime> listDateTime;
  @override
  Widget build(BuildContext context) {
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
                  Colors.white10,
                  Colors.white10,
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
    ;
  }
}

class CustomScheduleComponent extends StatelessWidget {
  const CustomScheduleComponent({
    super.key,
    required this.now,
    required this.meeting,
  });
  final DateTime now;
  final Meeting meeting;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => Dialog(
            elevation: 5,
            child: Container(
              padding: const EdgeInsets.only(
                  right: 15, top: 15, bottom: 15, left: 20),
              height: Get.mediaQuery.size.height * 0.3,
              width: Get.mediaQuery.size.width,
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
                        'Workout Schedule',
                        style: TextStyle(
                          overflow: TextOverflow.ellipsis,
                          fontFamily: 'Sen',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.more_horiz),
                      )
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    meeting.eventName,
                    style: const TextStyle(
                      fontFamily: 'Sen',
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Icons.access_time_outlined),
                      const SizedBox(width: 10),
                      Text(
                        '${DateFormat().add_E().format(meeting.from)} | ${DateFormat('kk:mm').format(meeting.from)}',
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Expanded(
                    child: Center(
                      child: ButtonGradient(
                        height: 50,
                        width: 250,
                        linearGradient: LinearGradient(colors: [
                          Colors.blue[200]!,
                          Colors.blue[300]!,
                          Colors.blue[400]!
                        ]),
                        onPressed: () {},
                        title: const Text(
                          'Mark as Done',
                          style: TextStyle(
                              fontFamily: 'Sen',
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      child: Stack(
        alignment: Alignment.center,
        fit: StackFit.expand,
        children: [
          RotatedBox(
            quarterTurns: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: LinearProgressIndicator(
                color: Colors.blue[300],
                backgroundColor: Colors.grey.withOpacity(0.5),
                value: (meeting.to.isBefore(now)
                    ? 1.0
                    : meeting.from.isAfter(now)
                        ? 0
                        : (now.difference(meeting.from).inSeconds.toDouble()) /
                            meeting.to.difference(meeting.from).inSeconds),
              ),
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Text(
              meeting.eventName,
              style: const TextStyle(
                color: Colors.white,
                fontFamily: 'Sen',
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
