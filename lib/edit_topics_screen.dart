import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:revvai/page_navigator.dart';

class TopicSelection extends StatefulWidget {
  final bool newRegister;
  const TopicSelection({super.key, required this.newRegister});

  @override
  _TopicSelectionState createState() => _TopicSelectionState();
}

class _TopicSelectionState extends State<TopicSelection> {
  String? selectedSubject;
  String? selectedTopic;
  final TextEditingController _textFieldController = TextEditingController();
  late Map<String, List<String>> subjectsAndTopics;
  Set<String> physics = <String>{};
  Set<String> maths = <String>{};
  Set<String> chemistry = <String>{};
  int totalTopics = 0;

  bool isEditingTopics = false;
  User? user = FirebaseAuth.instance.currentUser;

  addTopics(String topic) {
    if (selectedSubject == "Physics") {
      physics.add(topic);
      totalTopics++;
    }
    if (selectedSubject == "Chemistry") {
      chemistry.add(topic);
      totalTopics++;
    }
    if (selectedSubject == "Mathematics") {
      maths.add(topic);
      totalTopics++;
    }
  }

  fetchDocumentAndFilterTopics() async {
    try {
      DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .collection("topics")
          .doc("RevisionTopics")
          .get();

      if (documentSnapshot.exists) {
        List<dynamic>? physicsArray = documentSnapshot.get('physics');
        List<dynamic>? mathsArray = documentSnapshot.get('maths');
        List<dynamic>? chemistryArray = documentSnapshot.get('chemistry');

        subjectsAndTopics.forEach((subject, topics) {
          List<String> copyOfTopics = List<String>.from(topics);
          subjectsAndTopics[subject] = copyOfTopics
              .where((topic) =>
                  !physicsArray!.contains(topic) &&
                  !mathsArray!.contains(topic) &&
                  !chemistryArray!.contains(topic))
              .toList();
        });

        print('Updated Subjects and Topics: $subjectsAndTopics');
      }
    } catch (e) {
      print('Error fetching document: $e');
    }
  }

  storeTopics() async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .collection("topics")
        .doc("RevisionTopics")
        .get();

    if (documentSnapshot.exists) {
      FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .collection("topics")
          .doc("RevisionTopics")
          .update({
        "physics": FieldValue.arrayUnion(physics.toList()),
        "maths": FieldValue.arrayUnion(maths.toList()),
        "chemistry": FieldValue.arrayUnion(chemistry.toList()),
      });
    } else {
      FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .collection("topics")
          .doc("RevisionTopics")
          .set({
        "physics": physics.toList(),
        "maths": maths.toList(),
        "chemistry": chemistry.toList(),
      });
    }

    final topics = {
      "physics": physics,
      "maths": maths,
      "chemistry": chemistry,
    };

    final batch = FirebaseFirestore.instance.batch();

    topics.forEach((subject, subjectTopics) {
      for (var topic in subjectTopics) {
        print(topic);
        print(subject);
        final docRef = FirebaseFirestore.instance
            .collection("users")
            .doc(user!.uid)
            .collection("topics")
            .doc(topic);

        final data = {
          "subject": subject,
          "lastRevisionDate": "",
          "nextRevisionDate": "",
          "proficiency": 0,
          "type": 0,
          "revisionCount": 0,
        };

        batch.set(docRef, data);
      }
    });

