import 'package:flutter/material.dart';
import 'package:plant/data/data.dart';

// import '../models/models.dart';
// import '../screens/screens.dart';

class Week extends StatelessWidget {
  const Week({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(10.0),
      ),
      height: 120.0,
      child: Row(
        children: const [Text("data"), Text("data"), Text("data")],
      ),
    );
  }
}
