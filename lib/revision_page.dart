import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:revvai/revision_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Revision extends StatefulWidget {
  const Revision({super.key});

  @override
  State<Revision> createState() => _RevisionState();
}

class _RevisionState extends State<Revision> {
  User? user = FirebaseAuth.instance.currentUser;
  String secondString = "00", minutesString = "00";
  int minutes = 0, seconds = 0;
  List data = [];
  Map<String, dynamic>? content;
  int totalScore = 0;
  int allAnswered = 0;
  int totalQuestions = 0;
  late int page;
  List<Map<String, dynamic>> subjects = [];
  bool isQuestion = false;

  @override
  void initState() {
    super.initState();
    page = 0;
    allocationForTopics(context);
  }

  void strtimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      startsec();
    });
  }

  void startsec() {
  if (!context.mounted) return;
    setState(() {
      if (seconds < 59) {
        seconds++;
        secondString = seconds.toString();
        if (secondString.length == 1) {
          secondString = "0" + secondString;
        }
      } else {
        startmin();
      }
    });
  }

  void startmin() {
    setState(() {
      seconds = 0;
      secondString = "00";
      minutes++;
      minutesString = minutes.toString();
      if (minutesString.length == 1) {
        minutesString = "0" + minutesString;
      }
    });
  }

  allocationForTopics(context) async {
    try {
      if (page == 0) {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection("users")
          .doc(user!.uid)
          .collection("topics")
          .where(FieldPath.documentId, isNotEqualTo: 'RevisionTopics')
          .get();

      List<DocumentSnapshot> allDocuments = querySnapshot.docs;
      allDocuments.shuffle();

      List<DocumentSnapshot> randomDocuments = allDocuments.take(6).toList();

      for (var element in randomDocuments) {
        Map<String, dynamic> data = element.data() as Map<String, dynamic>;
        subjects.add({
          "topic": element.id,
          "type": data["type"],
        });
      }
    }

    // String type = "Reading Material";
    // if (subjects[page]["type"] == 0) {
    //   type = 'Reading Material';
    // }
    // if (subjects[page]["type"] == 1) {
    //   type = 'Real-life Examples and Previous Year Questions';
    // }
    // if (subjects[page]["type"] == 2) {
    //   type = 'Quizzes';
    // }

    data = await generateContentForTopic(
        subjects[page]["topic"], subjects[page]["type"]);
    setState(() {
      content = jsonDecode(data[0]);
      data[2] == 2 ? totalQuestions = 10 : totalQuestions = 5;
    });
    print(content);
    if (page == 0) {
      strtimer();
    }
    } catch (e) {
      return showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: const Color(0xFFFFD740),
                    title: const Align(
                        alignment: Alignment.center,
                        child: Text("UnExpected Error")),
                    content: Text(
                        "There was an unexpected error.\nError : $e \nPlease try again"),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 47, 128, 236),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                "Revision",
                style: TextStyle(
                    color: Colors.white, fontFamily: "lato", fontSize: 20),
              ),
              const SizedBox(
                width: 120,
              ),
              Text(
                "$minutesString:$secondString",
                style: const TextStyle(color: Colors.white),
              )
            ],
          )),
      body: content == null
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(
                    color: Colors.black,
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Generating Content\nThis may take a while!\nPlease wait...',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            )
          : Center(
              child: Column(
                textDirection: TextDirection.ltr,
                textBaseline: TextBaseline.alphabetic,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data[1],
                    softWrap: true,
                    style: const TextStyle(
                      fontFamily: "lato",
                      fontSize: 30,
                    ),
                  ),
                  data[2] == 0
                      ? Expanded(
                          child: ListView.builder(
                            itemCount: content!.length,
                            itemBuilder: (context, index) {
                              final key = content!.keys.toList()[index];
                              final value = content![key];

                              if (key == "short-quizze") {
                                return Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        "Short Quizze",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          backgroundColor:
                                              Color.fromARGB(235, 252, 207, 73),
                                        ),
                                      ),
                                    ),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: value.length,
                                      itemBuilder: (context, index) {
                                        isQuestion = true;
                                        int questionNumber = index + 1;
                                        final question =
                                            value[index]['question'];
                                        final options = value[index]['options'];
                                        return QuestionWidget(
                                          questionNumber: questionNumber,
                                          question: question,
                                          options: options,
                                          ans: value[index]['correct_answer'],
                                          explanation: value[index]
                                              ['explanation'],
                                          onAnswered: (isCorrect) {
                                            setState(() {
                                              allAnswered++;
                                              if (isCorrect) {
                                                totalScore++;
                                              }
                                            });
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                );
                              } else if (key == "material") {
                                return Column(
                                  children: [
                                    const Padding(
                                      padding: EdgeInsets.all(8.0),
                                      child: Text(
                                        "Reading Material",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          backgroundColor:
                                              Color.fromARGB(235, 252, 207, 73),
                                        ),
                                      ),
                                    ),
                                    ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: value!.length,
                                      itemBuilder: (context, index) {
                                        String sectionTitle =
                                            value!.keys.elementAt(index);
                                        dynamic sectionContent =
                                            value![sectionTitle];
                                        return ListTile(
                                          title: Text(
                                            sectionTitle,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                          subtitle: sectionContent != null
                                              ? Text(sectionContent)
                                              : const Text("NA"),
                                        );
                                      },
                                    ),
                                  ],
                                );
                              }

                              return const SizedBox.shrink();
                            },
                          ),
                        )
                      : data[2] == 1
                          ? Expanded(
                              child: ListView.builder(
                                itemCount: content!.length,
                                itemBuilder: (context, index) {
                                  final key = content!.keys.toList()[index];
                                  final value = content![key];

                                  if (key == "previous_year_questions") {
                                    return Column(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "Previous Year Questions",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              backgroundColor: Color.fromARGB(
                                                  235, 252, 207, 73),
                                            ),
                                          ),
                                        ),
                                        ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: value.length,
                                          itemBuilder: (context, index) {
                                            isQuestion = true;
                                            int questionNumber = index + 1;
                                            final question =
                                                value[index]['question'];
                                            final options =
                                                value[index]['options'];
                                            return QuestionWidget(
                                              questionNumber: questionNumber,
                                              question: question,
                                              options: options,
                                              ans: value[index]
                                                  ['correct_answer'],
                                              explanation: value[index]
                                                  ['explanation'],
                                              onAnswered: (isCorrect) {
                                                setState(() {
                                                  allAnswered++;
                                                  if (isCorrect) {
                                                    totalScore++;
                                                  }
                                                });
                                              },
                                            );
                                          },
                                        ),
                                      ],
                                    );
                                  } else if (key == "real-life_examples") {
                                    return Column(
                                      children: [
                                        const Padding(
                                          padding: EdgeInsets.all(8.0),
                                          child: Text(
                                            "Real-Life Examples",
                                            style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              backgroundColor: Color.fromARGB(
                                                  235, 252, 207, 73),
                                            ),
                                          ),
                                        ),
                                        ListView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          itemCount: value.length,
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                              title: Text(
                                                "${index + 1}) ${value[index]}",
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    );
                                  }

                                  return const SizedBox.shrink();
                                },
                              ),
                            )
                          : Expanded(
                              child: ListView.builder(
                                itemCount: content!.length,
                                itemBuilder: (context, index) {
                                  final key = content!.keys.toList()[index];
                                  final value = content![key];

                                  return Column(
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                          "Quizze",
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            backgroundColor: Color.fromARGB(
                                                235, 252, 207, 73),
                                          ),
                                        ),
                                      ),
                                      ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemCount: value.length,
                                        itemBuilder: (context, index) {
                                          isQuestion = true;
                                          int questionNumber = index + 1;
                                          final question =
                                              value[index]['question'];
                                          final options =
                                              value[index]['options'];
                                          return QuestionWidget(
                                            questionNumber: questionNumber,
                                            question: question,
                                            options: options,
                                            ans: value[index]['correct_answer'],
                                            explanation: value[index]
                                                ['explanation'],
                                            onAnswered: (isCorrect) {
                                              setState(() {
                                                allAnswered++;
                                                if (isCorrect) {
                                                  totalScore++;
                                                }
                                              });
                                            },
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                ],
              ),
            ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(08),
        child: ElevatedButton(
          onPressed: () {
            if (allAnswered < totalQuestions && isQuestion == true) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: const Color(0xFFFFD740),
                    title: const Align(
                        alignment: Alignment.center,
                        child: Text("Questions Incomplete")),
                    content: const Text(
                        "Please answer all the questions first and then submit."),
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
            } else {
              if (page < 5) {
                double sc = totalScore.toDouble();
                setState(() {
                  page++;
                  content = null;
                  allAnswered = 0;
                  totalScore = 0;
                });
                allocationForTopics(context);
                proficiency((sc / totalQuestions) * 10, data[1], isQuestion);
              } else {
                proficiency(
                    (totalScore / totalQuestions) * 10, data[1], isQuestion);
                Navigator.pop(context);
              }
            }
          },
          style: const ButtonStyle(
            alignment: Alignment.center,
            backgroundColor: MaterialStatePropertyAll(
              Color.fromARGB(255, 47, 128, 236),
            ),
          ),
          child: Text(
            page < 5 ? "Next" : "Done",
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}

class QuestionWidget extends StatefulWidget {
  final int questionNumber;
  final String question;
  final List options;
  final String ans;
  final String explanation;
  final Function(bool)? onAnswered;

  const QuestionWidget({
    super.key,
    required this.questionNumber,
    required this.question,
    required this.options,
    required this.ans,
    required this.explanation,
    required this.onAnswered,
  });

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  String? selectedOption;
  bool answered = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            "${widget.questionNumber}. ${widget.question}",
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Column(
          children: widget.options.map((option) {
            return RadioListTile(
              activeColor: const Color.fromARGB(255, 47, 128, 236),
              title: Text(option),
              value: option,
              groupValue: selectedOption,
              onChanged: (value) {
                setState(() {
                  if (!answered) {
                    selectedOption = value as String;
                    answered = true;
                    if (widget.onAnswered != null) {
                      widget.onAnswered!(selectedOption == widget.ans);
                    }
                  }
                });
              },
            );
          }).toList(),
        ),
        answered
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  children: [
                    Text(
                      'Your answer is : ${selectedOption == widget.ans ? "Correct" : "Incorrect"}',
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color.fromARGB(255, 47, 128, 236)),
                    ),
                    const Text(
                      "explanation",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(widget.explanation),
                  ],
                ),
              )
            : const SizedBox.shrink(),
        const SizedBox(
          height: 10,
        )
      ],
    );
  }
}
