import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:revvai/registration_screen.dart';
import 'package:revvai/otp_screen.dart';
import 'package:revvai/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
          apiKey: "AIzaSyAJuN-EX4UNGY39es_kd-BKhtKFxiBRK80",
          appId: "1:554659430337:android:d7ddca3ff4701bb519f940",
          messagingSenderId: "554659430337",
          projectId: "revvai-1b45f",
        ))
      : await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RevvAi',
      home: Home(
        title: 'HomePage',
        verificationid: '',
      ),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/splash_screen',
      routes: {
        '/splash_screen': (context) => const splash(),
        '/mobile_no': (context) => const MyApp(),
        '/registration': (context) => WelcomeScreen(),
        '/otp': (context) => Home(
              title: 'HomePage',
              verificationid: '',
            ),
      },
    );
  }
}
