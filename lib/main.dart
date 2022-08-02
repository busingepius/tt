import 'package:flutter/material.dart';
import 'package:plant/screens/screens.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'nkumbio',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // primaryColor: Color(0xFFD8ECF1),
        // accentColor: Color(0xFFD8ECF1),
        scaffoldBackgroundColor: Color.fromARGB(255, 255, 255, 255),
      ),
      home: const NavScreen(),
    );
  }
}
