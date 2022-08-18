import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationApi {
  static final _notificationApi = FlutterLocalNotificationsPlugin();
  static Future _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel Id',
        'Channel Name',
        channelDescription: 'Channel Description',
        importance: Importance.max,
      ),
      iOS: IOSNotificationDetails(),
    );
  }

  static Future showNotification(
          {int id = 0, String? title, String? body, String? payload}) async =>
      _notificationApi.show(
        id,
        title,
        body,
        await _notificationDetails(),
        payload: payload,
      );
}
