import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:revvai/login/login_screen.dart';
import 'package:revvai/login/registration_screen.dart';
import 'package:revvai/provider/app_provider.dart';
import 'package:revvai/splash_screen.dart';

void main() async {
  await dotenv.load();
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid
      ? await Firebase.initializeApp(
          options: const FirebaseOptions(
          apiKey: "AIzaSyBZ-fO8AwjpacuD-MgVW-tAo_4Z3hrT0DA",
          appId: "1:521929180258:android:3486d774d5b88f6a5b7d3b",
          messagingSenderId: "521929180258",
          projectId: "revvai",
        ))
      : await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider(),
      child: MaterialApp(
        title: 'RevvAi',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/splash_screen',
        routes: {
          '/splash_screen': (context) => const SplashScreen(),
          '/login': (context) => const LoginScreen(),
          '/registration': (context) => const WelcomeScreen(),
          
        },
      ),
    );
  }
}
