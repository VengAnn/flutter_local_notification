import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationHelper {
  //instant Notification plugin
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final onNotifications = BehaviorSubject<String?>();

  static Future init({bool initSchedule = false}) async {
    tz.initializeTimeZones(); // Initialize time zones
    tz.setLocalLocation(
        tz.getLocation('Asia/Ho_Chi_Minh')); // Set Vietnam's timezone

    final android = AndroidInitializationSettings('@mipmap/ic_launcher');
    final iOS = DarwinInitializationSettings();
    final settings = InitializationSettings(android: android, iOS: iOS);
    await _notifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (payload) async {
        onNotifications.add(payload.payload); // add payload to the stream
      },
    );
  }

  //funciton show notification
  static Future<void> showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async {
    await _notifications.show(
      id,
      title,
      body,
      await _notificationDetails(),
      payload: payload,
    );
  }

  // static Future<void> scheduleNotifications() async {
  //   try {
  //     final scheduledTime =
  //         tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5));
  //     await _notifications.zonedSchedule(
  //       0,
  //       "Notification Title",
  //       "This is the Notification Body!",
  //       scheduledTime,
  //       await _notificationDetails(),
  //       androidAllowWhileIdle: true,
  //       uiLocalNotificationDateInterpretation:
  //           UILocalNotificationDateInterpretation.absoluteTime,
  //     );
  //     print("Notification scheduled for $scheduledTime");
  //   } catch (e) {
  //     print("Error scheduling notification: $e");
  //     // Handle error: You can log it, show an error message, or perform any other necessary action.
  //   }
  // }

  //funciton show notification
  static Future<void> showScheduleNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
    required DateTime scheduleDate,
  }) async {
    try {
      await _notifications.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(
          scheduleDate,
          tz.local,
        ),
        //tz.TZDateTime.now(tz.local).add(Duration(seconds: 1)), // this work
        await _notificationDetails(),
        payload: payload,
        androidAllowWhileIdle: true,
        //androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        // matchDateTimeComponents:
        //     DateTimeComponents.time, // Set matchDateTimeComponents
      );
    } on PlatformException catch (e) {
      debugPrint("error ${e.message}");
    }
  }

  static Future<NotificationDetails> _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channel id',
        'channelName',
        channelDescription: "channelDescription",
        importance: Importance.max,
        priority: Priority.max,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }
}
