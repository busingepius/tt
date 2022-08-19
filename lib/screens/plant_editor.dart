import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant/data/data.dart';
import '../models/models.dart';
import '../widget/form.dart';

class AddEditPlantPage extends StatefulWidget {
  final PlantModel? plant;

  const AddEditPlantPage({
    Key? key,
    this.plant,
  }) : super(key: key);
  @override
  State<AddEditPlantPage> createState() => _AddEditPlantPageState();
}

class _AddEditPlantPageState extends State<AddEditPlantPage> {
  final _formKey = GlobalKey<FormState>();

  late String title;
  late String description;
  late String image;

  late DateTime dateReminder;
  late TimeOfDay timeReminder;
  late int numberWatered;
  late int numberWeeded;
  late int startedPlants;
  late int leftPlants;

  @override
  void initState() {
    super.initState();

    title = widget.plant?.title ?? '';
    description = widget.plant?.description ?? '';
    image = widget.plant?.image ?? '';
    dateReminder = widget.plant?.dateReminder ?? DateTime.now();
    timeReminder = widget.plant?.timeReminder ?? TimeOfDay.now();
    numberWatered = widget.plant?.numberWatered ?? 0;
    numberWeeded = widget.plant?.numberWeeded ?? 0;
    startedPlants = widget.plant?.startedPlants ?? 0;
    leftPlants = widget.plant?.leftPlants ?? 0;
  }

  bool noPicture = true;

  FilePickerResult? result;
  bool isLoading = false;
  bool isPressed = false;
  File? pickedfile;

  void pickFile() async {
    try {
      setState(() {
        isLoading = true;
      });
      result = await FilePicker.platform.pickFiles(
        type: FileType.image,
        allowMultiple: false,
      );
      setState(() {
        isLoading = false;
      });
      if (result != null) {
        pickedfile = File(result!.files.single.path.toString());
        setState(() {
          String imgString =
              Utility.base64String(pickedfile!.readAsBytesSync());
          image = imgString;
          noPicture = false;
        });
      } else {
        setState(() {
          noPicture = true;
        });
      }
    } catch (e) {
      Get.snackbar("Failed", "Try again later");
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          elevation: 0.0,
          actionsIconTheme: const IconThemeData(color: Colors.white),
          actions: isPressed
              ? [
                  const Center(
                      child: CircularProgressIndicator(color: Colors.white)),
                  const SizedBox(width: 10.0),
                ]
              : [
                  buildButton(),
                  const SizedBox(width: 2.0),
                  noPicture && image == ""
                      ? const SizedBox.shrink()
                      : IconButton(
                          icon: const Icon(Icons.add_a_photo),
                          iconSize: 30.0,
                          onPressed: pickFile,
                          color: Colors.white,
                        ),
                ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              noPicture && image == ""
                  ? Container(
                      height: 200.0,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.elliptical(
                            MediaQuery.of(context).size.width,
                            200.0,
                          ),
                        ),
                      ),
                      child: Center(
                        child: Container(
                          height: 50.0,
                          width: 50.0,
                          margin: const EdgeInsets.all(6.0),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.add_a_photo),
                            iconSize: 30.0,
                            onPressed: pickFile,
                            color: Colors.red,
                          ),
                        ),
                      ),
                    )
                  : image != ""
                      ? Center(
                          child: AspectRatio(
                            aspectRatio: 1.0,
                            child: Image.memory(
                              Utility.dataFromBase64String(image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      : Center(
                          child: AspectRatio(
                            aspectRatio: 1.0,
                            child: Image.file(
                              pickedfile!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
              Form(
                key: _formKey,
                child: PlantFormWidget(
                  title: title,
                  image: image,
                  description: description,
                  dateReminder: dateReminder,
                  timeReminder: timeReminder,
                  numberWatered: numberWatered,
                  numberWeeded: numberWeeded,
                  startedPlants: startedPlants,
                  leftPlants: leftPlants,
                  onChangedTitle: (title) => setState(() => this.title = title),
                  onChangeddateReminder: (dateReminder) =>
                      setState(() => this.dateReminder = dateReminder),
                  onChangedtimeReminder: (timeReminder) =>
                      setState(() => this.timeReminder = timeReminder),
                  onChangednumberWatered: (numberWatered) =>
                      setState(() => this.numberWatered = numberWatered),
                  onChangednumberWeeded: (numberWeeded) =>
                      setState(() => this.numberWeeded = numberWeeded),
                  onChangedstartedPlants: (startedPlants) =>
                      setState(() => this.startedPlants = startedPlants),
                  onChangedleftPlants: (leftPlants) =>
                      setState(() => this.leftPlants = leftPlants),
                  onChangedDescription: (description) =>
                      setState(() => this.description = description),
                ),
              ),
            ],
          ),
        ),
      );

  Widget buildButton() {
    final isFormValid = title.isNotEmpty && description.isNotEmpty;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: OutlinedButton.icon(
          onPressed: addOrUpdatePlant,
          icon: const Icon(
            Icons.save_as_outlined,
            color: Colors.white,
          ),
          style: ElevatedButton.styleFrom(
            onPrimary: Colors.white,
            primary: isFormValid ? null : Colors.grey.shade700,
          ),
          label: const Text(
            "Save",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  void addOrUpdatePlant() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      setState(() {
        isPressed = true;
      });
      final isUpdating = widget.plant != null;

      if (isUpdating) {
        await updatePlant();
      } else {
        await addPlant();
      }
    }
  }

  Future updatePlant() async {
    final plant = widget.plant!.copy(
      title: title,
      description: description,
      image: image,
      dateReminder: dateReminder,
      leftPlants: leftPlants,
      numberWatered: numberWatered,
      numberWeeded: numberWeeded,
      startedPlants: startedPlants,
      timeReminder: timeReminder,
    );

    await PlantDatabase.instance.update(plant);

    await FirebaseDatabase().updatePlant(plant);
  }

  Future addPlant() async {
    final plant = PlantModel(
      title: title,
      description: description,
      image: image,
      createdTime: DateTime.now(),
      dateReminder: dateReminder,
      leftPlants: leftPlants,
      numberWatered: numberWatered,
      numberWeeded: numberWeeded,
      startedPlants: startedPlants,
      timeReminder: timeReminder,
    );

    await PlantDatabase.instance.create(plant);
  }
}
