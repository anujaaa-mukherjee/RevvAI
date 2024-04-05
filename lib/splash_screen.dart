//splash screen

import 'package:flutter/material.dart';
// import 'package:revvai/mobileno.dart';
import 'package:revvai/user_status.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<splash> {
  @override
  void initState() {
    super.initState();
    _navigatetohome();
  }

  _navigatetohome() async {
    await Future.delayed(Duration(seconds: 2), () {});
    Navigator.pushReplacement(context as BuildContext,
        MaterialPageRoute(builder: (context) => start()));
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Image(
      image: AssetImage('assets/images/revv.png'),
    )));
  }
}
