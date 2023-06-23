// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crudfb/Views/constent.dart';
import 'package:crudfb/Views/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateNotesScreen extends StatefulWidget {
  const CreateNotesScreen({super.key});

  @override
  State<CreateNotesScreen> createState() => _CreateNotesScreenState();
}

class _CreateNotesScreenState extends State<CreateNotesScreen> {
  TextEditingController noteController = TextEditingController();

  User? userId = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Create Notes"),
        actions: [
          GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
              Get.off(() => const LoginScreen());
            },
            child: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              controller: noteController,
              maxLines: null,
              decoration: const InputDecoration(hintText: "Add Text"),
            ),
            ElevatedButton(
                onPressed: () {
                  var note = noteController.text.trim();
                  if (note != "") {
                    try {
                      FirebaseFirestore.instance.collection("Notes").doc().set({
                        "createAt": DateTime.now(),
                        "note": note,
                        "userId": userId?.uid
                      });
                    } on FirebaseAuthException catch (e) {
                      final errorMessage = jsonEncode(
                          e.toString().replaceAll(RegExp(r'#[0-9]+\s+'), ''));
                      showToast(errorMessage);
                    }
                  } else {
                    showToast("Add Text");
                  }
                },
                child: const Text("Add Note")),
          ],
        ),
      ),
    );
  }
}
