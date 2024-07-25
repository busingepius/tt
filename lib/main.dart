import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import './screens/screens.dart';
import 'data/data.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await flutterLocalNotificationsPlugin.initialize(
    PushNotifications.initializationSettings,
    onSelectNotification: PushNotifications().selectNotification,
  );

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await PlantDatabase.instance.database;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    return GetMaterialApp(
      title: 'Tree Tech',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        inputDecorationTheme: const InputDecorationTheme(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1.0, color: Colors.greenAccent),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 1.0, color: Colors.green),
          ),
        ),
        primaryColor: const Color(0xFFD8ECF1),
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
        colorScheme: ColorScheme.fromSwatch()
            .copyWith(secondary: const Color(0xFFD8ECF1)),
      ),
      home: const NavScreen(),
    );
  }
}