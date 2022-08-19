import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

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
    this.leftPlants,
    this.numberWatered,
    this.numberWeeded,
    this.startedPlants,
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
          padding:const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildTitle(),
             const SizedBox(height: 8),
              buildDescription(),
             const SizedBox(height: 16),
              Container(
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(10.0),
                    bottomRight: Radius.circular(10.0),
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0),
                  ),
                  border: Border.all(width: 2.0, color: Colors.green),
                ),
                child: Column(
                  children: [
                    const Text("Select reminder"),
                    Container(
                      decoration: const BoxDecoration(
                        border: Border(
                          top: BorderSide(color: Colors.green, width: 1.0),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(child: dateReminderBuilder()),
                          const SizedBox(width: 2.0),
                          Expanded(child: timeReminderBuilder()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              Row(
                children: [
                  Expanded(child: startedWithPlantsBuilder()),
                  const SizedBox(width: 10.0),
                  Expanded(child: reminderWithPlantsBuilder()),
                ],
              ),
              const SizedBox(height: 10.0),
              timesWateredBuilder(),
              const SizedBox(height: 10.0),
              timesWeededBuilder()
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
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w400,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue, width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          labelText: 'Plant\'s Name',
          labelStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
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
          hintStyle: const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w400,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue, width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          labelText: 'Plant\'s Description',
          labelStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        style: const TextStyle(color: Colors.black, fontSize: 18),
        validator: (description) => description != null && description.isEmpty
            ? 'The description cannot be empty'
            : null,
        onChanged: onChangedDescription,
      );

  Widget dateReminderBuilder() {
    return Column(
      children: [
        const Text("Date"),
        TextButton.icon(
          label: Text(
            DateFormat.yMMMd().format(dateReminder!),
            style: const TextStyle(color: Colors.green),
          ),
          icon: const Icon(Icons.calendar_month, color: Colors.green),
          onPressed: () async {
            final currentDate = DateTime.now();
            final selected = await showDatePicker(
              context: Get.context!,
              initialDate: currentDate,
              firstDate: currentDate,
              lastDate: DateTime(currentDate.year + 10),
            );

            if (selected != null) {
              onChangeddateReminder(selected);
            }
          },
        ),
      ],
    );
  }

  Widget timeReminderBuilder() {
    return Column(
      children: [
        const Text("Time"),
        TextButton.icon(
          label: Text(timeReminder!.format(Get.context!),
              style: const TextStyle(color: Colors.green)),
          icon: const Icon(Icons.timelapse, color: Colors.green),
          onPressed: () async {
            final selected = await showTimePicker(
              builder: (context, childWidget) => MediaQuery(
                data: MediaQuery.of(context)
                    .copyWith(alwaysUse24HourFormat: true),
                child: childWidget!,
              ),
              initialTime: timeReminder!,
              context: Get.context!,
            );

            if (selected != null) {
              onChangedtimeReminder(selected);
            }
          },
        ),
      ],
    );
  }

  Widget timesWateredBuilder() => Column(
        children: [
          const Text("Number of times watered today"),
          Container(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
              border: Border.all(width: 2.0, color: Colors.green),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    var number = numberWatered! - 1;
                    onChangednumberWatered(number);
                  },
                  icon: const Icon(Icons.remove),
                ),
                Expanded(
                    child: Center(
                        child: Text(
                  numberWatered.toString(),
                  style: const TextStyle(color: Colors.green, fontSize: 24),
                ))),
                IconButton(
                  onPressed: () {
                    int number = numberWatered! + 1;
                    onChangednumberWatered(number);
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ),
        ],
      );

  Widget timesWeededBuilder() => Column(
        children: [
          const Text("Number of times weeded so far"),
          Container(
            decoration: BoxDecoration(
              border: Border.all(width: 2.0, color: Colors.green),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10.0),
                bottomRight: Radius.circular(10.0),
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0),
              ),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: () {
                    var number = numberWeeded! - 1;
                    onChangednumberWeeded(number);
                  },
                  icon: const Icon(Icons.remove),
                ),
                Expanded(
                    child: Center(
                        child: Text(
                  numberWeeded.toString(),
                  style: const TextStyle(color: Colors.green, fontSize: 24),
                ))),
                IconButton(
                  onPressed: () {
                    int number = numberWeeded! + 1;
                    onChangednumberWeeded(number);
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ),
        ],
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
          hintText: 'Plants started with',
          hintStyle:const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w400,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue, width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          labelText: 'Plants started with',
          labelStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        validator: (startedPlants) =>
            startedPlants != null && startedPlants.isEmpty
                ? 'cannot be empty'
                : null,
        onChanged: (val) {
          final number = int.parse(val);
          onChangedstartedPlants(number);
        },
        keyboardType:const TextInputType.numberWithOptions(),
      );

  Widget reminderWithPlantsBuilder() => TextFormField(
        maxLines: 1,
        keyboardType:const TextInputType.numberWithOptions(),
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
          hintText: 'Plants left',
          hintStyle:const TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.w400,
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue, width: 1.0),
            borderRadius: BorderRadius.circular(10.0),
          ),
          labelText: 'Plants left',
          labelStyle: const TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontWeight: FontWeight.w400,
          ),
        ),
        validator: (leftPlants) =>
            leftPlants != null && leftPlants.isEmpty ? 'cannot be empty' : null,
        onChanged: (val) {
          final number = int.parse(val);
          onChangedleftPlants(number);
        },
      );
}
