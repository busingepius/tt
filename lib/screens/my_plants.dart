import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../data/sql.dart';
import '../models/plant_model.dart';
import '../widget/widgets.dart';
import 'plant_editor.dart';
import 'screens.dart';

class MyPlants extends StatefulWidget {
  const MyPlants({Key? key}) : super(key: key);

  @override
  State<MyPlants> createState() => _MyPlantsState();
}

class _MyPlantsState extends State<MyPlants> {
  final bool? isEmpty = false;
  late List<PlantModel> plants;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    plants = await PlantDatabase.instance.readAllPlants();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: const Text(
          "My Plants",
          style: TextStyle(color: Colors.green),
        ),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        centerTitle: false,
        actions: <Widget>[
          IconButton(
            onPressed: () => Get.to(const Settings()),
            icon: const Icon(Icons.settings),
            color: Colors.green,
            iconSize: 30.0,
          ),
        ],
      ),
      body: isLoading
          ? SafeArea(
            child: const Center(
                    child: Column(
            children:  <Widget>[
              Image(
                image: AssetImage('assets/logo/splash.png'),
                fit: BoxFit.cover,
              ),
              Text(
                "Loading...",
                style: TextStyle(color: Colors.green),
              ),
              CircularProgressIndicator(),
            ],
                    ),
                  ),
          )
          : plants.isEmpty
          ? SafeArea(
            child: Center(
                    child: Column(
            children: <Widget>[
              const Image(
                image: AssetImage('assets/logo/splash.png'),
                fit: BoxFit.cover,
              ),
              const Text(
                "You have no plants to view. Please add plant to care for.",
                style: TextStyle(color: Colors.green),
              ),
              OutlinedButton.icon(
                onPressed: () => Get.to(() => const AddEditPlantPage()),
                icon: const Icon(
                  Icons.add,
                  color: Colors.green,
                ),
                label: const Text(
                  "Add",
                  style: TextStyle(color: Colors.green),
                ),
              ),
            ],
                    ),
                  ),
          )
          : GridView.builder(
        itemCount: plants.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          final PlantModel plant = plants[index];
          return GestureDetector(
              onTap: () => Get.to(
                Plant(plant: plant),
              ),
              child: MyPlant(plant: plant));
        },
      ),
    );
  }
}