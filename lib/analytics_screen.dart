import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:fl_chart/fl_chart.dart";

class AnalyticsScreen extends StatefulWidget {
  const AnalyticsScreen({super.key});

  @override
  State<AnalyticsScreen> createState() => _AnalyticsScreenState();
}

class _AnalyticsScreenState extends State<AnalyticsScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final double mathsValue = 40.0;
  final double scienceValue = 6.0;
  final double chemistryValue = 8.0;
  List<String> topThree = [];
  List<String> lastThree = [];

  fetchData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .collection("topics")
        .where(FieldPath.documentId, isNotEqualTo: 'RevisionTopics')
        .get();

     List<DocumentSnapshot> allDocuments = querySnapshot.docs;
      allDocuments.shuffle();

      List<DocumentSnapshot> randomDocuments = allDocuments.take(6).toList();


    final topThreeDocs = randomDocuments.sublist(randomDocuments.length - 3);
    final lastThreeDocs = randomDocuments.sublist(0, 3);

    for (var element in topThreeDocs) {
      print(element.id);
      setState(() {
        topThree.add(element.id);
      });
    }
    for (var element in lastThreeDocs) {
      print(element.id);
      setState(() {
        lastThree.add(element.id);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Colors.blue, // Set the app bar background color to blue
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.black, // Set the back arrow color to black
            size: 28, // Make the back arrow bold
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Analytics",
          style: TextStyle(
            color: Colors.white, // Set the title text color to white
            fontWeight: FontWeight.bold, // Make the title text bold
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(
                15), // Rounded edges at the bottom of the app bar
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                "Your Progress bar>",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              // Yellow box with smooth edges and bar chart
              Container(
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(12.0), // Smooth edges
                ),
                padding: const EdgeInsets.all(20.0),
                height: 250,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.center,
                    maxY: 100,
                    minY: 0,
                    barGroups: [
                      // Maths bar
                      BarChartGroupData(
                        x: 0,
                        barRods: [
                          BarChartRodData(
                            toY: mathsValue,
                            color: Colors.blue[400],
                          ),
                        ],
                      ),
                      // Science bar
                      BarChartGroupData(
                        x: 1,
                        barRods: [
                          BarChartRodData(
                            toY: scienceValue,
                            color: Colors.green[400],
                          ),
                        ],
                      ),
                      // Chemistry bar
                      BarChartGroupData(
                        x: 2,
                        barRods: [
                          BarChartRodData(
                            toY: chemistryValue,
                            color: Colors.red,
                          ),
                        ],
                      ),
                    ],
                    groupsSpace: 60, // Sets the space between groups of bars
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: 20,
                          reservedSize: 40,
                          getTitlesWidget: (value, TitleMeta a) =>
                              Text("${value.toInt()}%"),
                        ),
                      ),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (value, TitleMeta a) {
                            switch (value.toInt()) {
                              case 0:
                                return const Text("Maths");
                              case 1:
                                return const Text("Physics");
                              case 2:
                                return const Text("Chemistry");
                              default:
                                return const Text("");
                            }
                          },
                        ),
                      ),
                    ),
                    gridData: FlGridData(
                      drawHorizontalLine: true,
                      horizontalInterval: 20,
                      getDrawingHorizontalLine: (value) => FlLine(
                        color: Colors.grey.withOpacity(0.5),
                        dashArray: [5, 5], // Dotted line
                        strokeWidth: 1,
                      ),
                      drawVerticalLine: false,
                    ),
                    borderData: FlBorderData(show: false),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Strengths box
              Container(
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: const EdgeInsets.all(8.0),
                // height: 200,
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Center content vertically
                  crossAxisAlignment:
                      CrossAxisAlignment.center, // Center content horizontally
                  children: [
                    // Title
                    const Text(
                      "Strengths ",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold, // Center the title text
                      ),
                    ),
                    const SizedBox(height: 8), // Space between title and content
                    // Content
                    topThree.isEmpty
                        ? const SizedBox()
                        : bulletPointText("Your ${topThree[0]} is good"),
                    topThree.isEmpty
                        ? const SizedBox()
                        : bulletPointText("Your ${topThree[1]} is good"),
                    topThree.isEmpty
                        ? const SizedBox()
                        : bulletPointText("Your ${topThree[2]} is good"),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Weaknesses box
              Container(
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                padding: const EdgeInsets.all(8.0),
                // height: 200,
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center, // Center content vertically
                  crossAxisAlignment:
                      CrossAxisAlignment.center, // Center content horizontally
                  children: [
                    // Title
                    const Text(
                      "Weaknesses ",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold, // Center the title text
                      ),
                    ),
                    const SizedBox(height: 8),
                    lastThree.isEmpty
                        ? const SizedBox()
                        : bulletPointText(
                            "Your ${lastThree[0]} needs improvement"),
                    lastThree.isEmpty
                        ? const SizedBox()
                        : bulletPointText(
                            "Your ${lastThree[1]} needs improvement"),
                    lastThree.isEmpty
                        ? const SizedBox()
                        : bulletPointText(
                            "Your ${lastThree[2]} needs improvement"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Function to create bullet point text
  Widget bulletPointText(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Center the row
        children: [
          const Text(
            '\u2022 ', // Unicode for bullet point
            textAlign: TextAlign.end,
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
          Expanded(
            child: Text(
              text,
              textAlign: TextAlign.center,
              softWrap: true,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
