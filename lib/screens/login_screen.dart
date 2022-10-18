import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../data/data.dart';
import '../widget/widgets.dart';
import 'screens.dart';

class LoginScreen extends StatelessWidget {
  final UserProvider authProvider = Get.find();

   LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.green,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.white,
              height: 100,
            ),
            Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "images/splash.png",
                    width: 230,
                    height: 230,
                  ),
                ],
              ),
            ),
            Container(
              height: 60,
              color: Colors.white,
            ),
           const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: TextFormField(
                    controller: authProvider.email,
                    
                    decoration:const InputDecoration(
                        hintStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none,
                        hintText: "Email",
                        icon: Icon(
                          Icons.email,
                          color: Colors.white,
                        )),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: TextFormField(
                    controller: authProvider.password,
                    decoration: const InputDecoration(
                        hintStyle: TextStyle(color:Colors. white),
                        border: InputBorder.none,
                        hintText: "Password",
                        icon: Icon(
                          Icons.lock,
                          color: Colors.white,
                        )),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: GestureDetector(
                onTap: () async {
                  await authProvider.signIn();
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5)),
                  child:const Padding(
                    padding:  EdgeInsets.only(top: 10, bottom: 10),
                    child: Center(
                      child: CustomText(
                        text: "Login",
                        color: Colors.white,
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
              child: GestureDetector(
                onTap: () {
                  Get.to(()=>const RegistrationScreen());
                },
                child: const Center(
                  child: CustomText(
                    text: "Register here",
                    size: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
