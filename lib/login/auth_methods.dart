import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:revvai/login/otp_screen.dart';

class AuthMethods {
  final auth = FirebaseFirestore.instance;

  login(context, number) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException ex) {},
        codeSent: (String verificationid, int? resendtoken) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OtpScreen(
                        verificationid: verificationid,
                        register: false,
                        name: "",
                        age: 0,
                        selectedClass: "",
                        selectedExam: "",
                        gender: "",
                        mobileNumber: "",
                        email: "",
                      )));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        phoneNumber: number);
  }

  register(
    context,
    String name,
    int age,
    String gender,
    String selectedClass,
    String selectedExam,
    String mobileNumber,
    String email,
  ) async {
    final data = await auth
        .collection("user")
        .where(
          "MobileNumber",
          isEqualTo: mobileNumber,
        )
        .get();

    if (data.docs.isNotEmpty) {
      return showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text("Account Already Exist"),
                content: const Text(
                    "An Account Already exists with this mobile number.\n Please Login to enter the app."),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: Text("OK"),
                  ),
                ],
              ));
    } else {
      try {
        await FirebaseAuth.instance.verifyPhoneNumber(
        verificationCompleted: (PhoneAuthCredential credential) {},
        verificationFailed: (FirebaseAuthException ex) {},
        codeSent: (String verificationid, int? resendtoken) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => OtpScreen(
                        verificationid: verificationid,
                        register: true,
                        name: name,
                        age: age,
                        selectedClass: selectedClass,
                        selectedExam: selectedExam,
                        gender: gender,
                        mobileNumber: mobileNumber,
                        email: email,
                      )));
        },
        codeAutoRetrievalTimeout: (String verificationId) {},
        phoneNumber: mobileNumber);
      } catch (e) {
        return showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text("Unkown Error"),
                  content: Text("Error Message $e."),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: const Text("OK"),
                    ),
                  ],
                ));
      }
    }
  }
}