    await batch.commit();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    subjectsAndTopics = {
      "Physics": [
        "Physics and Measurement",
        "Kinematics",
        "Laws of Motion",
        "Work, Energy, and Power",
        "Rotational Motion",
        "Gravitation",
        "Properties of Solids and Liquids",
        "Thermodynamics",
        "Kinetic Theory of Gases",
        "Oscillations and Waves",
        "Electrostatics",
        "Current Electricity",
        "Magnetic Effects of Current and Magnetism",
        "Electromagnetic Induction and Alternating Currents",
        "Optics",
        "Dual Nature of Matter and Radiation",
        "Atoms and Nuclei",
        "Electronic Devices"
      ],
      "Chemistry": [
        "Some Basic Concepts in Chemistry",
        "States of Matter",
        "Atomic Structure",
        "Chemical Bonding and Molecular Structure",
        "Chemical Thermodynamics",
        "Solutions",
        "Equilibrium",
        "Redox Reactions and Electrochemistry",
        "Chemical Kinetics",
        "Hydrocarbons",
        "Haloalkanes and Haloarenes",
        "Alcohols, Phenols, and Ethers",
        "Aldehydes, Ketones, and Carboxylic Acids",
        "Amines",
        "Biomolecules",
        "Polymers",
        "Chemistry in Everyday Life",
        "Classification of Elements and Periodicity in Properties",
        "General Principles and Processes of Isolation of Metals",
        "Hydrogen",
        "S-Block Elements (Alkali and Alkaline Earth Metals)",
        "P-Block Elements",
        "D- and F-Block Elements",
        "Coordination Compounds"
      ],
      "Mathematics": [
        "Complex numbers",
        "Quadratic equations",
        "Sequences and series",
        "Permutations and combinations",
        "Binomial theorem",
        "Matrices and determinants",
        "Trigonometric functions",
        "Trigonometric equations",
        "Properties of triangles",
        "Heights and distances",
        "Straight lines",
        "Circles",
        "Conic sections",
        "Functions, limits, and continuity",
        "Differentiation",
        "Applications of derivatives",
        "Integration",
        "Differential equations",
        "Vectors",
        "Three-dimensional geometry",
        "Probability",
        "Statistics",
        "Mathematical induction",
        "Logic"
      ]
    };
    fetchDocumentAndFilterTopics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Edit topics for revision',
          // style: GoogleFonts.lato(
          //   fontSize: 28.0,
          //   fontWeight: FontWeight.bold,
          //   color: Colors.white,
          // ),
        ),
        backgroundColor: const Color(0xFF2F80EC),
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Select Subject:',
              textAlign: TextAlign.left,
              // style: GoogleFonts.lato(
              //   fontSize: 20.0,
              //   fontWeight: FontWeight.bold,
              // ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: subjectsAndTopics.keys.map<Widget>((String subject) {
              return ElevatedButton(
                onPressed: () {
                  setState(() {
                    selectedSubject = subject;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: selectedSubject == subject
                      ? const Color(0xFFFFD740)
                      : Colors.white,
                ),
                child: Text(subject),
              );
            }).toList(),
          ),
          if (selectedSubject != null)
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Select Topic for $selectedSubject:',
                    // style: GoogleFonts.lato(
                    //   fontSize: 20,
                    //   fontWeight: FontWeight.bold,
                    // ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TypeAheadField<String?>(
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: _textFieldController,
                        decoration: const InputDecoration(
                          hintText: 'Select or search a topic',
                        ),
                      ),
                      suggestionsCallback: (pattern) {
                        return subjectsAndTopics[selectedSubject!]!
                            .where(
                              (topic) => topic
                                  .toLowerCase()
                                  .contains(pattern.toLowerCase()),
                            )
                            .toList();
                      },
                      itemBuilder: (context, suggestion) {
                        return ListTile(
                          title: Text(suggestion!),
                        );
                      },
                      onSuggestionSelected: (suggestion) {
                        setState(() {
                          selectedTopic = suggestion;
                          addTopics(selectedTopic!);
                          setState(() {
                            _textFieldController.clear();
                          });
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 16),
          if (isEditingTopics)
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    '',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: const Size(320, 40),
                    ),
                    child: const Text(
                      'Cancel',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            backgroundColor: const Color(0xFFFFD740),
                            title: const Text('Confirmation'),
                            content: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                      'Are you sure you want to confirm the selected topics :'),
                                  const SizedBox(height: 10),
                                  const Text(
                                    "Physics",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(physics.toList().join("\n")),
                                  const Text(
                                    "Chemistry",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(chemistry.toList().join("\n")),
                                  const Text(
                                    "Maths",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(maths.toList().join("\n")),
                                ],
                              ),
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    isEditingTopics = true;
                                  });
                                  Navigator.of(context).pop();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                ),
                                child: const Text(
                                  'Edit Topics',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (totalTopics < 6 && widget.newRegister) {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          backgroundColor:
                                              const Color(0xFFFFD740),
                                          title: const Align(
                                              alignment: Alignment.center,
                                              child: Text("Insufficient Data")),
                                          content: const Text(
                                              "Please select at least 6 topics to procced further."),
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
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  } else {
                                    Navigator.of(context).pop();
                                    storeTopics();
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const Navigation(),
                                      ),
                                    );
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue,
                                ),
                                child: const Text(
                                  'Confirm',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: const Size(320, 40),
                    ),
                    child: const Text(
                      'Done',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
