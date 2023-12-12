// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:bdtok_prac/model/user.dart';
import 'package:bdtok_prac/view/screens/auth/login_screen.dart';
import 'package:bdtok_prac/view/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  File? proPic;

  selectPropic() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final img = File(image.path);
    proPic = img;
  }

  // Logout Method
  logout()async{
    await FirebaseAuth.instance.signOut();
  }

  //User persistance goes here
  late Rx<User?> _user;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(FirebaseAuth.instance.currentUser);
    _user.bindStream(FirebaseAuth.instance.authStateChanges());
    ever(_user, setInitialScreen);
  }

  setInitialScreen(User? user){
    if(user == null){
      Get.offAll(()=> LoginScreen());

    }else{
      Get.offAll(()=> const HomeScreen());
    }
  }
  //Snackbar customized
  void snackbar(String title, String message, Color bgColor){
    Get.snackbar(title, message, colorText: Colors.white, backgroundColor: bgColor);
  }



  //Login Starts from here
  loginMethod(String email, String password) async {
    try{
      if(email.isNotEmpty && password.isNotEmpty){
      await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
        snackbar("Login Successful", "You are in the home page now", Colors.blue);
    }else{
      Get.snackbar("Login Failed", "Please fill all the fields");
    }
    }catch(e){
      Get.snackbar("Error Login", e.toString());
    }
  }

  //Signup Starts from here
  signup(String username, String email, File? image, String password) async {
    try {
      if (username.isNotEmpty && email.isNotEmpty && image != null) {
        UserCredential credential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        final String imageUrl = await uploadImage(image);

        MyUser user = MyUser(
            email: email,
            proPic: imageUrl,
            uid: FirebaseAuth.instance.currentUser!.uid,
            username: username);
        Get.snackbar("Registration Successful",
            "Your account has been created successfully",
            backgroundColor: Colors.blue, colorText: Colors.white);
      } else {
        Get.snackbar("Registration Failed", "Please fill all the feilds first",
            backgroundColor: Colors.red, colorText: Colors.white);
      }
    } catch (e) {
      print(e);
      Get.snackbar("Error", e.toString(),
          colorText: Colors.white, backgroundColor: Colors.red);
    }
  }

  Future<String> uploadImage(File image) async {
    Reference ref = FirebaseStorage.instance
        .ref()
        .child('prac')
        .child(FirebaseAuth.instance.currentUser!.uid);
    UploadTask uploadImage = ref.putFile(image);
    TaskSnapshot snapshot = await uploadImage;
    String imageDwnUrl = await snapshot.ref.getDownloadURL();
    return imageDwnUrl;
  }
}
