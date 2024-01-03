import 'package:flutter/material.dart';
import 'package:flutter_local_notification/service/notification_helper.dart';
import 'package:flutter_local_notification/widget/textbuttton_reusable.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextbuttonReusable(
            color: Colors.amber,
            text: "Simple Notification",
            onPressed: () {
              debugPrint("press1");

              NotificationHelper.showNotification(
                id: 0,
                title: "Hello",
                body: "Hey i'm notification!",
                payload: 'test.abs',
                notificationHelper: NotificationHelper(),
              );
            },
          ),
          //
          const SizedBox(
            height: 10,
          ),
          TextbuttonReusable(
            color: Colors.blue,
            text: "Test",
            onPressed: () {
              debugPrint("press2");
            },
          ),
        ],
      ),
    );
  }
}
