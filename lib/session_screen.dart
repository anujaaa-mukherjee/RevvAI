import "package:cloud_firestore/cloud_firestore.dart";
import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

class SessionScreen extends StatefulWidget {
  const SessionScreen({super.key});

  @override
  State<SessionScreen> createState() => _SessionScreenState();
}

class _SessionScreenState extends State<SessionScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final List mathsTopics = [];
  final List physicsTopics = [];
  final List chemTopics = [];

  fetchData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .collection("topics")
        .get();

    for (var element in querySnapshot.docs) {
      print(element.data());
      Map<String, dynamic> data = element.data() as Map<String, dynamic>;
      if (data["subject"] == "physics") {
        setState(() {
          physicsTopics.add(element.id);
        });
      }
      if (data["subject"] == "chemistry") {
        setState(() {
          chemTopics.add(element.id);
        });
      }
      if (data["subject"] == "maths") {
        setState(() {
          mathsTopics.add(element.id);
        });
      }
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
          backgroundColor: Colors.blue,
          title: const Text(
            "Previous Sessions",
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w500, fontSize: 30),
          ),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 15,
                ),
                const Text(
                  "Lets take a look at what topic you have learnt previously",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 27),
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 220,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.yellow,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Maths >",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 27),
                        ),
                        mathsTopics.isEmpty
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                ),
                              )
                            : Expanded(
                                child: ListView.builder(
                                    itemCount: mathsTopics.length,
                                    itemBuilder: (context, index) {
                                      int index2 = index + 1;
                                      return Text(
                                        "Topic " +
                                            index2.toString() +
                                            ": " +
                                            mathsTopics[index],
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 27),
                                      );
                                    }),
                              ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 220,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.yellow,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Physics >",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 27),
                        ),
                        physicsTopics.isEmpty
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                ),
                              )
                            :Expanded(
                          child: ListView.builder(
                              itemCount: physicsTopics.length,
                              itemBuilder: (context, index) {
                                int index2 = index + 1;
                                return Text(
                                  "Topic " +
                                      index2.toString() +
                                      ": " +
                                      physicsTopics[index],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 27),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 220,
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: Colors.yellow,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Chemistry >",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 27),
                        ),
                        chemTopics.isEmpty
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                ),
                              )
                            :Expanded(
                          child: ListView.builder(
                              itemCount: chemTopics.length,
                              itemBuilder: (context, index) {
                                int index2 = index + 1;
                                return Text(
                                  "Topic " +
                                      index2.toString() +
                                      ": " +
                                      chemTopics[index],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 27),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
