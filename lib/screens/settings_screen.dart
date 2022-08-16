import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../data/data.dart';

class Settings extends StatefulWidget {
  Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool reminder = true;
  bool isLight = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
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
      body: SingleChildScrollView(
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
                      onChanged: (val) {
                        setState(() {
                          reminder = val;
                          if (!reminder) {
                            Get.snackbar("Set reminders",
                                "Please allow notifications generally");
                          }
                        });
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
                    style: Theme.of(context).textTheme.headline6,
                    // TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                ),
                // SwitchListTile(
                //   title: const Text('Dark Theme'),
                //   activeColor: Colors.green,
                //   value: isLight,
                //   onChanged: (bool val) => val
                //       ? Get.changeTheme(ThemeData.light())
                //       : Get.changeTheme(ThemeData.light()),
                // ),

                // const Divider(height: 2.0, indent: 15.0, endIndent: 15.0),
                ListTile(
                  title: const Text("Language"),
                  trailing: const Icon(Icons.arrow_forward_ios_outlined),
                  enabled: true,
                  onTap: () => Get.snackbar(
                      "Language", "ENGLISH is the default language"),
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
                  onTap: () =>
                      Get.snackbar("Logout", "Logged out successfully"),
                ),
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
                    middleText: "We know you ",
                  ),
                ),
                const Divider(height: 2.0, indent: 15.0, endIndent: 15.0),
                ListTile(
                  title: const Text("Contact us"),
                  trailing: const Icon(Icons.arrow_forward_ios_outlined),
                  enabled: true,
                  onTap: () async => await Database().contactUs(),
                ),
                const Divider(height: 2.0, indent: 15.0, endIndent: 15.0),
                ListTile(
                  title: const Text("Report a Bug"),
                  trailing: const Icon(Icons.arrow_forward_ios_outlined),
                  enabled: true,
                  onTap: () async => await Database().reportBug(),
                ),
                const Divider(height: 2.0, indent: 15.0, endIndent: 15.0),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ListTile(
                    // leading: Icon(Icons.copyright),
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
    );
  }
}
