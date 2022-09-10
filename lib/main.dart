import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:gold_health/apps/routes/app_pages.dart';
import 'package:gold_health/services/start_services.dart';

import 'apps/routes/route_name.dart';
import 'apps/template/misc/colors.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  StartService.instance.init();
  AwesomeNotifications().initialize(
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
        channelName: 'Basic Sleep Notifications',
        defaultColor: AppColors.primaryColor1,
        importance: NotificationImportance.High,
        channelShowBadge: true,
        locked: true,
        channelDescription: 'Notifications',
      ),
    ],
  );
  runApp(const MyApp());
}

void notificationInit() async {}

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
