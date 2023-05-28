import 'package:flutter/material.dart';
import 'package:treeTech/data/image.dart';

import '../models/models.dart';

class MyPlant extends StatelessWidget {
  final PlantModel? plant;
  const MyPlant({Key? key, required this.plant}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      width: 80.0,
      padding: const EdgeInsets.only(
          left: 10.0, right: 10.0, top: 10.0, bottom: 2.0),
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
        color: Color(0xFFF3F5F7),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            overflow: TextOverflow.ellipsis,
            softWrap: false,
            maxLines: 1,
            plant!.title,
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.green,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 3.0, bottom: 2.0),
            child: Text(
              overflow: TextOverflow.ellipsis,
              softWrap: false,
              maxLines: 1,
              plant!.description,
              style: const TextStyle(
                fontSize: 15.0,
                color: Colors.greenAccent,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Center(
            child: Container(
              height: 110.0,
              width: 150.0,
              decoration:  BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10.0),
                ),
                image: plant!.image == ""
                            ? const DecorationImage(
                                image: AssetImage(
                                  "images/splash.png",
                                ),
                                fit: BoxFit.cover,
                              )
                            : DecorationImage(
                  fit: BoxFit.cover,
                  image: MemoryImage(
                    Utility.dataFromBase64String(plant!.image)
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
