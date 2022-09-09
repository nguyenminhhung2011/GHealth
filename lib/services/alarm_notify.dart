import 'dart:isolate';

import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';

class AlarmNotify {
  static void playSound() async {
    FlutterRingtonePlayer.play(
      fromAsset: 'assets/sounds/alarm_clock.wav',
      ios: IosSounds.bell,
      looping: true, // Android only - API >= 28
      volume: 0.1, // Android only - API >= 28
      asAlarm: false, // Android only - all APIs
    );
  }

  static void stopSound() {
    FlutterRingtonePlayer.stop();
  }

  static Future<int> alarmNotification(DateTime notifyTime) async {
    final int isolateId = Isolate.current.hashCode;
    print('isolateId: $isolateId');
    AndroidAlarmManager.oneShotAt(
      notifyTime,
      isolateId,
      playSound,
      alarmClock: true,
      allowWhileIdle: true,
    );
    Future.delayed(const Duration(seconds: 60), () {
      stopSound();
      cancelAlarmNotification(isolateId);
    });
    return isolateId;
  }

  static void cancelAlarmNotification(int isolateId) {
    AndroidAlarmManager.cancel(isolateId);
  }
}
