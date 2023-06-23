// ignore_for_file: unused_local_variable, unused_import

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crudfb/Views/constent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Views/home.dart';
import '../Views/login.dart';

signUpUser(String userName, String userPhone, String userEmail,
    String userPassword) async {
  User? userid = FirebaseAuth.instance.currentUser;
  try {
    FirebaseFirestore.instance.collection("users").doc(userid!.uid).set({
      'userName': userName,
      'userEmail': userEmail,
      'userPhone': userPhone,
      'createdAt': DateTime.now(),
      'userId': userid.uid,
    }).then((value) => {
          FirebaseAuth.instance.signOut(),
          Get.to(() => const LoginScreen()),
          showToast("Data Added successfully")
        });
  } on FirebaseAuthException catch (e) {
    showToast("Error $e");
  }
}

logInUser(String loginEmail, String loginPassword) async {
  try {
    final User? firebaseUser = (await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: loginEmail, password: loginPassword))
        .user;
    if (firebaseUser != null) {
      Get.to(() => const HomeScreen());
    } else {
      showToast("Check Email and Password");
    }
  } on FirebaseAuthException catch (e) {
    final errorMessage =
        jsonEncode(e.toString().replaceAll(RegExp(r'#[0-9]+\s+'), ''));
    showToast(errorMessage);
  }
}
