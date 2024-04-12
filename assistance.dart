import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int myIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.arrow_back),
              color: Colors.black,
              iconSize: 30,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            Text(
              'Assistance',
              style: GoogleFonts.lato(
                fontSize: 28.0,
                color: Colors.white,
              ),
            ),
          ],
        ),
        backgroundColor: Color(0xFF2F80EC),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30), // Adjust the value as needed
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Get assistance with the topics',
              style: GoogleFonts.lato(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            Text(
              'you learn',
              style: GoogleFonts.lato(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20.0), // Adding some space between the lines
            Text(
              'COMING SOON...',
              style: GoogleFonts.lato(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.black,
        selectedLabelStyle: TextStyle(color: Colors.black, fontFamily: "lato"),
        backgroundColor: Color.fromARGB(255, 47, 128, 236),
        iconSize: 30,
        type: BottomNavigationBarType.fixed,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        onTap: (index) {
          setState(() {
            myIndex = index;
          });
        },
        currentIndex: myIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.black),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.analytics, color: Colors.black),
            label: "Analytics",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.message, color: Colors.black),
            label: "Assistance",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list, color: Colors.black),
            label: "Sessions",
          ),
        ],
      ),
    );
  }
}
