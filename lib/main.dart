import 'package:flutter/material.dart';
import 'package:revvai/registration_screen.dart';
import 'package:revvai/otp_screen.dart';
import 'package:revvai/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
      ),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/splash_screen',
      routes: {
        '/splash_screen': (context) => splash(),
        '/mobile_no': (context) => MyApp(),
        '/registration': (context) => WelcomeScreen(),
        '/otp': (context) => Home(
              title: 'HomePage',
            ),
      },
    );
  }
}
