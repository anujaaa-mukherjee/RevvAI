import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:revvai/login/auth_methods.dart';
import 'package:revvai/login/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController phoneController = TextEditingController();
  AuthMethods auth = AuthMethods();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              ClipOval(
                child: SizedBox(
                  width: 60.0,
                  height: 60.0,
                  child: Image.asset(
                    'assets/images/revv.png',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 8.0),
              const Text(''),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Hey!',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppin'),
                ),
                const SizedBox(height: 1.0),
                const Text(
                  "Let's Get Started.",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppin'),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Please enter your mobile number to Login and begin revision!',
                  style: TextStyle(fontSize: 15, fontFamily: 'Poppin'),
                ),
                const SizedBox(height: 30),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Mobile Number',
                    style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppin'),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  maxLength: 10,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 12.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                      borderSide:
                          const BorderSide(color: Colors.blue, width: 1.0),
                    ),
                    hintText: 'Enter your mobile number',
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () async {
                      print(phoneController.text);
                      final data = await FirebaseFirestore.instance
                          .collection("users")
                          .where(
                            "mobileNumber",
                            isEqualTo: "+91${phoneController.text}",
                          )
                          .get();
                      if (!context.mounted) return;
                      if (data.docs.isEmpty) {
                        return showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  title: const Text("Not a member"),
                                  content: const Text(
                                      "You do not have an account.\n Please Register first to enter app."),
                                  actions: <Widget>[
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                        phoneController.clear();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: ((context) =>
                                                const WelcomeScreen()),
                                          ),
                                        );
                                      },
                                      child: Text("OK"),
                                    ),
                                  ],
                                ));
                      }else{
                        await auth.login(context, "+91${phoneController.text}");
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11),
                        side: const BorderSide(color: Colors.blue, width: 1.0),
                      ),
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      'Get OTP',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Or'),
                    SizedBox(width: 10),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  height: 40,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const WelcomeScreen()));
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(11),
                        side: const BorderSide(color: Colors.blue, width: 1.0),
                      ),
                    ),
                    child: const Text(
                      'Register Here',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
