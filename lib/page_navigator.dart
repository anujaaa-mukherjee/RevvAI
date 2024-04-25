import "package:flutter/material.dart";
import "package:revvai/analytics_screen.dart";
import "package:revvai/assistance_screen.dart";
import "package:revvai/home_screen.dart";
import "package:revvai/session_screen.dart";

class Navigation extends StatefulWidget {
  const Navigation({super.key});

  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int myIndex = 0;
  List<Widget> pageList = const [
    HomePage(),
    AnalyticsScreen(),
    AssistanceScreen(),
    SessionScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pageList[myIndex],
      bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.black,
          selectedLabelStyle:
              const TextStyle(color: Colors.black, fontFamily: "lato"),
          backgroundColor: const Color.fromARGB(255, 47, 128, 236),
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
              icon: Icon(
                Icons.home,
                color: Colors.black,
              ),
              label: "Home",
            ),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.analytics,
                  color: Colors.black,
                ),
                label: "Analytics"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.message,
                  color: Colors.black,
                ),
                label: "Assistance"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.list,
                  color: Colors.black,
                ),
                label: "Sessions"),
          ]),
    );
  }
}
