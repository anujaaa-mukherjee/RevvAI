import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Data {
  int age;
  String name;
  String gender;
  String mobileNumber;
  String email;
  String selectedClass;
  String selectedExam;

  Data({
    required this.name,
    required this.gender,
    required this.email,
    required this.mobileNumber,
    required this.age,
    required this.selectedClass,
    required this.selectedExam,
  });
}

class AppProvider extends ChangeNotifier {
  // ignore: prefer_final_fields
  Data _data = Data(
    name: "",
    gender: "",
    email: "",
    mobileNumber: "",
    age: 0,
    selectedClass: "",
    selectedExam: "",
  );

  Data get data => _data;
  User? user = FirebaseAuth.instance.currentUser;

  fetchData() async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get();

    if (documentSnapshot.exists) {
      Map<String, dynamic> docData =
          documentSnapshot.data() as Map<String, dynamic>;

      _data.age = docData["age"];
      _data.name = docData["name"];
      _data.gender = docData["gender"];
      _data.selectedExam = docData["selectedExam"];
      _data.selectedClass = docData["selectedClass"];
      _data.mobileNumber = docData["mobileNumber"];
      _data.email = docData["email"];
    }
    notifyListeners();
  }
}
