import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:revvai/initial_screen.dart';
import 'package:revvai/login/login_screen.dart';

class AuthStateCkeck extends StatefulWidget {
  const AuthStateCkeck({super.key});

  @override
  State<AuthStateCkeck> createState() => _AuthStateCkeckState();
}

class _AuthStateCkeckState extends State<AuthStateCkeck> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const InitialScreen(newRegister: false,);
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
