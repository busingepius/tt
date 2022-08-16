import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:plant/data/data.dart';
import 'package:plant/screens/nav_screen.dart';

import '../data/image.dart';
import '../data/sql.dart';
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

  late bool completed;
  late bool watering;
  late bool weeding;
  late bool sowing;
  late bool nurseryBed;
  late bool mulching;
  late bool potting;
  late bool gapFiling;
  late bool spraying;
  late bool fertilizing;
  late bool thinning;
  late bool pruning;

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
    completed = widget.plant?.completed ?? false;
    watering = widget.plant?.watering ?? false;
    weeding = widget.plant?.weeding ?? false;
    sowing = widget.plant?.sowing ?? false;
    nurseryBed = widget.plant?.nurseryBed ?? false;
    mulching = widget.plant?.mulching ?? false;
    potting = widget.plant?.potting ?? false;
    gapFiling = widget.plant?.gapFiling ?? false;
    spraying = widget.plant?.spraying ?? false;
    fertilizing = widget.plant?.fertilizing ?? false;
    thinning = widget.plant?.thinning ?? false;
    pruning = widget.plant?.pruning ?? false;
    dateReminder = widget.plant?.dateReminder ?? DateTime.now();
    timeReminder = widget.plant?.timeReminder ?? TimeOfDay.now();
    numberWatered = widget.plant?.numberWatered ?? 0;
    numberWeeded = widget.plant?.numberWeeded ?? 0;
    startedPlants = widget.plant?.startedPlants ?? 0;
    leftPlants = widget.plant?.leftPlants ?? 0;
  }

  bool noPicture = true;

  FilePickerResult? result;
  String? _fileName;
  // PlatformFile? pickedfile;
  bool isLoading = false;
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
        _fileName = result!.files.single.name;
        // pickedfile = result!.files.first;
        pickedfile = File(result!.files.single.path.toString());
        setState(() {
          String imgString =
              Utility.base64String(pickedfile!.readAsBytesSync());
          image = imgString;
          print(image);
          noPicture = false;
        });
      } else {
        setState(() {
          noPicture = true;
        });
      }
    } catch (e) {
      print("Error eccurred");
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          elevation: 0.0,
          actionsIconTheme: const IconThemeData(color: Colors.white),
          actions: [
            buildButton(),
            const SizedBox(
              width: 2.0,
            ),
            noPicture && image == ""
                ? const SizedBox.shrink()
                : isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : IconButton(
                        icon: const Icon(Icons.add_a_photo),
                        iconSize: 30.0,
                        onPressed: pickFile,
                        color: Colors.white,
                        // containerColor: Color.fromARGB(255, 255, 255, 255),
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
                        // boxShadow: [ BoxShadow(blurRadius: 40.0)],
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
                            // color: containerColor,
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.add_a_photo),
                            iconSize: 30.0,
                            onPressed: pickFile,
                            color: Colors.red,
                            // containerColor: Color.fromARGB(255, 255, 255, 255),
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
                              // height: 400.0,
                              // width: 200.0,
                            ),
                          ),
                        )
                      // isLoading
                      // ? const CircularProgressIndicator(color: Colors.white)
                      : Center(
                          child: AspectRatio(
                            aspectRatio: 1.0,
                            child: Image.file(
                              pickedfile!,
                              fit: BoxFit.cover,
                              // height: 400.0,
                              // width: 200.0,
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

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      'Plant Care',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                  SwitchListTile(
                    title: const Text('Watering'),
                    subtitle: Text(
                      watering ? "Enabled" : "Disabled",
                    ),
                    activeColor: Colors.green,
                    secondary: Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Color(0xFFF3F5F7),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          )),
                      child: const Icon(Icons.auto_stories_outlined),
                    ),
                    value: watering,
                    onChanged: (bool val) => setState(() => watering = val),
                  ),
                  SwitchListTile(
                    title: Text('Weeding '),
                    subtitle: Text(
                      weeding ? "Enabled" : "Disabled",
                    ),
                    activeColor: Colors.green,
                    secondary: Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Color(0xFFF3F5F7),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          )),
                      child: const Icon(Icons.auto_stories_outlined),
                    ),
                    value: weeding,
                    onChanged: (bool val) => setState(() => weeding = val),
                  ),
                  SwitchListTile(
                    title: Text('Sowing '),
                    subtitle: Text(
                      sowing ? "Enabled" : "Disabled",
                    ),
                    activeColor: Colors.green,
                    secondary: Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Color(0xFFF3F5F7),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          )),
                      child: const Icon(Icons.auto_stories_outlined),
                    ),
                    value: sowing,
                    onChanged: (bool val) => setState(() => sowing = val),
                  ),
                  SwitchListTile(
                    title: Text('Nursery work '),
                    subtitle: Text(
                      nurseryBed ? "Enabled" : "Disabled",
                    ),
                    activeColor: Colors.green,
                    secondary: Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Color(0xFFF3F5F7),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                            topLeft: Radius.circular(10.0),
                            topRight: Radius.circular(10.0),
                          )),
                      child: const Icon(Icons.auto_stories_outlined),
                    ),
                    value: nurseryBed,
                    onChanged: (bool val) => setState(() => nurseryBed = val),
                  ),
                  SwitchListTile(
                    title: Text('Mulching '),
                    subtitle: Text(
                      mulching ? "Enabled" : "Disabled",
                    ),
                    activeColor: Colors.green,
                    secondary: Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color(0xFFF3F5F7),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0),
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                      ),
                      child: const Icon(Icons.bookmark),
                    ),
                    value: mulching,
                    onChanged: (bool val) => setState(() => mulching = val),
                  ),
                  SwitchListTile(
                    title: Text('Potting '),
                    subtitle: Text(
                      potting ? "Enabled" : "Disabled",
                    ),
                    activeColor: Colors.green,
                    secondary: Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color(0xFFF3F5F7),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0),
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                      ),
                      child: const Icon(Icons.bookmark),
                    ),
                    value: potting,
                    onChanged: (bool val) => setState(() => potting = val),
                  ),
                  SwitchListTile(
                    title: Text('Gap filing '),
                    subtitle: Text(
                      gapFiling ? "Enabled" : "Disabled",
                    ),
                    activeColor: Colors.green,
                    secondary: Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color(0xFFF3F5F7),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0),
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                      ),
                      child: const Icon(Icons.bookmark),
                    ),
                    value: gapFiling,
                    onChanged: (bool val) => setState(() => gapFiling = val),
                  ),
                  SwitchListTile(
                    title: Text('Spraying '),
                    subtitle: Text(
                      spraying ? "Enabled" : "Disabled",
                    ),
                    activeColor: Colors.green,
                    secondary: Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color(0xFFF3F5F7),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0),
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                      ),
                      child: const Icon(Icons.bookmark),
                    ),
                    value: spraying,
                    onChanged: (bool val) => setState(() => spraying = val),
                  ),
                  SwitchListTile(
                    title: Text('Fertilizing '),
                    subtitle: Text(
                      fertilizing ? "Enabled" : "Disabled",
                    ),
                    activeColor: Colors.green,
                    secondary: Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color(0xFFF3F5F7),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0),
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                      ),
                      child: const Icon(Icons.bookmark),
                    ),
                    value: fertilizing,
                    onChanged: (bool val) => setState(() => fertilizing = val),
                  ),
                  SwitchListTile(
                    title: const Text('Thining '),
                    subtitle: Text(
                      thinning ? "Enabled" : "Disabled",
                    ),
                    activeColor: Colors.green,
                    secondary: Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color(0xFFF3F5F7),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0),
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                      ),
                      child: const Icon(Icons.bookmark),
                    ),
                    value: thinning,
                    onChanged: (bool val) => setState(() => thinning = val),
                  ),
                  SwitchListTile(
                    title: Text('Pruning '),
                    subtitle: Text(
                      pruning ? "Enabled" : "Disabled",
                    ),
                    activeColor: Colors.green,
                    secondary: Container(
                      height: 50.0,
                      width: 50.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color(0xFFF3F5F7),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10.0),
                          bottomRight: Radius.circular(10.0),
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                      ),
                      child: const Icon(Icons.bookmark),
                    ),
                    value: pruning,
                    onChanged: (bool val) => setState(() => pruning = val),
                  )
                ],
              ),
              // buildButton(),
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
      final isUpdating = widget.plant != null;

      if (isUpdating) {
        await updatePlant();
      } else {
        await addPlant();
      }

      Get.offAll(const NavScreen());
    }
  }

  Future updatePlant() async {
    final plant = widget.plant!.copy(
      title: title,
      description: description,
      image: image,
      completed: completed,
      watering: watering,
      weeding: weeding,
      sowing: sowing,
      nurseryBed: nurseryBed,
      mulching: mulching,
      potting: potting,
      gapFiling: gapFiling,
      spraying: spraying,
      fertilizing: fertilizing,
      thinning: thinning,
      pruning: pruning,
      dateReminder: dateReminder,
      leftPlants: leftPlants,
      numberWatered: numberWatered,
      numberWeeded: numberWeeded,
      startedPlants: startedPlants,
      timeReminder: timeReminder,
    );

    await PlantDatabase.instance.update(plant);
  }

  Future addPlant() async {
    final plant = PlantModel(
      title: title,
      description: description,
      image: image,
      createdTime: DateTime.now(),
      completed: completed,
      watering: watering,
      weeding: weeding,
      sowing: sowing,
      nurseryBed: nurseryBed,
      mulching: mulching,
      potting: potting,
      gapFiling: gapFiling,
      spraying: spraying,
      fertilizing: fertilizing,
      thinning: thinning,
      pruning: pruning,
      dateReminder: dateReminder,
      leftPlants: leftPlants,
      numberWatered: numberWatered,
      numberWeeded: numberWeeded,
      startedPlants: startedPlants,
      timeReminder: timeReminder,
    );

    await PlantDatabase.instance.create(plant);
    await Database().addPlant(plant);
  }
}
