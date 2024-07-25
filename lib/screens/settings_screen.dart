import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/data.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool reminder = true;
  bool isLight = false;

  @override
  Widget build(BuildContext context) {
    // UserProvider userProvider = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
          style: TextStyle(color: Get.isDarkMode ? Colors.white : Colors.black),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        leading:
        BackButton(color: Get.isDarkMode ? Colors.white : Colors.black),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0, top: 10.0),
                    child: Text(
                      "Notifications Options",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  ListTile(
                    title: const Text("Reminder"),
                    trailing: Switch(
                        activeColor: Colors.green,
                        value: reminder,
                        onChanged: (val) async {
                          setState(() {
                            reminder = val;
                            if (!reminder) {
                              Get.snackbar(
                                "Notifications removed",
                                "Please allow notifications generally",
                              );
                            }
                          });
                          val == false
                              ? await PushNotifications().cancelNotifications()
                              : null;
                        }),
                  ),
                  const Divider(height: 2.0, indent: 15.0, endIndent: 15.0),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0, top: 10.0),
                    child: Text(
                      "Account",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  ListTile(
                    title: const Text("Language"),
                    trailing: const Icon(Icons.arrow_forward_ios_outlined),
                    enabled: true,
                    onTap: () => Get.snackbar(
                        "Language", "English is the default language"),
                  ),
                  const Divider(height: 2.0, indent: 15.0, endIndent: 15.0),
                  ListTile(
                    title: const Text("Upgrade Account"),
                    trailing: const Icon(Icons.arrow_forward_ios_outlined),
                    enabled: true,
                    onTap: () => Get.snackbar("Account",
                        "Your account is free and it will upgrade freely"),
                  ),
                  const Divider(height: 2.0, indent: 15.0, endIndent: 15.0),
                  ListTile(
                      title: const Text("Log out"),
                      trailing: const Icon(Icons.arrow_forward_ios_outlined),
                      enabled: true,
                      onTap: () async {
                        // await userProvider.signOut();
                      }),
                  const Divider(height: 2.0, indent: 15.0, endIndent: 15.0),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0, top: 10.0),
                    child: Text(
                      "App",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                  ),
                  ListTile(
                    title: const Text("App information"),
                    trailing: const Icon(Icons.arrow_forward_ios_outlined),
                    enabled: true,
                    onTap: () => Get.defaultDialog(
                      title: "App information",
                      middleText:
                      "This app is for all Ugandans who love the environment and wish to keep there plants happy through the reach of technology. Tree Tech is committed to improving the environment of all places through updates and timely control of the environment.",
                    ),
                  ),
                  const Divider(height: 2.0, indent: 15.0, endIndent: 15.0),
                  ListTile(
                    title: const Text("About us"),
                    trailing: const Icon(Icons.arrow_forward_ios_outlined),
                    enabled: true,
                    onTap: () => Get.defaultDialog(
                      title: "About us",
                      middleText:
                      "We are Gegabox Technologies, a Ugandan based organisation with love to benchmark ideas and solutions to better Ugandan livelihoods and the environment ",
                    ),
                  ),
                  const Divider(height: 2.0, indent: 15.0, endIndent: 15.0),
                  ListTile(
                    title: const Text("Contact us"),
                    trailing: const Icon(Icons.arrow_forward_ios_outlined),
                    enabled: true,
                    onTap: () {
                      print("1");
                    },
                  ),
                  const Divider(height: 2.0, indent: 15.0, endIndent: 15.0),
                  ListTile(
                    title: const Text("Report a Bug"),
                    trailing: const Icon(Icons.arrow_forward_ios_outlined),
                    enabled: true,
                    onTap: () {
                      print("2");
                    },
                  ),
                  const Divider(height: 2.0, indent: 15.0, endIndent: 15.0),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ListTile(
                      title: const Center(child: Text("tree Tech")),
                      subtitle: Center(
                          child:
                          Text("All rights reserved ${DateTime.now().year}")),
                      contentPadding: const EdgeInsets.only(left: 20.0),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}