import 'dart:isolate';

// import 'package:audioplayers/audioplayers.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import '../constrains.dart';

class AlarmNotify {
  static void playSound(int isolateId) async {
    await FlutterRingtonePlayer.play(
      fromAsset: 'assets/sounds/alarm_clock.wav',
      ios: IosSounds.bell,
      looping: true, // Android only - API >= 28
      volume: 0.1, // Android only - API >= 28
      asAlarm: true, // Android only - all APIs
    ).whenComplete(() {
      Future.delayed(const Duration(seconds: 30), () async {
        debugPrint('stopping after 30s');
        FlutterRingtonePlayer.stop();
        cancelAlarmNotification(isolateId);
      });
    });
    // await createWorkoutNotificationAuto(isolateId).whenComplete(() {
    //   AwesomeNotifications().actionStream.listen((event) async {
    //     print('capture something');
    //     print(event.channelKey.toString());
    //     if (event.channelKey == 'basic_alarm_channel') {
    //       debugPrint('stop sound and notification when tap notification');
    //       FlutterRingtonePlayer.stop();
    //       cancelAlarmNotification(isolateId);
    //     }
    //   }, onError: (_) => debugPrint('er ror when tap notification'));
    // });

    AwesomeNotifications().actionSink.close(); // Delete stream
    AwesomeNotifications().cancel(isolateId); // Delete notification in memory
  }

  static Future<int> alarmNotification(
      String idSharePreferences, DateTime notifyTime) async {
    final int isolateId = Isolate.current.hashCode;
    final sharedPreferencesInstance = await sharedPreferences;
    sharedPreferencesInstance.setInt(idSharePreferences, isolateId);
    debugPrint('alarmNotification: $isolateId');
    await AndroidAlarmManager.oneShotAt(
      notifyTime,
      isolateId,
      playSound,
      alarmClock: true,
    );

    return isolateId;
  }

  static void cancelAlarmNotification(int isolateId) async {
    debugPrint('cancelAlarmNotification: $isolateId');
    AndroidAlarmManager.cancel(isolateId);
  }
}
