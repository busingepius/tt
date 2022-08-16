import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant/screens/plant_editor.dart';
import 'package:plant/screens/screens.dart';

import '../data/sql.dart';
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

  // @override
  // void dispose() {
  //   PlantDatabase.instance.close();

  //   super.dispose();
  // }

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
              child: SizedBox(
                height: 350.0,
                width: 300.0,
                child: Column(
                  children: const <Widget>[
                    Image(
                      image: AssetImage('images/a1.png'),
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
              ? Center(
                  child: SizedBox(
                    height: 310.0,
                    width: 300.0,
                    child: Column(
                      children: <Widget>[
                        const Image(
                          image: AssetImage('images/a1.png'),
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
                      // toolbarHeight: 10,
                      title: const Text(
                        "Tree Tech",
                        style: TextStyle(color: Colors.green),
                      ),
                      backgroundColor: const Color(0xFFF3F5F7),
                      actions: [
                        IconButton(
                          onPressed: () => Get.to(Settings()),
                          icon: const Icon(Icons.settings),
                          color: Colors.green,
                          iconSize: 30.0,
                        ),
                      ],
                      snap: true,
                      floating: true,
                      pinned: false,
                      // flexibleSpace: Text("TODO"),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(30),
                        ),
                      ),
                      bottom: PreferredSize(
                          preferredSize: /*isEmpty!?const Size(0.0, 0.0): */ Size(
                              screenSize.width, 100.0),
                          child: /*isEmpty!
                  ?  const SizedBox.shrink():*/
                              Container(
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
                                // New date selected
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
