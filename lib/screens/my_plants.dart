// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';

import '../widget/widgets.dart';

class MyPlants extends StatelessWidget {
  const MyPlants({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(
          "My Plants",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        centerTitle: false,
        actions: <Widget>[
          CircleButton(
            icon: Icons.settings,
            color: Colors.white,
            containerColor: Colors.green,
            iconSize: 30.0,
            onPressed: () => null,
          ),
        ],
      ),
      body: GridView.builder(
        itemCount: 12,
        // itemExtent: 2,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return Container(
            height: 120.0,
            width: 80.0,
            color: const Color(0xFFF3F5F7),
            margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Olivia"),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.0),
                  child: Text("Snake Plant"),
                ),
                Container(
                  height: 80.0,
                  width: 50.0,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        "images/a2.png",
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
