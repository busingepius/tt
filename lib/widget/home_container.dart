import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../data/data.dart';
import '../models/models.dart';

class HomeContainer extends StatelessWidget {
  final List<PlantModel> plants;
  final DateTime selectedDate;
  const HomeContainer({
    Key? key,
    required this.plants,
    required this.selectedDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: plants.length,
      itemBuilder: ((BuildContext context, int index) {
        final plant = plants[index];

        if (DateFormat.yMMMd().format(plant.dateReminder) ==
            DateFormat.yMMMd().format(selectedDate)) {
          return Card(
            color: Colors.grey[300],
            child: Container(
              height: Get.height * 0.4,
              width: double.infinity,
              margin:
              const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        image: plant.image == ""
                            ? const DecorationImage(
                          image: AssetImage(
                            "assets/logo/splash.png",
                          ),
                          fit: BoxFit.contain,
                        )
                            : DecorationImage(
                          image: MemoryImage(
                            plant.image,
                          ),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0),
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 10.0, right: 10.0, bottom: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          plant.title,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.black, fontSize: 18),
                        ),
                        Text(
                          "Planted on: ${DateFormat.yMMMd().format(plant.createdTime)}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 18,
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(Icons.timelapse),
                            const SizedBox(width: 5.0),
                            Text(
                              "Reminder Time: ${plant.timeReminder.format(Get.context!)}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.green[300],
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            const Icon(Icons.calendar_month),
                            const SizedBox(width: 5.0),
                            Text(
                              "Reminder Date: ${DateFormat.yMMMd().format(plant.dateReminder)}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.green[600],
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        } else {
          return Container();
        }
      }),
    );
  }
}