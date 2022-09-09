import 'package:awesome_notifications/awesome_notifications.dart';
import '../apps/template/misc/untils.dart';

Future<void> createMealNotification(String title) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'basic_channel',
      title: '${Emojis.food_pizza + Emojis.food_banana} Let\'t time to eat!!!',
      body: title,
      bigPicture: 'asset://assets/notification_map.png',
      notificationLayout: NotificationLayout.BigPicture,
    ),
  );
}

Future<void> createMealNotificationAuto(
    NotificationWeekAndTime notificationSchedule, int typeOfEat) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'basic_channel',
      title: '${Emojis.food_red_apple} Let\' time time to Eat',
      body: typeOfEat == 1
          ? 'Eat breakfast to have an active day'
          : typeOfEat == 2
              ? 'Have lunch after a tiring work breakfast'
              : 'Let\'s have dinner to end the day',
      notificationLayout: NotificationLayout.Default,
    ),
    actionButtons: [
      NotificationActionButton(
        key: 'MARK_DONE',
        label: 'Mark Done',
      ),
    ],
    schedule: NotificationCalendar(
      weekday: notificationSchedule.dayOfTheWeek,
      hour: notificationSchedule.timeOfDay.hour,
      minute: notificationSchedule.timeOfDay.minute,
      second: 0,
      millisecond: 0,
      repeats: true,
    ),
  );
}

Future<void> cancelScheduledNotifications() async {
  await AwesomeNotifications().cancelAllSchedules();
}
