import "package:flutter/material.dart";
import "package:revvai/revision_page.dart";
import "package:flutter/src/widgets/bottom_navigation_bar_item.dart";

class Homepage extends StatefulWidget {
  const Homepage({super.key, required String title});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int myIndex = 0;
  List<Widget> widgetList = const [
    Homepage(title: "Home"),
    // analytics screen
    // Assistance screen
    // Sessions screen
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 80, left: 3),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '     Hello (name)!',
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'lato'),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "      Let's begin learning...",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Lato'),
                ),
                // SizedBox(
                //   width: 50,
                //   height: 20,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //   // crossAxisAlignment: CrossAxisAlignment.end,
                //   children: [Icon(Icons.account_circle)],
                // ),
              ],
            ),
            const SizedBox(height: 25),
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Start Revision',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "lato",
                          fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor:
                            const Color.fromARGB(255, 47, 128, 236),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 115, vertical: 10)),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Previous Sessions',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "lato",
                          fontSize: 20),
                    ),
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor:
                            const Color.fromARGB(255, 47, 128, 236),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 100, vertical: 10)),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Add topics to Revision',
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "lato",
                          fontSize: 16),
                    ),
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      backgroundColor: const Color.fromARGB(255, 47, 128, 236),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 100, vertical: 12),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Center(
                child: Container(
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 254, 215, 76),
                        borderRadius: BorderRadius.circular(30)),
                    height: 400,
                    width: 350,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        const Text(
                          "View all Course details",
                          style: TextStyle(
                              fontFamily: "lato",
                              fontSize: 27,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                minimumSize: const Size(5, 70),
                                side: const BorderSide(
                                    color: Color.fromARGB(255, 130, 187, 233)),
                                backgroundColor:
                                    const Color.fromARGB(255, 47, 128, 236),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 24),
                              ),
                              onPressed: () {},
                              child: const Text(
                                '''  Maths 
5 Modules''',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: "lato"),
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                minimumSize: const Size(5, 70),
                                side: const BorderSide(
                                    color: Color.fromARGB(255, 130, 187, 233)),
                                backgroundColor:
                                    const Color.fromARGB(255, 47, 128, 236),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 24),
                              ),
                              onPressed: () {},
                              child: const Text('''  Physics 
5 Modules''',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontFamily: "lato")),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10))),
                                  minimumSize: const Size(5, 70),
                                  side: const BorderSide(
                                      color:
                                          Color.fromARGB(255, 130, 187, 233)),
                                  backgroundColor:
                                      const Color.fromARGB(255, 47, 128, 236),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 25),
                                ),
                                onPressed: () {},
                                child: const Text(
                                  ''' Chemistry 
8 Modules''',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontFamily: "lato"),
                                )),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                                minimumSize: const Size(5, 70),
                                side: const BorderSide(
                                    color: Color.fromARGB(255, 130, 187, 233)),
                                backgroundColor:
                                    const Color.fromARGB(255, 47, 128, 236),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 12),
                              ),
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Revision(),
                                    ));
                              },
                              child: const Text(
                                '''   Quiz & 
Question 
   banks''',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontFamily: "lato"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    )),
              ),
            ),
            const SizedBox(
              height: 1,
            ),
          ],
        ),
      ),
      // extendBody: true,

      // IndexedStack(
      //   index: myIndex,
      //   children: widgetList,
      // ),
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
