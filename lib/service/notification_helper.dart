import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationHelper {
  //instant Notification plugin
  final _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> setup() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosInitializationSettings = DarwinInitializationSettings();

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: androidInitializationSettings,
      iOS: iosInitializationSettings,
    );

    await _flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  //funciton show notification
  // static Future showNotification({
  //   int id = 0,
  //   String? title,
  //   String? body,
  //   String? payload,
  // }) async =>
  //     _notification.show(
  //       id,
  //       title,
  //       body,
  //       await _notificationDetails(),
  //       payload: payload,
  //     );

  Future<NotificationDetails> _notificationDetails() async {
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
      '0', // channel Id
      'general', // channel Name
    );

    //this for ios
    // ignore: unnecessary_nullable_for_final_variable_declarations
    const DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails();

    return const NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );
  }

  static Future<void> showNotification({
    required int id,
    required String? title,
    required String? body,
    String? payload,
    required NotificationHelper notificationHelper,
  }) async {
    final notificationDetails = await notificationHelper._notificationDetails();

    await notificationHelper._flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }
}
