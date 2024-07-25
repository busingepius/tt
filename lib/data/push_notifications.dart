import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import '../main.dart';
import '../models/models.dart';
import '../screens/screens.dart';

class PushNotifications {
  static AndroidInitializationSettings initializationSettingsAndroid =
  const AndroidInitializationSettings('splash');

  static InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
  );

  selectNotification(String? payload) {
    if (payload != null) {
      Get.to(ShowScreen(payload: payload));
    }
  }

  tz.TZDateTime _convertTime(int hour, int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minutes,
    );

    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }

    return scheduleDate;
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation("America/Chicago"));
  }

  Future<void> scheduledNotification(
      int hour,
      int minutes,
      PlantModel plant,
      ) async {
    _configureLocalTimeZone();

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'plantID',
      'plantName',
      channelDescription: 'Channel for Plant Notifications',
      icon: 'splash',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      plant.id!,
      plant.title,
      plant.description,
      _convertTime(hour, minutes),
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
      UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      payload: plant.image.toString(),
    );
  }

  Future<void> cancelNotification(int id) async {
    await flutterLocalNotificationsPlugin.cancel(id);
  }

  Future<void> cancelNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}