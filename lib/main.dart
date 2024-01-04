import 'package:flutter/material.dart';
import 'package:flutter_local_notification/home_page.dart';
import 'package:flutter_local_notification/second_page.dart';
import 'package:flutter_local_notification/service/notification_helper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // await NotificationHelper().setup();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
