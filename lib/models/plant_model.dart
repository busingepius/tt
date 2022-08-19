import 'package:flutter/material.dart';
import 'package:get/get.dart';

const String tablePlants = 'plants';

class PlantFields {
  static final List<String> values = [
    id,
    title,
    description,
    image,
    createdTime,
    dateReminder,
    timeReminder,
    numberWatered,
    numberWeeded,
    startedPlants,
    leftPlants,
  ];

  static const String id = '_id';
  static const String title = 'title';
  static const String description = 'description';
  static const String image = 'image';
  static const String createdTime = 'createdTime';
  static const String dateReminder = 'dateReminder';
  static const String timeReminder = 'timeReminder';
  static const String numberWatered = 'numberWatered';
  static const String numberWeeded = 'numberWeeded';
  static const String startedPlants = 'startedPlants';
  static const String leftPlants = 'leftPlants';
}

class PlantModel {
   int? id;
  final String title;
  final String description;
  final String image;
  final DateTime createdTime;
  final DateTime dateReminder;
  final TimeOfDay timeReminder;
  final int numberWatered;
  final int numberWeeded;
  final int startedPlants;
  final int leftPlants;

   PlantModel({
    this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.createdTime,
    required this.dateReminder,
    required this.timeReminder,
    required this.numberWatered,
    required this.numberWeeded,
    required this.startedPlants,
    required this.leftPlants,
  });

  PlantModel copy({
    int? id,
    String? title,
    String? description,
    String? image,
    DateTime? createdTime,
    DateTime? dateReminder,
    TimeOfDay? timeReminder,
    int? numberWatered,
    int? numberWeeded,
    int? startedPlants,
    int? leftPlants,
  }) =>
      PlantModel(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        image: image ?? this.image,
        createdTime: createdTime ?? this.createdTime,
        dateReminder: dateReminder ?? this.dateReminder,
        timeReminder: timeReminder ?? this.timeReminder,
        numberWatered: numberWatered ?? this.numberWatered,
        numberWeeded: numberWeeded ?? this.numberWeeded,
        startedPlants: startedPlants ?? this.startedPlants,
        leftPlants: leftPlants ?? this.leftPlants,
      );

  static PlantModel fromJson(Map<String, Object?> json) => PlantModel(
        id: json[PlantFields.id] as int?,
        title: json[PlantFields.title] as String,
        description: json[PlantFields.description] as String,
        image: json[PlantFields.image] as String,
        createdTime: DateTime.parse(json[PlantFields.createdTime] as String),
        dateReminder: DateTime.parse(json[PlantFields.dateReminder] as String),
        leftPlants: json[PlantFields.leftPlants] as int,
        numberWatered: json[PlantFields.numberWatered] as int,
        numberWeeded: json[PlantFields.numberWeeded] as int,
        startedPlants: json[PlantFields.startedPlants] as int,
        timeReminder: TimeOfDay(
          hour: int.parse(
              json[PlantFields.timeReminder].toString().split(":")[0]),
          minute: int.parse(json[PlantFields.timeReminder]
              .toString()
              .split(":")[1]
              .substring(0, 2)),
        ),
      );

  Map<String, Object?> toJson() {
    var map = <String, Object?>{
      PlantFields.title: title,
      PlantFields.description: description,
      PlantFields.image: image,
      PlantFields.dateReminder: dateReminder.toIso8601String(),
      PlantFields.timeReminder: timeReminder.format(Get.context!),
      PlantFields.numberWatered: numberWatered,
      PlantFields.numberWeeded: numberWeeded,
      PlantFields.startedPlants: startedPlants,
      PlantFields.leftPlants: leftPlants,
      PlantFields.createdTime: createdTime.toIso8601String(),
    };
    if (id != null) {
      map[PlantFields.id] = id;
    }
    return map;
  }
}
