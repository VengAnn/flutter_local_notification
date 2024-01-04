import 'package:flutter/material.dart';
import 'package:flutter_local_notification/service/notification_helper.dart';
import 'package:flutter_local_notification/widget/textbuttton_reusable.dart';

import 'second_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();

    NotificationHelper.init();
    listenNotification();
  }

  void listenNotification() {
    NotificationHelper.onNotifications.stream.listen(onClickNotification);
  }

  void onClickNotification(String? payload) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => SecondPage(payload: payload),
      ),
    );
  }

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
                payload: 'test.esthabs',
              );
            },
          ),
          //
          const SizedBox(
            height: 10,
          ),
          TextbuttonReusable(
            color: Colors.blue,
            text: "Schedul Notification",
            onPressed: () {
              debugPrint("press2");
              NotificationHelper.showScheduleNotification(
                title: "test schedule",
                body: "Today at 6 PM",
                payload: "dinner_6PM",
                scheduleDate: DateTime.now().add(
                  const Duration(seconds: 5),
                ),
              );

              // Show SnackBar when the Schedule Notification button is pressed
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Scheduled in 5 seconds"),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
