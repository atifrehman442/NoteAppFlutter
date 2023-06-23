// ignore: file_names
// ignore_for_file: unused_local_variable, avoid_print, unused_field, unnecessary_null_comparison, unrelated_type_equality_checks

//import 'dart:math';


import 'package:crudfb/Services/signupservices.dart';
import 'package:crudfb/Views/constent.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController userPhoneController = TextEditingController();
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();

  User? currentUser = FirebaseAuth.instance.currentUser;

  late bool _passwordVisible;
  @override
  void initState() {
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('SignUp'),
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
                      controller: userNameController,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: "Enter user name",
                          labelText: "user name"),
                    ),
                    TextFormField(
                      controller: userPhoneController,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.phone),
                          hintText: "Enter phone number",
                          labelText: "phone number"),
                      keyboardType: TextInputType.number,
                    ),
                    TextFormField(
                      controller: userEmailController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.email),
                        hintText: "Entr Email",
                        labelText: "Email",
                      ),
                    ),
                    TextFormField(
                      obscureText: !_passwordVisible,
                      controller: userPasswordController,
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          onLongPress: () {
                            setState(() {
                              _passwordVisible = true;
                            });
                          },
                          onLongPressUp: () {
                            setState(() {
                              _passwordVisible = false;
                            });
                          },
                          child: Icon(_passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off),
                        ),
                        prefixIcon: const Icon(Icons.password),
                        hintText: "Entr Password",
                        labelText: "Password",
                      ),
                    ),
                    const SizedBox(height: 60.0),
                    ElevatedButton(
                        onPressed: () async {
                          var userName = userNameController.text.trim();
                          var userPhone = userPhoneController.text.trim();
                          var userEmail = userEmailController.text.trim();
                          var userPassword = userPasswordController.text.trim();
                          if (userName == "" &&
                              userPhone != "" &&
                              userEmail != "") {
                            await FirebaseAuth.instance
                                .createUserWithEmailAndPassword(
                                    email: userEmail, password: userPassword)
                                .then((value) => {
                                      print("user created"),
                                      signUpUser(userName, userPhone, userEmail,
                                          userPassword)
                                    });
                          } else {
                            showToast("this field is required");
                          }
                        },
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(
                            const Size(250, 50),
                          ),
                        ),
                        child: const Text(
                          "Signup",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 20.0),
              SizedBox(
                height: 50.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Allready have an account LogIn",
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
