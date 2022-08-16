import 'package:flutter/material.dart';
import 'package:get/get.dart';

const String tablePlants = 'plants';

// TimeOfDay now = TimeOfDay.now();
// const TimeOfDay releaseTime = TimeOfDay(hour: 15, minute: 0); // 3:00pm
// TimeOfDay roomBooked = TimeOfDay.fromDateTime(DateTime.parse('2018-10-20 16:30:04Z')); // 4:30pm

class PlantFields {
  static final List<String> values = [
    id,
    title,
    description,
    image,
    createdTime,
    completed,
    watering,
    weeding,
    sowing,
    nurseryBed,
    mulching,
    potting,
    gapFiling,
    spraying,
    fertilizing,
    thinning,
    pruning,
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
  static const String completed = 'completed';
  static const String watering = 'watering';
  static const String weeding = 'weeding';
  static const String sowing = 'sowing';
  static const String nurseryBed = 'nurseryBed';
  static const String mulching = 'mulching';
  static const String potting = 'potting';
  static const String gapFiling = 'gapFiling';
  static const String spraying = 'spraying';
  static const String fertilizing = 'fertilizing';
  static const String thinning = 'thinning';
  static const String dateReminder = 'dateReminder';
  static const String timeReminder = 'timeReminder';
  static const String numberWatered = 'numberWatered';
  static const String numberWeeded = 'numberWeeded';
  static const String startedPlants = 'startedPlants';
  static const String leftPlants = 'leftPlants';
  static const String pruning = 'pruning';
}

class PlantModel {
  final int? id;
  final String title;
  final String description;
  final String image;
  final DateTime createdTime;
  final bool completed;
  final bool watering;
  final bool weeding;
  final bool sowing;
  final bool nurseryBed;
  final bool mulching;
  final bool potting;
  final bool gapFiling;
  final bool spraying;
  final bool fertilizing;
  final bool thinning;
  final bool pruning;
  final DateTime dateReminder;
  final TimeOfDay timeReminder;
  final int numberWatered;
  final int numberWeeded;
  final int startedPlants;
  final int leftPlants;

  const PlantModel({
    this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.createdTime,
    required this.completed,
    required this.watering,
    required this.weeding,
    required this.sowing,
    required this.nurseryBed,
    required this.mulching,
    required this.potting,
    required this.gapFiling,
    required this.spraying,
    required this.fertilizing,
    required this.thinning,
    required this.pruning,
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
    bool? completed,
    bool? watering,
    bool? weeding,
    bool? sowing,
    bool? nurseryBed,
    bool? mulching,
    bool? potting,
    bool? gapFiling,
    bool? spraying,
    bool? fertilizing,
    bool? thinning,
    bool? pruning,
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
        completed: completed ?? this.completed,
        watering: watering ?? this.watering,
        weeding: weeding ?? this.weeding,
        sowing: sowing ?? this.sowing,
        dateReminder: dateReminder ?? this.dateReminder,
        timeReminder: timeReminder ?? this.timeReminder,
        numberWatered: numberWatered ?? this.numberWatered,
        numberWeeded: numberWeeded ?? this.numberWeeded,
        startedPlants: startedPlants ?? this.startedPlants,
        leftPlants: leftPlants ?? this.leftPlants,
        nurseryBed: nurseryBed ?? this.nurseryBed,
        mulching: mulching ?? this.mulching,
        potting: potting ?? this.potting,
        gapFiling: gapFiling ?? this.gapFiling,
        spraying: spraying ?? this.spraying,
        fertilizing: fertilizing ?? this.fertilizing,
        thinning: thinning ?? this.thinning,
        pruning: pruning ?? this.pruning,
      );

  static PlantModel fromJson(Map<String, Object?> json) => PlantModel(
        id: json[PlantFields.id] as int?,
        title: json[PlantFields.title] as String,
        description: json[PlantFields.description] as String,
        image: json[PlantFields.image] as String,
        createdTime: DateTime.parse(json[PlantFields.createdTime] as String),
        completed: json[PlantFields.completed] == 1,
        watering: json[PlantFields.watering] == 1,
        weeding: json[PlantFields.weeding] == 1,
        sowing: json[PlantFields.sowing] == 1,
        nurseryBed: json[PlantFields.nurseryBed] == 1,
        mulching: json[PlantFields.mulching] == 1,
        potting: json[PlantFields.potting] == 1,
        gapFiling: json[PlantFields.gapFiling] == 1,
        spraying: json[PlantFields.spraying] == 1,
        fertilizing: json[PlantFields.fertilizing] == 1,
        thinning: json[PlantFields.thinning] == 1,
        pruning: json[PlantFields.pruning] == 1,
        dateReminder: DateTime.parse(json[PlantFields.dateReminder] as String),
        leftPlants: json[PlantFields.leftPlants] as int,
        numberWatered: json[PlantFields.numberWatered] as int,
        numberWeeded: json[PlantFields.numberWeeded] as int,
        startedPlants: json[PlantFields.startedPlants] as int,
        timeReminder: TimeOfDay(
          hour: int.parse(json[PlantFields.timeReminder].toString().split(":")[0]),
          minute: int.parse(json[PlantFields.timeReminder].toString().split(":")[1]),
        ),
      );

  Map<String, Object?> toJson() => {
        PlantFields.id: id,
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
        PlantFields.completed: completed ? 1 : 0,
        PlantFields.watering: watering ? 1 : 0,
        PlantFields.weeding: weeding ? 1 : 0,
        PlantFields.sowing: sowing ? 1 : 0,
        PlantFields.nurseryBed: nurseryBed ? 1 : 0,
        PlantFields.mulching: mulching ? 1 : 0,
        PlantFields.potting: potting ? 1 : 0,
        PlantFields.gapFiling: gapFiling ? 1 : 0,
        PlantFields.spraying: spraying ? 1 : 0,
        PlantFields.fertilizing: fertilizing ? 1 : 0,
        PlantFields.thinning: thinning ? 1 : 0,
        PlantFields.pruning: pruning ? 1 : 0,
      };
}
