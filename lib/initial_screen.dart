import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revvai/edit_topics_screen.dart';
import 'package:revvai/page_navigator.dart';
import 'package:revvai/provider/app_provider.dart';

class InitialScreen extends StatefulWidget {
  final bool newRegister;
  const InitialScreen({super.key, required this.newRegister});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  @override
  Widget build(BuildContext context) {
    Provider.of<AppProvider>(context).fetchData();
    return Scaffold(
      body: Center(
        child: AlertDialog(
          backgroundColor: const Color(0xFFFFD740),
          title: const Align(
              alignment: Alignment.center, child: Text("Select Topics")),
          content: Text(
              widget.newRegister
                ? "Hello, Let us know what you revised yesterday by selecting the topics you revised.\nPlease select at least 6 topics": "Hello, Let us know what you revised yesterday by selecting the topics you revised." ),
          actions: [
            widget.newRegister
                ? const SizedBox.shrink()
                : ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Navigation()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    child: const Text(
                      "Skip",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TopicSelection(newRegister: widget.newRegister,)),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: const Text(
                "Next",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
