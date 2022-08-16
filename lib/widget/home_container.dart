import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:plant/models/plant_model.dart';
// import 'package:plant/screens/plant.dart';
import 'package:intl/intl.dart';

import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../data/image.dart';
import '../data/sql.dart';
import '../main.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: plants.length,
          itemBuilder: ((BuildContext context, int index) {
            final plant = plants[index];

            if (DateFormat.yMMMd().format(plant.dateReminder) ==
                DateFormat.yMMMd().format(selectedDate)) {
              // scheduledNotification(
              //   int.parse(plant.timeReminder.format(context).split(":")[0]),
              //   int.parse(plant.timeReminder.format(context).split(":")[1]),
              //   plant,
              // );

              return GestureDetector(
                onTap: () async {
                  await scheduledNotification(
                    int.parse(plant.timeReminder.format(context).split(":")[0]),
                    int.parse(plant.timeReminder.format(context).split(":")[1]),
                    plant,
                  );
                  // showBottomSheet(context, plant);
                  debugPrint("yeyeyeyeyeyeyeyeyeyeyeyeyeyeyeyeBOTTOMSHEET");
                },
                child: Container(
                  margin: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 5.0),
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
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
                              "Reminder At: ${plant.timeReminder.format(Get.context!)}",
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 90.0,
                        width: 80.0,
                        margin: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: MemoryImage(
                              Utility.dataFromBase64String(plant.image),
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
                      )
                    ],
                  ),
                ),
              );
            } else {
              return Container();
            }
          }),
        ),
      ],
    );
  }

  tz.TZDateTime _convertTime(int hour, int minutes) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduleDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minutes,
    );

    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }
    
    return scheduleDate;
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();
    final String timeZone = await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZone));
  }

  Future<void> scheduledNotification(
    int hour,
    int minutes,
    PlantModel plant,
  ) async {
    _configureLocalTimeZone();
    // tz.setLocalLocation(tz.getLocation(timeZoneName));

    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'plantID',
      'plantName',
      channelDescription: 'Channel for Plant Notifications',
      icon: 'splash',
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      plant.id!,
      plant.title,
      plant.description,
      _convertTime(hour, minutes),
      // tz.TZDateTime.now(tz.local).add( Duration(seconds: minutes)),
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
      payload: plant.image,
    );

    debugPrint("jejejejejejejejejejejejejejejeeeeeeeeydjhdasjsdnsdjj");
  }

  showBottomSheet(BuildContext context, PlantModel plant) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.only(top: 4.0),
        color: Colors.white,
        height: plant.completed
            ? MediaQuery.of(context).size.height * 0.24
            : MediaQuery.of(context).size.height * 0.32,
        child: Column(
          children: [
            Container(
              height: 6,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: Colors.grey[300],
              ),
            ),

            plant.completed
                ? Container()
                : _bottomSheetButton(
                    label: "Completed",
                    onTap: () {
                      // plant.completed = true;
                      Get.back();
                    },
                    color: Colors.blue,
                    context: context,
                  ),
            const SizedBox(height: 10),

            _bottomSheetButton(
              label: "Delete",
              onTap: () async {
                // await PlantDatabase.instance.delete(plant.id!);
                Get.back();
              },
              color: Colors.red[300],
              context: context,
            ),
            // const SizedBox(height: 10),
            const Spacer(),
            _bottomSheetButton(
              label: "Close",
              onTap: () {
                Get.back();
              },
              color: Colors.red[300],
              isClose: true,
              context: context,
            ),
            // const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  _bottomSheetButton({
    String? label,
    Function()? onTap,
    Color? color,
    bool isClose = false,
    BuildContext? context,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4.0),
        height: 55,
        width: MediaQuery.of(context!).size.width * 0.9,
        decoration: BoxDecoration(
            color: isClose ? Colors.white : color,
            border: Border.all(
              width: 2,
              color: isClose ? Colors.black54 : color!,
            ),
            borderRadius: BorderRadius.circular(20.0)),
        child: Center(
          child: Text(
            label!,
            style:
                isClose ? titleStyle : titleStyle.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  TextStyle get titleStyle {
    return const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.w500,
      color: Colors.black,
    );
  }
}
