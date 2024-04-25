import "package:flutter/material.dart";
// import "package:google_fonts/google_fonts.dart";

class AssistanceScreen extends StatefulWidget {
  const AssistanceScreen({Key? key}) : super(key: key);

  @override
  State<AssistanceScreen> createState() => _AssistanceScreenState();
}

class _AssistanceScreenState extends State<AssistanceScreen> {
  int myIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back),
              color: Colors.black,
              iconSize: 30,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            const Text(
              'Assistance',
              // style: GoogleFonts.lato(
              //   fontSize: 28.0,
              //   color: Colors.white,
              // ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF2F80EC),
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30), // Adjust the value as needed
          ),
        ),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Get assistance with the topics',
              // style: GoogleFonts.lato(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Text(
              'you learn',
              // style: GoogleFonts.lato(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0), // Adding some space between the lines
            Text(
              'COMING SOON...',
              // style: GoogleFonts.lato(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
