// ignore: file_names
// ignore_for_file: unused_local_variable

import 'package:crudfb/Services/signupservices.dart';
import 'package:crudfb/Views/signup.dart';
import 'package:flutter/material.dart';


import 'forgetpassword.dart';
//import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userEmailController = TextEditingController();
  TextEditingController userPasswordController = TextEditingController();
  late bool _passwordVisible;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('LogIn'),
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
              const Text(
                "Wellcome to Login page",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 60.0,
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
                        onPressed: () {
                          var loginEmail = userEmailController.text.trim();
                          var loginPassword =
                              userPasswordController.text.trim();
                          logInUser(loginEmail, loginPassword);
                        },
                        style: ButtonStyle(
                          minimumSize: MaterialStateProperty.all(
                            const Size(250, 50),
                          ),
                        ),
                        child: const Text(
                          "login",
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
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                const ForgetPasswordScreen()));
                  },
                  child: const Text(
                    "Forgot Password",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 50.0,
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignupScreen()),
                    );
                  },
                  child: const Text(
                    "Don't have an account Signup",
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
