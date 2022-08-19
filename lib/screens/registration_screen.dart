import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../data/data.dart';
import '../widget/widgets.dart';
import 'screens.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override

  Widget build(BuildContext context) {
    UserProvider authProvider = Get.find();

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
                  Image.asset("images/splash.png", width: 230, height: 120,),
                ],
              ),
            ),

            Container(
              height: 40,
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
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Padding(padding: const EdgeInsets.only(left: 10),
                  child: TextFormField(
                    controller: authProvider.name,
                    decoration:const InputDecoration(
                        hintStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none,
                        labelStyle: TextStyle(color: Colors.white),
                        labelText: "Name",
                        hintText: "eg: Pius Businge",
                        icon: Icon(Icons.person, color: Colors.white,)
                    ),
                  ),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Padding(padding:const  EdgeInsets.only(left: 10),
                  child: TextFormField(
                    controller: authProvider.email,
                    decoration: const InputDecoration(
                        hintStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none,
                        labelStyle: TextStyle(color: Colors.white),
                        labelText: "Email",
                        hintText: "busingepius@gmail.com",
                        icon: Icon(Icons.email, color: Colors.white,)
                    ),
                  ),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Padding(padding: const EdgeInsets.only(left: 10),
                  child: TextFormField(
                    controller: authProvider.phone,
                    decoration:const  InputDecoration(
                        hintStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none,
                        labelStyle: TextStyle(color: Colors.white),
                        labelText: "Email subscribers",
                        hintText: "first@gmail.com,second@gmail.com,third@gmail.com",
                        icon: Icon(Icons.list_alt_sharp, color: Colors.white,)
                    ),
                  ),),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(5)
                ),
                child: Padding(padding:const  EdgeInsets.only(left: 10),
                  child: TextFormField(
                    controller: authProvider.password,
                    decoration:const InputDecoration(
                        hintStyle: TextStyle(color: Colors.white),
                        border: InputBorder.none,
                        labelStyle: TextStyle(color: Colors.white),
                        labelText: "Password",
                        hintText: "at least 6 digits",
                        icon: Icon(Icons.lock, color: Colors.white,)
                    ),
                  ),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: GestureDetector(
                onTap: () async {
                  await authProvider.signUp();
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5)
                  ),
                  child:const Padding(padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Center(child: CustomText(text: "Register", color: Colors.white, size: 22,)),),
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 5.0),
              child: GestureDetector(
                onTap: (){
                  Get.to(()=> LoginScreen());
                },
                child: const Center(child: CustomText(text: "Login here", size: 20,color: Colors.white,)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
