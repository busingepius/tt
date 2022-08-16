import 'package:flutter/material.dart';

class ShowScreen extends StatelessWidget {
  final String? payload;
  const ShowScreen({Key? key, this.payload}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(payload!),
      ),
      body: Container(
        child: Text(payload!),
      ),
    );
  }
}
