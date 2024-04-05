import 'dart:async';
import 'package:flutter/material.dart';

class Revision extends StatefulWidget {
  const Revision({super.key});

  @override
  State<Revision> createState() => _RevisionState();
}

class _RevisionState extends State<Revision> {
  String secondString = "00", minutesString = "00";
  int minutes = 0, seconds = 0;
  @override
  void initState() {
    super.initState();
    strtimer();
  }

  void strtimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      startsec();
    });
  }

  void startsec() {
    setState(() {
      if (seconds < 59) {
        seconds++;
        secondString = seconds.toString();
        if (secondString.length == 1) {
          secondString = "0" + secondString;
        }
      } else {
        startmin();
      }
    });
  }

  void startmin() {
    setState(() {
      seconds = 0;
      secondString = "00";
      minutes++;
      minutesString = minutes.toString();
      if (minutesString.length == 1) {
        minutesString = "0" + minutesString;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 47, 128, 236),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Revision",
                style: TextStyle(
                    color: Colors.white, fontFamily: "lato", fontSize: 30),
              ),
              const SizedBox(
                width: 120,
              ),
              Text(
                "$minutesString:$secondString",
                style: const TextStyle(color: Colors.white),
              )
            ],
          )),
      body: const Center(
        child: Column(
          textDirection: TextDirection.ltr,
          textBaseline: TextBaseline.alphabetic,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "data",
              style: TextStyle(fontFamily: "lato", fontSize: 30),
            )
          ],
        ),
      ),
    );
  }
}
