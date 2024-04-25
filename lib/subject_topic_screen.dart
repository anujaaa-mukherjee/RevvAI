import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SubjectTopicsScreen extends StatefulWidget {
  final String subject;
  const SubjectTopicsScreen({super.key, required this.subject});

  @override
  State<SubjectTopicsScreen> createState() => _SubjectTopicsScreenState();
}

class _SubjectTopicsScreenState extends State<SubjectTopicsScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  List<Map<String, dynamic>> data = [];
  List<String> topics = [];

  fetchData() async {
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .collection("topics")
        .where("subject", isEqualTo: widget.subject)
        .get();

    for (var element in querySnapshot.docs) {
      print(element.data());
      setState(() {
        data.add(element.data() as Map<String, dynamic>);
        topics.add(element.id);
      });
      print(data);
      print(topics);
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
        backgroundColor: const Color.fromARGB(255, 47, 128, 236),
        title: Text(
          widget.subject,
          style: const TextStyle(
              color: Colors.white, fontFamily: "lato", fontSize: 20),
        ),
      ),
      body: data.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Colors.black,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Please wait...',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: ((context, index) {
                return InkWell(
                  onTap: () {
                    showPopUp(data[index], topics[index], context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(08),
                    child: Container(
                      height: 50,
                      width: 100,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFFD740),
                        borderRadius: BorderRadius.all(
                           Radius.circular(30),
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          topics[index],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                );
              })),
    );
  }

  showPopUp(Map<String, dynamic> data, String topic, context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFFFD740),
          title: Align(alignment: Alignment.center, child: Text(topic)),
          content: ListView.builder(
              shrinkWrap: true,
              itemCount: data.length,
              itemBuilder: (context, index) {
                String sectionTitle = data.keys.elementAt(index);
                dynamic sectionContent = data[sectionTitle];
                return Padding(
                  padding: const EdgeInsets.all(4),
                  child: Column(children: [
                    Text(
                      sectionTitle,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    sectionContent != null
                        ? Text(sectionContent.toString())
                        : const Text("NA"),
                  ]),
                );
              }),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: const Text(
                "OK",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
