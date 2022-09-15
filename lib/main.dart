import 'dart:async';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:gold_health/apps/routes/app_pages.dart';
import 'package:gold_health/services/start_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'apps/routes/route_name.dart';
import 'apps/template/misc/colors.dart';

import 'package:workmanager/workmanager.dart';

late SharedPreferences sharedPreferencesOfApp;

Future initSharePreference() async {
  sharedPreferencesOfApp = await SharedPreferences.getInstance();
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future notificationInit() async {
  await AwesomeNotifications().initialize(
    'resource://drawable/res_notification_app_icon',
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic Notifications',
        defaultColor: AppColors.primaryColor1,
        importance: NotificationImportance.High,
        channelShowBadge: true,
        locked: true,
        channelDescription: 'Notifications',
      ),
      NotificationChannel(
        channelKey: 'scheduled_channel',
        channelName: 'Scheduled Notifications',
        defaultColor: Colors.teal,
        locked: true,
        importance: NotificationImportance.High,
        soundSource: 'resource://raw/res_custom_notification',
        channelDescription: 'Notifications',
      ),
      NotificationChannel(
        channelKey: 'basic_alarm_channel',
        channelName: 'Basic Alarm Notifications',
        defaultColor: AppColors.primaryColor1,
        importance: NotificationImportance.High,
        channelShowBadge: true,
        locked: true,
        channelDescription: 'Notifications',
      ),
      NotificationChannel(
        channelKey: 'basic_sleep_channel',
        channelName: 'Basic Sleep Notifications',
        defaultColor: AppColors.primaryColor1,
        importance: NotificationImportance.High,
        channelShowBadge: true,
        locked: true,
        channelDescription: 'Notifications',
      ),
      NotificationChannel(
        channelKey: 'fasting_notification',
        channelName: 'Fasting Notification',
        defaultColor: AppColors.primaryColor1,
        importance: NotificationImportance.High,
        channelShowBadge: true,
        locked: true,
        channelDescription: 'Notifications',
      ),
    ],
  );
  AwesomeNotifications().createdStream.listen((notification) {
    if (notification.channelKey == 'fasting_notification') {
      int? controllerDuration =
          sharedPreferencesOfApp.getInt('controllerDuration');
      int? endDuration = sharedPreferencesOfApp.getInt('endDuration');
      Timer? timer;
      try {
        timer = Timer.periodic(const Duration(seconds: 1), (_) {
          if (controllerDuration! >= endDuration!) {
            controllerDuration = endDuration;
            timer?.cancel();
            timer = null;
            print("finish fasting");
          } else {
            controllerDuration = controllerDuration! + 1;
            print('controllerDuration: $controllerDuration');
            sharedPreferencesOfApp.reload();
            sharedPreferencesOfApp.setInt(
                'controllerDuration', controllerDuration!);
          }
        });
      } catch (e) {
        rethrow;
      }
    }
  });
  AwesomeNotifications().displayedStream.listen((notification) async {
    print('capture something: displayedStream');
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
    print('capture something: actionStream');
    if (notification.channelKey == 'basic_alarm_channel') {
      FlutterRingtonePlayer.stop();
    }
  });
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initSharePreference();
  StartService.instance.init();
  Workmanager().initialize(isInDebugMode: true, callbackDispatcher);
  notificationInit();

  runApp(const MyApp());
}

void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    if (taskName == 'save_value_count_down_controller') {
      final bool isPlaying = inputData?['isPlaying'];
      final int indexOfListChoice = inputData?['indexOfListChoice'];
      final int endDuration = inputData?['endDuration'];
      int controllerDuration = inputData?['controllerDuration'];
      print('done');
      await sharedPreferencesOfApp.reload();
      await sharedPreferencesOfApp.setBool('isPlaying', isPlaying);
      await sharedPreferencesOfApp.setBool('isFasting', true);
      await sharedPreferencesOfApp.setInt('index', indexOfListChoice);
      await sharedPreferencesOfApp.setInt('endDuration', endDuration);
      Timer? timer;

      try {
        timer = Timer.periodic(const Duration(seconds: 1), (_) {
          if (controllerDuration >= endDuration) {
            controllerDuration = endDuration;
            timer?.cancel();
            timer = null;
            print("finish fasting");
          } else {
            ++controllerDuration;
            print('controllerDuration: $controllerDuration');
            sharedPreferencesOfApp.reload();
            sharedPreferencesOfApp.setInt(
                'controllerDuration', controllerDuration);
          }
        });
        return Future.value(true);
      } catch (e) {
        return Future.value(false);
      }
    } else if (taskName == 'remove_value_count_down_controller') {
      print('Delete fasting schedule');
    }
    return Future.value(true);
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppColors.mainColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: "Sen",
        textTheme: TextTheme(
          headline1: const TextStyle(
            fontFamily: 'Sen',
            fontSize: 15,
            color: Colors.black38,
          ),
          //For number home_screen
          headline2: TextStyle(
            fontFamily: 'Sen',
            fontSize: 23,
            fontWeight: FontWeight.w600,
            foreground: Paint()
              ..shader = LinearGradient(colors: [
                const Color.fromARGB(255, 199, 231, 247),
                Colors.blue[200]!,
                Colors.blue[300]!,
                Colors.blue[400]!,
                Colors.blue[500]!,
              ]).createShader(
                const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0),
              ),
          ),

          //For home_screen
          headline3: const TextStyle(
            fontFamily: 'Sen',
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          //Title
          headline4: const TextStyle(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          //Normal text (info,notice,...)
          headline5: const TextStyle(
            color: Colors.black54,
            fontSize: 15,
          ),

          headline6: const TextStyle(
            color: Colors.black26,
            fontSize: 18,
          ),
        ),
      ),
      initialRoute: RouteName.splash,
      getPages: AppPages.pages,
      defaultTransition: Transition.cupertino,
    );
  }
}
