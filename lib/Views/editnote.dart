// ignore_for_file: unused_local_variable

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crudfb/Views/constent.dart';
import 'package:crudfb/Views/home.dart';
import 'package:crudfb/Views/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditNoteScreen extends StatefulWidget {
  const EditNoteScreen({super.key});

  @override
  State<EditNoteScreen> createState() => _EditNoteScreenState();
}

class _EditNoteScreenState extends State<EditNoteScreen> {
  TextEditingController noteController = TextEditingController();

  User? userId = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Edit Notes"),
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
              controller: noteController
                ..text = Get.arguments['note'].toString(),
              maxLines: null,
              decoration: const InputDecoration(hintText: "Add Text"),
            ),
            ElevatedButton(
                onPressed: () {
                  var note = noteController.text.trim();
                  if (note != "") {
                    try {
                      FirebaseFirestore.instance
                          .collection("Notes")
                          .doc(Get.arguments['docId'].toString())
                          .update({
                        "note": noteController.text.trim(),
                      }).then((value) => {
                                Get.off(() => const HomeScreen()),
                                showToast("Data Updata successfully"),
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
