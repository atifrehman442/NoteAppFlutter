// ignore_for_file: unnecessary_null_comparison, unused_local_variable, depend_on_referenced_packages

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crudfb/Views/constent.dart';
import 'package:crudfb/Views/createnote.dart';
import 'package:crudfb/Views/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'editnote.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? userId = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text("Home"),
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
      body: Container(
        color: Colors.black,
        child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("Notes")
                .where("userId", isEqualTo: userId!.uid)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return showToast("Something went wrong");
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              }
              if (snapshot.data!.docs.isEmpty) {
                return const Center(child: Text("No Data Available"));
              }
              if (snapshot != null && snapshot.data != null) {
                return Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    color: const Color.fromARGB(255, 96, 185, 226),
                  ),
                  padding: const EdgeInsets.all(10),
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var notes = snapshot.data!.docs[index]['note'];
                        final Timestamp timestamp =
                            snapshot.data!.docs[index]['createAt'];
                        final DateTime dateTime = timestamp.toDate();
                        String date = DateFormat('dd/MM/yyyy').format(dateTime);
                        var docId = snapshot.data!.docs[index].id;
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(60),
                            color: Colors.white,
                            border: Border.all(
                                color: Colors.black,
                                width: 1.0,
                                style: BorderStyle.solid),
                          ),
                          padding: const EdgeInsets.only(left: 30, top: 10),
                          child: ListTile(
                            title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Text(notes,
                                  //     style: const TextStyle(
                                  //         fontWeight: FontWeight.bold)),
                                  // const SizedBox(height: 20.0),
                                  Text(notes,
                                      style: const TextStyle(fontSize: 15)),
                                ]),
                            subtitle: Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Text(date,
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(fontSize: 10)),
                            ),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const SizedBox(width: 20.0),
                                GestureDetector(
                                    onTap: () {
                                      Get.to(() => const EditNoteScreen(),
                                          arguments: {
                                            'note': notes,
                                            'docId': docId
                                          });
                                    },
                                    child: const Icon(Icons.edit)),
                                const SizedBox(width: 10.0),
                                GestureDetector(
                                    onTap: () {
                                      FirebaseFirestore.instance
                                          .collection("Notes")
                                          .doc(docId)
                                          .delete();
                                    },
                                    child: const Icon(Icons.delete)),
                              ],
                            ),
                          ),
                        );
                      }),
                );
              }
              return Container();
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const CreateNotesScreen()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
