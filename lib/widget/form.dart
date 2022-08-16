import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:plant/data/image.dart';

class PlantFormWidget extends StatelessWidget {

  final String? title;
  final String? image;
  final String? description;
  final DateTime? dateReminder;
  final TimeOfDay? timeReminder;
  final int? numberWatered;
  final int? numberWeeded;
  final int? startedPlants;
  final int? leftPlants;

  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedDescription;

  final ValueChanged<DateTime> onChangeddateReminder;
  final ValueChanged<TimeOfDay> onChangedtimeReminder;
  final ValueChanged<int> onChangednumberWatered;
  final ValueChanged<int> onChangednumberWeeded;
  final ValueChanged<int> onChangedstartedPlants;
  final ValueChanged<int> onChangedleftPlants;

  const PlantFormWidget({
    Key? key,
    this.dateReminder,
    this.timeReminder,
    this.leftPlants = 0,
    this.numberWatered = 0,
    this.numberWeeded = 0,
    this.startedPlants = 0,
    this.title = '',
    this.image,
    this.description = '',

    required this.onChangedTitle,
    required this.onChangedDescription,
    required this.onChangednumberWatered,
    required this.onChangeddateReminder,
    required this.onChangedtimeReminder,
    required this.onChangednumberWeeded,
    required this.onChangedstartedPlants,
    required this.onChangedleftPlants,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildTitle(),
              SizedBox(height: 8),
              buildDescription(),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(child: dateReminderBuilder()),
                  const SizedBox(width: 10.0),
                  Expanded(child: timeReminderBuilder()),
                ],
              ),
              const SizedBox(height: 10.0),
              startedWithPlantsBuilder(),
              const SizedBox(height: 10.0),
              reminderWithPlantsBuilder(),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  Expanded(child: timesWateredBuilder()),
                  const SizedBox(width: 10.0),
                  Expanded(child: timesWeededBuilder()),
                ],
              )
            ],
          ),
        ),
      );

  Widget buildTitle() => TextFormField(
        maxLines: 1,
        initialValue: title,
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: 'Plant title',
          hintStyle: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w400,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue, width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          labelText: 'Plant\'s Name',
          //lable style
          labelStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
            // fontFamily: "verdana_regular",
            fontWeight: FontWeight.w400,
          ),
        ),
        validator: (title) =>
            title != null && title.isEmpty ? 'The title cannot be empty' : null,
        onChanged: onChangedTitle,
      );

  Widget buildDescription() => TextFormField(
        maxLines: 5,
        initialValue: description,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: 'Plant Description',
          hintStyle: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w400,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue, width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          labelText: 'Plant\'s Description',
          //lable style
          labelStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
            // fontFamily: "verdana_regular",
            fontWeight: FontWeight.w400,
          ),
        ),
        style: const TextStyle(color: Colors.black, fontSize: 18),
        validator: (description) => description != null && description.isEmpty
            ? 'The description cannot be empty'
            : null,
        onChanged: onChangedDescription,
      );

  Widget dateReminderBuilder() => TextFormField(
        maxLines: 1,
        onTap: () async {
          final currentDate = DateTime.now();
          final selected = await showDatePicker(
            context: Get.context!,
            initialDate: currentDate,
            firstDate: currentDate,
            lastDate: DateTime(currentDate.year + 10),
          );
          if (selected != null) {
            onChangeddateReminder(selected);
            // dateReminder = selected;
          }
        },
        initialValue: DateFormat.yMMMd().format(dateReminder!),
        // dateReminder!.toIso8601String(),
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: 'set date reminder',
          hintStyle:const  TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w400,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue, width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          labelText: 'date reminder',
          //lable style
          labelStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
            // fontFamily: "verdana_regular",
            fontWeight: FontWeight.w400,
          ),
          // suffix: IconButton(onPressed: ()=>print('ndhfhfhdhd'), icon: Icon(Icons.abc,),iconSize: 5.0,),
        ),
        validator: (dateReminder) =>
            dateReminder != null && dateReminder.isEmpty
                ? 'cannot be empty'
                : null,
        onChanged: (String val) {
          final changedDate = DateTime.parse(val);
          onChangeddateReminder(changedDate);
        },
        keyboardType: TextInputType.datetime,
        readOnly: true,
      );

  Widget timeReminderBuilder() => TextFormField(
        maxLines: 1,
        initialValue: timeReminder!.format(Get.context!),
        readOnly: true,
        onTap: () async {
          final selected = await showTimePicker(
            initialTime: timeReminder!,
            context: Get.context!,
          );
          if (selected != null) {
            onChangedtimeReminder(selected);
            // timeReminder = selected;
          }
        },
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: 'Time Reminder',
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w400,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue, width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          labelText: 'Time Reminder',
          //lable style
          labelStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
            // fontFamily: "verdana_regular",
            fontWeight: FontWeight.w400,
          ),
        ),
        validator: (timeReminder) =>
            timeReminder != null && timeReminder.isEmpty
                ? 'cannot be empty'
                : null,
        onChanged: (String val) {
          // final time = TimeOfDay(
          //     hour: int.parse(val.split(":")[0]),
          //     minute: int.parse(val.split(":")[1]));
          onChangedtimeReminder;
        },
      );

  Widget timesWateredBuilder() => TextFormField(
        maxLines: 1,
        initialValue: numberWatered.toString(),
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: 'Times Watered',
          hintStyle: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w400,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue, width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          labelText: 'Times Watered',
          //lable style
          labelStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
            // fontFamily: "verdana_regular",
            fontWeight: FontWeight.w400,
          ),
        ),
        validator: (numberWatered) =>
            numberWatered != null && numberWatered.isEmpty
                ? 'cannot be empty'
                : null,
        onChanged: (val) {
          final number = int.parse(val);
          onChangednumberWatered(number);
        },
        keyboardType: TextInputType.number,
      );

  Widget timesWeededBuilder() => TextFormField(
        maxLines: 1,
        initialValue: numberWeeded.toString(),
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: 'Number Weeded',
          hintStyle: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w400,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue, width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          labelText: 'Number Weeded',
          //lable style
          labelStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
            // fontFamily: "verdana_regular",
            fontWeight: FontWeight.w400,
          ),
        ),
        validator: (numberWeeded) =>
            numberWeeded != null && numberWeeded.isEmpty
                ? 'cannot be empty'
                : null,
        // onChanged: onChangednumberWeeded,
        onChanged: (val) {
          final number = int.parse(val);
          onChangednumberWeeded(number);
        },
        keyboardType: TextInputType.numberWithOptions(),
      );

  Widget startedWithPlantsBuilder() => TextFormField(
        maxLines: 1,
        initialValue: startedPlants.toString(),
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: 'started Plants',
          hintStyle: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w400,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue, width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          labelText: 'started Plants',
          //lable style
          labelStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
            // fontFamily: "verdana_regular",
            fontWeight: FontWeight.w400,
          ),
        ),
        validator: (startedPlants) =>
            startedPlants != null && startedPlants.isEmpty
                ? 'cannot be empty'
                : null,
        // onChanged: onChangedstartedPlants,
        onChanged: (val) {
          final number = int.parse(val);
          onChangedstartedPlants(number);
        },
        keyboardType: TextInputType.numberWithOptions(),
      );

  Widget reminderWithPlantsBuilder() => TextFormField(
        maxLines: 1,
        keyboardType: TextInputType.numberWithOptions(),
        initialValue: leftPlants.toString(),
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          hintText: 'left Plants',
          hintStyle: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w400,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue, width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          labelText: 'left Plants',
          //lable style
          labelStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
            // fontFamily: "verdana_regular",
            fontWeight: FontWeight.w400,
          ),
        ),
        validator: (leftPlants) =>
            leftPlants != null && leftPlants.isEmpty ? 'cannot be empty' : null,
        // onChanged: onChangedleftPlants,
        onChanged: (val) {
          final number = int.parse(val);
          onChangedleftPlants(number);
        },
      );
}
