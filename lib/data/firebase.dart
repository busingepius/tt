import 'package:cloud_firestore/cloud_firestore.dart';

import 'dart:async';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant/models/models.dart';

import 'package:url_launcher/url_launcher.dart';

class Database {

  final CollectionReference<Map<String, dynamic>> _db =
      FirebaseFirestore.instance.collection('plants');

  Stream<List<PlantModel>> fetchNews() {
    return _db.snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => PlantModel.fromJson(doc.data())).toList());
  }

  Future<void> reportBug() async {
    String? encodeQueryParameters(Map<String, String> params) {
      return params.entries
          .map((MapEntry<String, String> e) =>
              '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
          .join('&');
    }

    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'info@ylecug.org',
      query: encodeQueryParameters(<String, String>{
        'subject': 'I am Uganda. The land of the best of it all!',
      }),
    );

    if (await canLaunchUrl(emailLaunchUri)) {
      await launchUrl(emailLaunchUri);
    } else {
      throw 'Could not launch $emailLaunchUri';
    }
  }

  Future<void> contactUs() async {
    const String tel = '+256784421884';
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

  Future<void> addPlant(PlantModel plant) async {
    await _db.add(plant.toJson()).catchError(
          (error) => Get.snackbar(
            "Plant Added",
            error,
          ),
        );
  }

  // Future<void> updatePlant(PlantModel plant) {
  //   _db.doc(plant.id.toString()).update(plant.toJson());
  // }

  // Future<void> deletePlantById(PlantModel plant) => _db.doc(plant.id.toString()).delete();

}
