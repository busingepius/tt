import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:plant/data/data.dart';

import '../models/user_model.dart';
import '../screens/screens.dart';
import '../services/user_services.dart';

class UserProvider extends GetxController {
  Rx<UserServices> userServices = UserServices().obs;
  final formkey = GlobalKey<FormState>();

  updateUserData(Map<String, dynamic> data) async {
    userServices.value.updateUserData(data);
  }

  late Rx<User?> firebaseUser;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController phone = TextEditingController();
  Rx<UserModel> userModel = UserModel().obs;

  @override
  void onReady() {
    super.onReady();
    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);
  }

  _setInitialScreen(User? user) async {
    if (user == null) {
      Get.offAll(() => LoginScreen());
    } else {
      userModel.value = await userServices.value.getUserById(user.uid);
      Get.offAll(() => const NavScreen());
    }
  }

  Future<void> signIn() async {
    try {
      await auth
          .signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      )
          .then((result) {
        clearController();
        Get.snackbar("Success", "signed in successfully");
      }).timeout(const Duration(seconds: 30), onTimeout: () {
        Get.snackbar("Failure", "signed in failed");
      });
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar("Sign In Failed", "Try again");
    }
  }

  Future<void> signUp() async {
    try {
      await auth
          .createUserWithEmailAndPassword(
              email: email.text.trim(), password: password.text.trim())
          .then((result) async {
        userServices.value.createUser(
          id: result.user!.uid,
          name: name.text.trim(),
          email: email.text.trim(),
          phone: phone.text.trim(),
        );
        clearController();
        Get.snackbar("Sign Up Success", "Signed up successfully");
      }).timeout(const Duration(seconds: 30), onTimeout: () {
        Get.snackbar("Sign Up Failed", "Try again later");
      });
    } catch (e) {
      debugPrint(e.toString());
      Get.snackbar("Sign Up Failed", "Try again later");
    }
  }

  Future<void> signOut() async {
    try {
      auth.signOut().then((result) {
        clearController();
        Get.snackbar("Success", "Logged out successfully");
      }).timeout(const Duration(seconds: 30), onTimeout: () {
        Get.snackbar("Failure", "logout failed");
      });
    } catch (e) {
      Get.snackbar("Sign Out Failed", "Try again");
    }
  }

  void clearController() {
    name.text = "";
    password.text = "";
    email.text = "";
    phone.text = "";
  }
}
