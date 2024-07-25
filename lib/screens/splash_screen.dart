import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/logo/splash.png"),
            Container(
              color: Colors.white,
              child: const CircularProgressIndicator(color: Colors.green),
            ),
          ],
        )
    );
  }
}