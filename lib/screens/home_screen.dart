import 'package:flutter/material.dart';

import '../widget/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: const FloatingActionButton(
        backgroundColor: Colors.grey,
        onPressed: null,
        child: Icon(Icons.add),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text(
              "PlantApp",
              style: TextStyle(color: Colors.black),
            ),
            backgroundColor: const Color(0xFFF3F5F7),
            actions: [
              CircleButton(
                icon: Icons.settings,
                color: Colors.white,
                containerColor: Colors.green,
                iconSize: 30.0,
                onPressed: () => null,
              ),
            ],
            snap: true,
            floating: true,
            pinned: true,
            // flexibleSpace: Text("TODO"),
          ),
          SliverToBoxAdapter(
            child: Card(
              child: Row(
                children: [
                  CircleButton(
                    icon: Icons.grass,
                    iconSize: 50.0,
                    onPressed: () => null,
                    color: Colors.green,
                    containerColor: Colors.white,
                  ),
                ],
              ),
            ),
          ),
          const SliverPadding(
            padding: EdgeInsets.all(8.0),
            sliver: SliverToBoxAdapter(
              child: Text("Pius"),
            ),
          ),
          const SliverToBoxAdapter(
            child: Text("data"),
          ),
        ],
      ),
    );
  }
}
