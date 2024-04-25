import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:revvai/edit_topics_screen.dart';
import 'package:revvai/profile.dart';
import 'package:revvai/provider/app_provider.dart';
import 'package:revvai/revision_page.dart';
import 'package:revvai/subject_topic_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50),
        child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Hello ${Provider.of<AppProvider>(context, listen: true).data.name}!',
                          style: const TextStyle(
                              overflow: TextOverflow.fade,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'lato'),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "Let's begin learning...",
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
                    InkWell(
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfileScreen(),
                        ),
                      ),
                      child: const Icon(
                        Icons.account_circle,
                        size: 50,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              Center(
                child: Column(
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Revision(),
                            ));
                      },
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          backgroundColor:
                              const Color.fromARGB(255, 47, 128, 236),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 115, vertical: 10)
                          ),
                      child: const Text(
                        'Start Revision',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "lato",
                            fontSize: 20),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          backgroundColor:
                              const Color.fromARGB(255, 47, 128, 236),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 100, vertical: 10)),
                      child: const Text(
                        'Previous Sessions',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "lato",
                            fontSize: 20),
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TopicSelection(
                              newRegister: false,
                            ),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        backgroundColor: const Color.fromARGB(255, 47, 128, 236),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 100, vertical: 12),
                      ),
                      child: const Text(
                        'Add topics to Revision',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "lato",
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Center(
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(255, 254, 215, 76),
                          borderRadius: BorderRadius.circular(30)),
                      // height: 390,
                      // width: 340,
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
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SubjectTopicsScreen(
                                              subject: "maths"),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Maths \nModules",
                                  textAlign: TextAlign.center,
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
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const SubjectTopicsScreen(
                                              subject: "physics"),
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Physics \nModules",
                                  textAlign: TextAlign.center,
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
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const SubjectTopicsScreen(
                                                subject: "chemistry"),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Chemistry \nModules",
                                  textAlign: TextAlign.center,
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
                                onPressed: () {},
                                child: const Text(
                                  'Quiz &\nQuestion\nbanks',
                                  textAlign: TextAlign.center,
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
      ),
    );
  }
}
