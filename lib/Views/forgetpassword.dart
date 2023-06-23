// ignore: file_names
// ignore_for_file: unused_local_variable, unnecessary_import

import 'package:crudfb/Views/constent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  TextEditingController userEmailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Forgot Password'),
          // ignore: prefer_const_literals_to_create_immutables
          actions: [
            // ignore: prefer_const_constructors
            Icon(Icons.more_vert),
          ],
        ),
        // ignore: avoid_unnecessary_containers
        body: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                "assets/images/log.png",
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 40.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 32.0),
                child: Column(
                  children: [
                    TextFormField(
                      controller: userEmailController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        hintText: "Entr UserEmail",
                        labelText: "UserEmail",
                      ),
                    ),
                    const SizedBox(height: 60.0),
                    ElevatedButton(
                        onPressed: () async {
                          var forgetEmail = userEmailController.text.trim();
                          try {
                            await FirebaseAuth.instance
                                .sendPasswordResetEmail(email: forgetEmail)
                                .then((value) => {
                                      Navigator.pop(context),
                                      showToast("Send emali successfully")
                                    });
                          } on FirebaseException catch (e) {
                            showToast("Error $e");
                          }
                        },
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(
                            const Size(250, 50),
                          ),
                        ),
                        child: const Text(
                          "ForgetPassword",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
