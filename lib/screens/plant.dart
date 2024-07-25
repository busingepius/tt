import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../data/data.dart';
import '../models/models.dart';
import 'plant_editor.dart';
import 'screens.dart';

class Plant extends StatelessWidget {
  final PlantModel? plant;

  const Plant({Key? key, this.plant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0.0,
        actionsIconTheme: const IconThemeData(color: Colors.white),
        leading: const BackButton(),
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: AspectRatio(
                aspectRatio: 1.0,
                child: plant!.image == ""
                    ? Image.asset(
                        "assets/logo/splash.png",
                        fit: BoxFit.cover,
                      )
                    : Image.memory(
                        plant!.image,
                        fit: BoxFit.cover,
                      ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              child: Text(
                plant!.title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 24.0),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 2.0),
              child: Row(
                children: [
                  const Icon(Icons.timelapse),
                  const SizedBox(width: 5.0),
                  Text(
                    "Time of reminder: ${plant!.timeReminder.format(context)}",
                    style: const TextStyle(color: Colors.black45),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
              child: Row(
                children: [
                  const Icon(Icons.calendar_month),
                  const SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    "Day of reminder: ${DateFormat.yMMMd().format(plant!.dateReminder)}",
                    style: const TextStyle(color: Colors.black54),
                  ),
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 2.0),
              child: Text(
                plant!.description,
                style: const TextStyle(color: Colors.black87),
              ),
            ),

          ],
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          TextButton(
               child: const Text("DELETE",style: TextStyle(color: Colors.red),),
              onPressed: () async {
                await PlantDatabase.instance
                    .delete(plant!.id!)
                    .then((value) async {
                  Get.offAll(const NavScreen());
                });

              },
            ),
          TextButton(
              onPressed: () => Get.to(AddEditPlantPage(
                plant: plant,
              )),
              child:const  Text(
                "Edit",
                style: TextStyle(
                  color: Colors.green,
                ),
              ),
            ),
        ],
      ),
    );
  }
}