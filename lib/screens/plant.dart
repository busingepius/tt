import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant/models/plant_model.dart';

import 'package:intl/intl.dart';
import 'package:plant/screens/nav_screen.dart';
import 'package:plant/screens/plant_editor.dart';

import '../data/data.dart';
import '../data/sql.dart';

class Plant extends StatelessWidget {
  final PlantModel? plant;
  const Plant({Key? key, this.plant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actionsIconTheme: const IconThemeData(color: Colors.white),
        leading: const BackButton(),
        actions: [
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () async {
              await PlantDatabase.instance.delete(plant!.id!);
              Get.offAll(const NavScreen());
            },
          ),
          GestureDetector(
            onTap: () => Get.to(AddEditPlantPage(
              plant: plant,
            )),
            child: Container(
              margin: const EdgeInsets.all(6.0),
              padding: const EdgeInsets.only(left: 8.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(3.0),
                  bottomRight: Radius.circular(3.0),
                  topLeft: Radius.circular(3.0),
                  topRight: Radius.circular(3.0),
                ),
              ),
              child: Row(
                children: const [
                  Text(
                    "Edit",
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(width: 5.0),
                  Icon(
                    Icons.edit_calendar_outlined,
                    color: Colors.green,
                    size: 20.0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Container(
        height: double.infinity,
        child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Positioned(
              top: 0.0,
              left: 0.0,
              right: 0.0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 10.0),
                    child: Text(
                      plant!.title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: 24.0),
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 2.0),
                    child: Text(
                      plant!.timeReminder.format(context),
                      style: TextStyle(color: Colors.yellow[400]),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 10.0),
                    child: Row(
                      children: [
                        Icon(Icons.timelapse),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          DateFormat.yMMMd().format(plant!.dateReminder),
                          style: TextStyle(color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 30.0, vertical: 2.0),
                    child: Text(
                      plant!.completed
                          ? "No reminders"
                          : "Has a pending reminder",
                      style: TextStyle(color: Colors.yellow[400]),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
              bottom: 0.0,
              left: 0.0, right: 0.0,
              // height:50,
              // width: 50,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                height: 450,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.only(
                    // bottomLeft: Radius.circular(3.0),
                    // bottomRight: Radius.circular(3.0),
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: ListView(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text(
                        'Plant Care',
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.water_drop),
                      title: RichText(
                        text: TextSpan(
                          text: 'Watering \n',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(
                              text: plant!.watering == true
                                  ? "Enabled"
                                  : "Disabled",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.light_mode_outlined),
                      title: RichText(
                        text: TextSpan(
                          text: 'Weeding \n',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(
                              text: plant!.weeding == true
                                  ? "Enabled"
                                  : "Disabled",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.device_thermostat_outlined),
                      title: RichText(
                        text: TextSpan(
                          text: 'Sowing \n',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(
                              text: plant!.sowing == true
                                  ? "Enabled"
                                  : "Disabled",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.landslide_sharp),
                      title: RichText(
                        text: TextSpan(
                          text: 'Nursury Bed \n',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(
                              text: plant!.nurseryBed == true
                                  ? "Enabled"
                                  : "Disabled",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.auto_stories_outlined),
                      title: RichText(
                        text: TextSpan(
                          text: 'Mulching \n',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(
                              text: plant!.mulching == true
                                  ? "Enabled"
                                  : "Disabled",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.auto_stories_outlined),
                      title: RichText(
                        text: TextSpan(
                          text: 'Potting \n',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(
                              text: plant!.potting == true
                                  ? "Enabled"
                                  : "Disabled",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.auto_stories_outlined),
                      title: RichText(
                        text: TextSpan(
                          text: 'Gap filling \n',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(
                              text: plant!.gapFiling == true
                                  ? "Enabled"
                                  : "Disabled",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.auto_stories_outlined),
                      title: RichText(
                        text: TextSpan(
                          text: 'Spraying \n',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(
                              text: plant!.spraying == true
                                  ? "Enabled"
                                  : "Disabled",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.auto_stories_outlined),
                      title: RichText(
                        text: TextSpan(
                          text: 'Fertiliz \n',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(
                              text: plant!.fertilizing == true
                                  ? "Enabled"
                                  : "Disabled",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.auto_stories_outlined),
                      title: RichText(
                        text: TextSpan(
                          text: 'Thinning \n',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          children: <TextSpan>[
                            TextSpan(
                              text: plant!.thinning == true
                                  ? "Enabled"
                                  : "Disabled",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: ListTile(
                        leading: const Icon(Icons.auto_stories_outlined),
                        title: RichText(
                          text: TextSpan(
                            text: 'Pruning \n',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                            children: <TextSpan>[
                              TextSpan(
                                text: plant!.pruning == true
                                    ? "Enabled"
                                    : "Disabled",
                                style: TextStyle(
                                    color: Colors.black54,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              top: 80.0,
              right: 30.0,
              // right: 60.0,
              child: Container(
                height: 160.0,
                width: 150.0,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image:
                        MemoryImage(Utility.dataFromBase64String(plant!.image)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
