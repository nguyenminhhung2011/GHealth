import 'dart:io';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:gold_health/apps/pages/list_plan_screen/daily_plan_screen.dart';
import '../../../services/alarm_notify.dart';
import '../../controls/dashboard_controller.dart';
import '../../template/misc/colors.dart';
import '../dashboard/home_screen.dart';
import '../progress_tracker/progress_photo_screen.dart';
import 'activity_tracker_screen.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen>
    with SingleTickerProviderStateMixin {
  final _dashBoardScreenC = Get.find<DashBoardControl>();
  final Duration animDuration = const Duration(seconds: 2);
  bool isLoading = false;

  final List<Widget> listPage = [
    const HomeScreen(),
    DailyPlanScreen(),
    const ProgressPhotoScreen(),
    ActivityTrackerScreen(),
  ];

  final List<IconData> _iconList = [
    Icons.home_outlined,
    Icons.local_activity_outlined,
    Icons.camera_alt_outlined,
    Icons.person_outline,
  ];

  bool isPressButton = false;

  Future<Widget> refreshPage() async {
    final result =
        await Future<Widget>.value(listPage[_dashBoardScreenC.tabIndex.value]);
    return result;
  }

  @override
  void initState() {
    super.initState();
    // AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    //   if (!isAllowed) {
    //     showDialog(
    //       context: context,
    //       builder: (context) => AlertDialog(
    //         title: const Text('Allow Notifications'),
    //         content: const Text('Our app would like to send you notifications'),
    //         actions: [
    //           TextButton(
    //             onPressed: () {
    //               Navigator.pop(context);
    //             },
    //             child: const Text(
    //               'Don\'t Allow',
    //               style: TextStyle(
    //                 color: Colors.grey,
    //                 fontSize: 18,
    //               ),
    //             ),
    //           ),
    //           TextButton(
    //               onPressed: () => AwesomeNotifications()
    //                   .requestPermissionToSendNotifications()
    //                   .then((_) => Navigator.pop(context)),
    //               child: const Text(
    //                 'Allow',
    //                 style: TextStyle(
    //                   color: Colors.teal,
    //                   fontSize: 18,
    //                   fontWeight: FontWeight.bold,
    //                 ),
    //               ))
    //         ],
    //       ),
    //     );
    //   }
    // });

    // AwesomeNotifications().actionStream.listen((notification) {
    //   if (notification.channelKey == 'basic_channel' && Platform.isIOS) {
    //     AwesomeNotifications().getGlobalBadgeCounter().then(
    //           (value) =>
    //               AwesomeNotifications().setGlobalBadgeCounter(value - 1),
    //         );
    //   }
    // });

    AwesomeNotifications().displayedStream.listen((notification) async {
      if (notification.channelKey == 'basic_alarm_channel') {
        await FlutterRingtonePlayer.play(
          fromAsset: 'assets/sounds/alarm_clock.wav',
          ios: IosSounds.bell,
          looping: true,
          volume: 0.1,
          asAlarm: true,
        ).whenComplete(() {
          Future.delayed(const Duration(seconds: 30), () async {
            debugPrint('stopping after 30s');
            FlutterRingtonePlayer.stop();
          });
        });
      }
    });

    AwesomeNotifications().actionStream.listen((notification) {
      if (notification.channelKey == 'basic_alarm_channel') {
        FlutterRingtonePlayer.stop();
      }
    });
  }

  @override
  void dispose() {
    print('dashboard dispose');
    AwesomeNotifications().actionSink.close();
    AwesomeNotifications().createdSink.close();
    AwesomeNotifications().dismissedSink.close();
    AwesomeNotifications().displayedSink.close();
    // AwesomeNotifications().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return snapshot.data as Widget;
            }
          }
          return const Center(child: CircularProgressIndicator());
        },
        future: refreshPage(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/Home.svg',
              color: _dashBoardScreenC.tabIndex.value == 0
                  ? AppColors.primaryColor1
                  : Colors.grey,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/Document.svg',
              color: _dashBoardScreenC.tabIndex.value == 1
                  ? AppColors.primaryColor1
                  : Colors.grey,
            ),
            label: 'Planner',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/Camera.svg',
              color: _dashBoardScreenC.tabIndex.value == 2
                  ? AppColors.primaryColor1
                  : Colors.grey,
            ),
            label: 'Progress',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/icons/Profile.svg',
              color: _dashBoardScreenC.tabIndex.value == 3
                  ? AppColors.primaryColor1
                  : Colors.grey,
            ),
            label: 'Person',
          )
        ],
        type: BottomNavigationBarType.shifting,
        selectedItemColor: AppColors.primaryColor1,
        unselectedItemColor: Colors.grey,
        currentIndex: _dashBoardScreenC.tabIndex.value,
        elevation: 10,
        onTap: (value) => setState(() {
          _dashBoardScreenC.tabIndex.value = value;
        }),
      ),
    );
  }
}
