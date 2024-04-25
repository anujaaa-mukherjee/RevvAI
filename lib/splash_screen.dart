import 'package:flutter/material.dart';
import 'package:revvai/user_status.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(const Duration(seconds: 2), () {});
    if (!context.mounted) return;
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context) => const AuthStateCkeck()));
  }
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
            child: Image(
      image: AssetImage('assets/images/revv.png'),
    )));
  }
}
