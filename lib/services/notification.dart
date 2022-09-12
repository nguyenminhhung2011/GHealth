import 'package:awesome_notifications/awesome_notifications.dart';
import '../apps/template/misc/untils.dart';

Future<void> createMealNotification(String title) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'basic_channel',
      title:
          '${Emojis.smile_sleeping_face + Emojis.time_alarm_clock} It\'s time to sleep',
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
      title: '${Emojis.food_pizza + Emojis.food_banana} Let\'t time to eat!!!',
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

Future<void> createSleepNotificationAuto(
    NotificationWeekAndTime notificationSchedule, int id) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
        id: id,
        channelKey: 'basic_sleep_channel',
        title:
            '${Emojis.smile_sleeping_face + Emojis.time_alarm_clock} It\'s time to sleep',
        body: 'Regular Sleep, Healthy Future',
        notificationLayout: NotificationLayout.Default),
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

Future<void> createAlarmNotificationAuto(
    NotificationWeekAndTime notificationSchedule, int id) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
        id: id,
        channelKey: 'basic_alarm_channel',
        title: '${Emojis.time_alarm_clock} It\'s time to wake up',
        body:
            'Don\'t wake up with the regret of what you couldn\'t accomplish yesterday.',
        notificationLayout: NotificationLayout.Default),
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

Future<int> createWorkoutNotificationAuto(
    NotificationCalendar notificationSchedule) async {
  int id = createUniqueId();
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
        id: id,
        channelKey: 'basic_alarm_channel',
        title: '${Emojis.person_role_man_health_worker} It\' time to workout',
        body: 'Make yourself stronger than your excuses.',
        notificationLayout: NotificationLayout.Default),
    actionButtons: [
      NotificationActionButton(
        key: 'MARK_DONE',
        label: 'Mark Done',
      ),
    ],
    schedule: NotificationCalendar(
      day: notificationSchedule.day,
      month: notificationSchedule.month,
      year: notificationSchedule.year,
      hour: notificationSchedule.hour,
      minute: notificationSchedule.minute,
      second: notificationSchedule.second,
      repeats: true,
    ),
  );
  return id;
}

Future<void> cancelScheduledNotifications() async {
  await AwesomeNotifications().cancelAllSchedules();
}

Future<void> cancelScheduleNotificationsWhere(int id) async {
  await AwesomeNotifications().cancel(id);
}
