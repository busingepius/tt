import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant/screens/plant_editor.dart';
import '../data/data.dart';
import '../models/plant_model.dart';
import '../widget/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late DateTime _selectedValue = DateTime.now();
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
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: isLoading
          ? Center(
              child: Column(
                children: const <Widget>[
                  Image(
                    image: AssetImage('images/splash.png'),
                    fit: BoxFit.cover,
                  ),
                  Text(
                    "Loading...",
                    style: TextStyle(color: Colors.green),
                  ),
                  CircularProgressIndicator(),
                ],
              ),
            )
          : plants.isEmpty
              ? Center(
                  child: SizedBox(
                    child: Column(
                      children: <Widget>[
                        const Image(
                          image: AssetImage('images/splash.png'),
                          fit: BoxFit.cover,
                        ),
                        const Text(
                          "Nothing to view yet. Please add plant to care for",
                          style: TextStyle(color: Colors.green),
                        ),
                        OutlinedButton.icon(
                          onPressed: () =>
                              Get.to(() => const AddEditPlantPage()),
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
              : CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      title: const Text(
                        "Tree Tech",
                        style: TextStyle(color: Colors.green),
                      ),
                      backgroundColor: const Color(0xFFF3F5F7),
                      actions: [
                        IconButton(
                          onPressed: () {
                            final String hint = randomlyPickHint();

                            Get.defaultDialog(
                                title: "Hint",
                                titleStyle:
                                    const TextStyle(color: Colors.green),
                                middleText: hint.split(":")[0],
                                middleTextStyle:
                                    const TextStyle(color: Colors.red),
                                content: Column(
                                  children: [
                                    Text(
                                      hint.split(":")[0],
                                      style: const TextStyle(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 5.0),
                                    SizedBox(
                                      child: Text(
                                        hint.split(":")[1].trim(),
                                        style: const TextStyle(
                                            color: Colors.black87),
                                      ),
                                    ),
                                  ],
                                ));
                          },
                          icon: const Icon(Icons.lightbulb),
                          color: Colors.green,
                          iconSize: 30.0,
                        ),
                      ],
                      snap: true,
                      floating: true,
                      pinned: false,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(30),
                        ),
                      ),
                      bottom: PreferredSize(
                          preferredSize: Size(screenSize.width, 100.0),
                          child: Container(
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 10.0, bottom: 12.0),
                            height: 100.0,
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30.0),
                                bottomRight: Radius.circular(30.0),
                              ),
                            ),
                            child: DatePicker(
                              DateTime.now(),
                              initialSelectedDate: _selectedValue,
                              selectionColor: Colors.green,
                              selectedTextColor: Colors.white,
                              onDateChange: (date) {
                                setState(() {
                                  _selectedValue = date;
                                });
                              },
                            ),
                          )),
                    ),
                    SliverToBoxAdapter(
                      child: HomeContainer(
                          plants: plants, selectedDate: _selectedValue),
                    )
                  ],
                ),
    );
  }
}
