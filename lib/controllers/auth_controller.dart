import 'package:flutter_application_6/consts/consts.dart';
import 'package:flutter_application_6/views/home_view/home.dart';
import 'package:flutter_application_6/views/login_view/login_view.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../views/appointment_view/appointment_view.dart';

class AuthController extends GetxController {
  var fullnameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  // doctor editing controllers
  var aboutController = TextEditingController();
  var addressController = TextEditingController();
  var servicesController = TextEditingController();
  var timingController = TextEditingController();
  var phoneController = TextEditingController();
  var categoryController = TextEditingController();
  UserCredential? userCredential;

  isUserAlreadyLoggedIn() async {
    await FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        var data = await FirebaseFirestore.instance
            .collection('doctors')
            .doc(user.uid)
            .get();
        var isDoc = data.data()?.containsKey('docName') ?? false;
        if (isDoc) {
          Get.offAll(() => const AppointmentView());
        } else {
          Get.offAll(() => const HOme());
        }
      } else {
        Get.offAll(() => const LoginView());
      }
    });
  }

  loginUser() async {
    userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
  }

  signupUser(bool isDoctor) async {
    userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text, password: passwordController.text);
    if (userCredential != null) {
      await storeUserData(userCredential!.user!.uid, fullnameController.text,
          emailController.text, isDoctor);
    }
  }

  storeUserData(
      String uid, String fullname, String email, bool isDoctor) async {
    var store = FirebaseFirestore.instance.collection(isDoctor ?'doctors': 'user').doc(uid);
    if (isDoctor) {
      await store.set({
        'docAbout': aboutController.text,
        'docAddress': addressController.text,
        'docCategory': categoryController.text,
        'docName': fullname,
        'docPhone': phoneController.text,
        'docService': servicesController,
        'docRating': 1,
        'docEmail': email,
      });
    }else{
      await store.set({
      'fullname': fullname,
      'email': email,
    });
    }
    
  }

  signout() async {
    await FirebaseAuth.instance.signOut();
  }
}
