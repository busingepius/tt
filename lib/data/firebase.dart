
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/models.dart';
import '../screens/screens.dart';

class FirebaseDatabase {
  // final CollectionReference<Map<String, dynamic>> _db =
  //     FirebaseFirestore.instance.collection('plants');

  // Stream<List<PlantModel>> fetchNews() {
  //   return _db.snapshots().map((snapshot) =>
  //       snapshot.docs.map((doc) => PlantModel.fromJson(doc.data())).toList());
  // }

  Future<void> reportBug() async {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'gegaboxtechnologies@gmail.com',
      query: encodeQueryParameters(<String, String>{
        'subject': 'REPORTING A BUG!',
      }),
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      throw 'Could not launch $emailLaunchUri';
    }
  }

  Future<void> contactUs() async {
    const String tel = '+256751746511';
    final Uri callLaunchUri = Uri(
      scheme: "tel",
      path: tel,
    );
    if (await canLaunchUrl(callLaunchUri)) {
      await launchUrl(callLaunchUri);
    } else {
      throw 'Could not launch $tel';
    }
  }

  Future<void> addPlant(int id, PlantModel plant) async {
    final plantt = PlantModel(
      id: id,
      title: plant.title,
      description: plant.description,
      image: plant.image,
      createdTime: plant.createdTime,
      dateReminder: plant.dateReminder,
      leftPlants: plant.leftPlants,
      soldPlants: plant.soldPlants,
      numberWatered: plant.numberWatered,
      numberWeeded: plant.numberWeeded,
      startedPlants: plant.startedPlants,
      transplantedPlants: plant.transplantedPlants,
      timeReminder: plant.timeReminder,
    );
    // try {
    //   await _db.doc(id.toString()).set(plantt.toJson()).then((value) async {
    //     await PushNotifications().scheduledNotification(
    //       int.parse(plantt.timeReminder.format(Get.context!).split(":")[0]),
    //       int.parse(plantt.timeReminder.format(Get.context!).split(":")[1]),
    //       plant,
    //     );
    //     Get.snackbar("Success", "Plant added to cloud");
    //     Get.offAll(const NavScreen());
    //   }).catchError((onError) async {
    //     await PushNotifications().scheduledNotification(
    //       int.parse(plantt.timeReminder.format(Get.context!).split(":")[0]),
    //       int.parse(plantt.timeReminder.format(Get.context!).split(":")[1]),
    //       plant,
    //     );
    //     // debugPrint(onError.printError());
    //     Get.snackbar("Error, Plant not update to cloud ", "Try again");
    //     Get.offAll(const NavScreen());
    //   }).timeout(const Duration(seconds: 15), onTimeout: (() async {
    //     Get.snackbar("Not added to cloud due to time out ,", "Try again");
    //     Get.offAll(const NavScreen());
    //   }));
    // } catch (e) {
    //   Get.snackbar("Plant not added to cloud because an error occured ",
    //       "Try again later");
    //   Get.offAll(const NavScreen());
    // }
  }

  Future<void>? updatePlant(PlantModel plant) async {
    // try {
    //   _db.doc(plant.id.toString()).set(plant.toJson()).then((value) async {
    //     await PushNotifications().scheduledNotification(
    //       int.parse(plant.timeReminder.format(Get.context!).split(":")[0]),
    //       int.parse(plant.timeReminder.format(Get.context!).split(":")[1]),
    //       plant,
    //     );
    //     Get.snackbar("Success", "Plant updated to cloud");
    //     Get.offAll(const NavScreen());
    //   }).catchError((onError) async {
    //     Get.snackbar("Error, Plant not update to cloud ", "Try again");
    //     Get.offAll(const NavScreen());
    //   }).timeout(const Duration(seconds: 15), onTimeout: (() async {
    //     Get.snackbar("Not updated in cloud due to time out ,", "Try again");
    //     Get.offAll(const NavScreen());
    //   }));
    // } catch (e) {
    //   Get.snackbar(
    //       "Plant not updated to cloud because an error occured ", "Try again");
    Get.offAll(const NavScreen());
  }
}

/*Future<void>*/ deletePlantById(PlantModel plant) =>2;
  // _db.doc(plant.id.toString()).delete();


