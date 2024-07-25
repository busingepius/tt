import 'package:flutter/material.dart';

class ShowScreen extends StatelessWidget {
  final String? payload;
  const ShowScreen({Key? key, this.payload}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(backgroundColor: Colors.green,
        title:const  Text("Reminder"),
      ),
      body: const Center(
        child: SizedBox(
          child:  Text("That was your reminder"),
        ),
      ),
    );
  }
}