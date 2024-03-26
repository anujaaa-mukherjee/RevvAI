import "package:flutter/material.dart";

class Homepage extends StatefulWidget {
  const Homepage({super.key, required String title});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("RevvAI"),
        titleTextStyle: const TextStyle(
          color: Colors.blueAccent,
          fontSize: 35.0,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: const Center(child: Text('Homepage')),
    );
  }
}
